---
date: 2025-08-09
description: "Complete Arch Linux installatiehandleiding met Btrfs, UKI, Secure Boot, TPM2 encryptie en Hyprland op mijn Dell XPS 9530. Inclusief geavanceerde optimalisaties en rclone datarecovery."
slug: "arch-linux-installatie"
draft: false
showDateOnlyInArticle : false
showHeadingAnchors : false
layoutBackgroundHeaderSpace: false
showDate: false
showViews: false
showLikes: false
showDateUpdated: false
showAuthor: false
showHero: false
heroStyle: "background"
showBreadcrumbs: false
showDraftLabel: false
showEdit: false
editAppendPath: true
seriesOpened: false
showPagination: false
invertPagination: false
showReadingTime: false
showTableOfContents: true
showTaxonomies: false
showAuthorsBadges: false
showWordCount: false
showSummary: false
sharingLinks: false
showRelatedContent: false
disableComments: true
---

{{< typeit
  tag=h1
  lifeLike=true >}}
Arch Linux Installatie: Beveiliging en Snelheid op Dell XPS 9530
{{< /typeit >}}

Tijd voor mijn Arch Linux installatie op mijn Dell XPS 9530. Geen gezeur geen onnodige extra's. We bouwen een strakke base met focus op maximale beveiliging en prestaties. Dit is wat je krijgt:

 * Partitionering en formatteren: De fundering goed geregeld.
 * LUKS2 setup met TPM2: Volledige schijfencryptie hardware-gestuurd.
 * Mounten en subvolume layout: Btrfs geoptimaliseerd.
 * Base system installatie: Alleen het noodzakelijke.
 * Chroot configuratie: De fundamenten. Sterk en stabiel.
 * UKI creatie en signing: Unified Kernel Images en Secure Boot.
 * EFI setup: Je systeem start direct, geen gedoe.
 * Snapper configuratie: Data recovery met rclone.
 * Swap en zswap activatie: Geheugenbeheer

Daarna? Een naadloze Hyprland desktop. Pure klasse.

> [!NOTE]
> Dit is voor gevorderde gebruikers of voor educatieve doeleinden.


---

## 1. Voorbereiding
- Arch Linux ISO (laatste release) op USB-stick (`dd` of `Rufus`)
- UEFI geactiveerd in BIOS
- TPM 2.0 ingeschakeld in BIOS.
- SATA/NVMe Operation: **AHCI** (in plaats van "RAID On").
- Secure Boot moet in de BIOS/UEFI op "Setup Mode" worden gezet **vóór** de installatie. Dit is vereist om je eigen Secure Boot-sleutels te kunnen registreren met `sbctl`.

## 2. Opstarten en Initiële Setup

### 2.1. Opstarten vanaf USB

1.  Plaats de Arch Linux USB-stick in de laptop.
2.  Start de laptop en druk herhaaldelijk op **F12** om het bootmenu te openen.
3.  Selecteer de USB-stick als opstartapparaat.

### 2.2. Beep uitzetten: Rust voor de ziel.
```bash
rmmod pcspkr
```

### 2.3. Wi-Fi verbinden (met iwctl)

```bash
iwctl
station wlan0 scan
station wlan0 get-networks
station wlan0 connect <SSID>
exit
```

```bash
ping 1.1.1.1 -c 4
```

### 2.4. SSH Remote Installatie (optioneel): Werk op afstand.
```bash
passwd
ip addr
systemctl start sshd
screen -S share-screen
```

SSH naar je machine:
```bash
ssh root@192.168.2.10
screen -x share-screen
```

## 3. Pre-Installatie Setup
Voordat we dieper graven, een paar belangrijke stappen.

### 3.1. Clean bestaande EFI entries indien nodig.
Weg met de rommel. Vervang X met het juiste nummer.

```bash
efibootmgr
efibootmgr -b X -B
```

### 3.2. Update GPG keys vanaf de live omgeving.
Dit is een slimme zet vóór de installatie.

```bash
pacman -Sy archlinux-keyring
```

## 4. Disk Partitioning (GPT)
Tijd om de schijf op te delen. We maken een EFI partitie en de rest gaat naar een LUKS root.

Partitioneer de schijf: EFI (500MB) en de rest van de schijf voor LUKS root.

```bash
sgdisk --clear --align-end \
  --new=1:0:+500M --typecode=1:ef00 --change-name=1:"EFI system partition" \
  --new=2:0:0 --typecode=2:8309 --change-name=2:"Linux LUKS" \
  /dev/nvme0n1
```

## 5. Filesystem Creation
Formatteer de EFI partitie. Geoptimaliseerd voor NVMe 4K sectorgrootte

```bash
mkfs.vfat -F 32 -n "SYSTEM" -S 4096 -s 1 /dev/nvme0n1p1
```

### 5.1. Creëer een LUKS2 versleutelde container.
#### Optie 1. Sterke encryptie is de norm.
De strengste optie. Superveilig maar opent iets langzamer.
```bash
cryptsetup --type luks2 \
  --cipher aes-xts-plain64 \
  --hash sha512 \
  --iter-time 5000 \
  --key-size 512 \
  --pbkdf argon2id \
  --label "Linux LUKS" \
  --sector-size 4096 \
  --use-urandom \
  --verify-passphrase \
  luksFormat /dev/nvme0n1p2
```

#### Optie 2. Slimme Balans
Iets sneller maar nog steeds supersterk. Ideaal voor dagelijks gebruik. Het verschil met optie 1 zit in --iter-time 2000. Dit opent 2,5× sneller.
```bash
cryptsetup --type luks2 \
  --cipher aes-xts-plain64 \
  --hash sha512 \
  --iter-time 2000 \
  --key-size 512 \
  --pbkdf argon2id \
  --label "Linux LUKS" \
  --sector-size 4096 \
  --use-urandom \
  --verify-passphrase \
  luksFormat /dev/nvme0n1p2
```

#### Optie 3. Maximale Compatibiliteit
Veiligheid en werkt overal. Gebruikt een minder geavanceerde PBKDF maar blijft sterk. De perfecte keuze als je zeker wilt zijn dat het overal werkt inclusief oude kernels.
```bash
cryptsetup --type luks2 \
  --cipher aes-xts-plain64 \
  --hash sha256 \
  --iter-time 2000 \
  --key-size 512 \
  --pbkdf pbkdf2 \
  --label "Linux LUKS" \
  --sector-size 512 \
  --use-urandom \
  --verify-passphrase \
  luksFormat /dev/nvme0n1p2
```

⚠️ Nadeel: PBKDF2 is gevoeliger voor GPU-aanvallen dan Argon2id.

### 5.2. Open de LUKS container.
We noemen hem cryptarch.

```bash
cryptsetup --allow-discards --persistent open --type luks2 \
  /dev/nvme0n1p2 cryptarch
```

### 5.3. Formatteer het ontgrendelde LUKS volume met BTRFS. Ook in 4K. 
```bash
mkfs.btrfs -L "Arch Linux" -s 4096 /dev/mapper/cryptarch
```

### 5.4. BTRFS Subvolume Layout
Mount het root BTRFS-volume tijdelijk.
```bash
mount -o rw,noatime,nodiratime,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120 /dev/mapper/cryptarch /mnt
```

## 6. Filesystem Subvolumes en Mounten
Maak de BTRFS subvolumes aan. Alles op zijn plek.
```bash
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@swap
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@efibck
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@pkg
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@vms
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@srv
btrfs subvolume create /mnt/@games
```

Ontkoppel het hoofdvolume. Klaar voor de echte mount.
```bash
umount /mnt
```

Mount root subvolume.
```bash
mount -o rw,noatime,nodiratime,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120,subvol=@ \
  /dev/mapper/cryptarch /mnt
```

Creëer de benodigde mount points.
```bash
mkdir -p /mnt/{efi,.swap,.snapshots,.efibackup,var/{log,tmp,cache/pacman/pkg,lib/libvirt/images},home,srv,opt/games}
```

Mount de EFI system partition. (read-only, noexec voor veiligheid)
```bash
mount -o rw,noatime,nodiratime,nodev,nosuid,noexec,fmask=0022,dmask=0022 \
  /dev/nvme0n1p1 /mnt/efi
```

Mount de andere BTRFS subvolumes.
```bash
mount -o rw,noatime,nodiratime,nodev,nosuid,noexec,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120,subvol=@swap /dev/mapper/cryptarch /mnt/.swap
mount -o rw,noatime,nodiratime,nodev,nosuid,noexec,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120,subvol=@snapshots /dev/mapper/cryptarch /mnt/.snapshots
mount -o rw,noatime,nodiratime,nodev,nosuid,noexec,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120,subvol=@efibck /dev/mapper/cryptarch /mnt/.efibackup
mount -o rw,noatime,nodiratime,nodev,nosuid,noexec,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120,subvol=@log /dev/mapper/cryptarch /mnt/var/log
mount -o rw,noatime,nodiratime,nodev,nosuid,noexec,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120,subvol=@tmp /dev/mapper/cryptarch /mnt/var/tmp
mount -o rw,noatime,nodiratime,nodev,nosuid,noexec,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120,subvol=@pkg /dev/mapper/cryptarch /mnt/var/cache/pacman/pkg
mount -o rw,noatime,nodiratime,nodev,nosuid,noexec,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120,subvol=@vms /dev/mapper/cryptarch /mnt/var/lib/libvirt/images
mount -o rw,noatime,nodiratime,nodev,nosuid,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120,subvol=@home /dev/mapper/cryptarch /mnt/home
mount -o rw,noatime,nodiratime,nodev,nosuid,noexec,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120,subvol=@srv /dev/mapper/cryptarch /mnt/srv
mount -o rw,noatime,nodiratime,nodev,nosuid,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120,subvol=@games /dev/mapper/cryptarch /mnt/opt/games
```

Controleer de gemounte bestandsystemen. Alles correct? Check dit.
```bash
lsblk
df -h
```

## 7. Create Swap File
Hier maken we de swap file. Efficiënt geheugenbeheer is cruciaal.

Maak een 4GB swap file aan op het BTRFS subvolume.
```bash
btrfs filesystem mkswapfile --size 4g /mnt/.swap/swapfile
chmod 600 /mnt/.swap/swapfile
```

## 8. Install Base System
De fundering van je systeem. Dit installeert het broodnodige.

Installeer base packages, firmware, EFI tools, BTRFS-ondersteuning, neovim en secure boot tools.
```bash
pacstrap /mnt \
  base base-devel linux linux-firmware intel-ucode \
  nano efibootmgr btrfs-progs sbctl nvidia
```

## 9. Generate fstab
Nu maken we het fstab bestand. Dit vertelt je systeem waar alles staat.

Genereer fstab met UUID's.
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

Controleer fstab en pas aan. Let op 0 1 om de bestandssysteemcheck op de root te activeren.
```bash
nano -w /mnt/etc/fstab
```

Content:
```bash
UUID=<BTRFS-UUID-PARTITION>      /      btrfs      rw,noatime,nodiratime,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120,subvol=/@      0 1
```

## 10. Enter Chroot
Stap in je nieuwe systeem.

Verander de root naar het nieuwe systeem.
```bash
arch-chroot /mnt
```

## 11. Configure Locale and Keyboard
Stel de taal en toetsenbordindeling in.

Stel het virtuele consoletoetsenbord in op US.
```bash
nano -w /et   sc/vconsole.conf
```

Content:
```bash
KEYMAP=us
FONT=lat9w-16
```

Stel de systeembrede locale in.
```bash
nano -w /etc/locale.conf
```

Content:
```bash
LANG=en_US.UTF-8
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
```

Activeer de vereiste locales.
```bash
nvim /etc/locale.gen
```

Uncomment:
```bash
en_US.UTF-8 UTF-8
```

Genereer de locale definities.
```bash
locale-gen
```

## 12. Host Identity Configuration
Geef je systeem een identiteit.

Stel de systeemhostname in.
```bash
nvim /etc/hostname
```

Content:
```bash
xps
```

Stel de hosts file entries in voor lokaal netwerk.
```bash
nano -w /etc/hosts
```

Content:
```bash
127.0.0.1      localhost
::1            localhost
192.168.2 10   xps
```

## 13. Timezone & Clock Setup
Tijd is alles. Stel het correct in.

Stel de systeemtijdzone in.
```bash
ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
```

Sync de hardwareklok met de systeemtijd.
```bash
hwclock --systoh
```

## 14. Initramfs Configuration (Systemd, LUKS, Keyboard)
Edit initramfs hooks to include systemd & encryption
```bash
nano -w /etc/mkinitcpio.conf
```

Content:
```bash
HOOKS=(systemd autodetect microcode modconf kms keyboard sd-vconsole block sd-encrypt filesystems sd-shutdown)
```

Setup encrypted volume for systemd to unlock via TPM2
```bash
nano -w /etc/crypttab.initramfs
```

Content:
```bash
cryptarch UUID=<nvme-UUID> none tpm2-device=auto,password-echo=no,x-systemd.device-timeout=0,timeout=0,no-read-workqueue,no-write-workqueue,discard
```

Get <nvme-UUID> in neovim:
```bash
:read ! lsblk -dno UUID /dev/nvme0n1p2
```

## 15. Kernel Command Line Configuration (UKI + zswap)
Root and logging options (read-only fs is handled by systemd and to fsck /)
```bash
nano -w /etc/cmdline.d/01-root.conf
```

Content:
```bash
root=/dev/mapper/cryptarch rootfstype=btrfs rootflags=subvol=@ ro loglevel=3
```

Configure zswap parameters for performance
```bash
nano -w /etc/cmdline.d/02-zswap.conf
```

Content:
```bash
zswap.enabled=1 zswap.max_pool_percent=20 zswap.zpool=zsmalloc zswap.compressor=zstd zswap.accept_threshold_percent=90
```

## 16. Initramfs Preset for Unified Kernel Image (UKI)
Setup mkinitcpio preset to generate a UKI
```bash
nano -w /etc/mkinitcpio.d/linux.preset
```

Content only:
```bash
ALL_kver="/boot/vmlinuz-linux"
PRESETS=('default')
default_uki="/efi/EFI/Linux/arch-linux.efi"
default_options="--splash=/usr/share/systemd/bootctl/splash-arch.bmp"
```

## 17. Secure Boot with sbctl
Create Secure Boot keys
```bash
sbctl create-keys
```

Enroll custom keys and microsoft keys
```bash
sbctl enroll-keys -m
```

Generate the Unified Kernel Image
```bash
mkdir -p /efi/EFI/Linux
mkinitcpio -p linux
```

## 18. EFI Boot Entry
Register UKI with UEFI firmware
```bash
efibootmgr --create --disk /dev/nvme0n1 --part 1 \
  --label "Arch Linux" --loader /EFI/Linux/arch-linux.efi --unicode
```

## 19. LUKS TPM2 Key Enrollment
Enroll TPM2 key (PCR 0 = firmware, PCR 7 = Secure Boot state)
```bash
systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/nvme0n1p2
```

## 20. Swappiness Tuning
Lower swappiness to prefer RAM usage over swap
```bash
nano -w /etc/sysctl.d/99-swappiness.conf
```

Content, 80% RAM usage before swapping:
```bash
vm.swappiness=20
```

## 21. Encrypted Swap Setup
Add encrypted swap entry using /dev/urandom
```bash
nano -w /etc/crypttab
```

Content:
```bash
swap      /.swap/swapfile      /dev/urandom      swap,cipher=aes-xts-plain64,sector-size=4096
```

Add swap to fstab
```bash
nano -w /etc/fstab
```

Content:
```bash
#	/.swap/swapfile      CRYPTED SWAPFILE
/dev/mapper/swap      none      swap      defaults      0 0
```

## 22. Pacman Configuration
Enable multilib, candy theme, parallel downloads & ignore snapper cron jobs
```bash
nano -w /etc/pacman.conf
```

Content:
```bash
NoExtract = etc/cron.daily/snapper etc/cron.hourly/snapper
Color
ParallelDownloads = 10
ILoveCandy

[multilib]
Include = /etc/pacman.d/mirrorlist
```

## 23. NetworkManager
Installeer networkmanager en network-manager-applet
```bash
pacman -S networkmanager network-manager-applet
```

Stop en schakel systemd-networkd uit
```bash
systemctl stop systemd-networkd
systemctl disable systemd-networkd
```

Start en schakel NetworkManager in
```bash
systemctl enable NetworkManager
systemctl start NetworkManager
```

## 24. Basic Packages: Bluetooth, Snapper, Pacman Cache Service, Reflector
Install essential tools
```bash
pacman -Syy bluez snapper pacman-contrib reflector
```

## 25. Time Sync with Dutch NTP Servers
Set systemd-timesyncd to use Dutch pool servers with iburst
```bash
nano -w /etc/systemd/timesyncd.conf
```

Content:
```bash
[Time]
NTP=0.nl.pool.ntp.org 1.nl.pool.ntp.org 2.nl.pool.ntp.org 3.nl.pool.ntp.org
FallbackNTP=0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
```
## 26. I/O Scheduler Tuning for NVMe
Disable I/O scheduler on NVMe device to use none (for performance)
```bash
nano -w /etc/udev/rules.d/60-schedulers.rules
```

Content:
```bash
ACTION=="add|change", KERNEL=="nvme0n1", ATTR{queue/scheduler}="none"
```
