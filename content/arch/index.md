---
date: 2025-08-09
description: "Complete Arch Linux installatiehandleiding met Btrfs, UKI, Secure Boot, TPM2 encryptie en Hyprland op mijn Dell XPS 9530. Inclusief geavanceerde optimalisaties en rclone datarecovery."
slug: "arch-linux-installatie"
draft: false
showDateOnlyInArticle : false
showHeadingAnchors : false
layoutBackgroundHeaderSpace: false
showDate: false
showViews: false: false
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
sharingLinks: true
disableComments: true
---
{{< typeit
tag=h1
lifeLike=true >}}
Arch Linux Installatie: Beveiliging zonder verlies van snelheid of gemak op mijn Dell XPS 9530
{{< /typeit >}}

Tijd voor een **veiligere Arch Linux installatie** op je Dell XPS 9530. Geen gezeur geen onnodige extra's. We bouwen een **strakke base** met focus op **maximale beveiliging** en **snelle prestaties**. Dit is wat je krijgt:

* **Partitionering en formatteren**: De fundering goed geregeld.
* **LUKS2 setup met TPM2**: Volledige schijfencryptie hardware-gestuurd.
* **Mounten en subvolume layout**: Btrfs geoptimaliseerd.
* **Base system installatie**: Alleen het noodzakelijke.
* **Chroot configuratie**: De fundamenten. Sterk en stabiel.
* **UKI creatie en signing**: Unified Kernel Images en Secure Boot.
* **EFI setup**: Je systeem start direct, geen gedoe.
* **Snapper configuratie**: Data recovery met rclone.
* **Swap en zswap activatie**: Geheugenbeheer.

Daarna? Een naadloze Hyprland desktop. Pure klasse.

> \[!NOTE]
> Dit is voor gevorderde gebruikers of voor educatieve doeleinden.

---
## 1. Voorbereiding
Eerst het voorwerk. Zoek je spullen bij elkaar.

* Arch Linux ISO (laatste release) op USB-stick (`dd` of `Rufus`)
* UEFI geactiveerd in BIOS
* TPM 2.0 ingeschakeld in BIOS.
* SATA/NVMe Operation: **AHCI** (in plaats van "RAID On").
* Secure Boot moet in de BIOS/UEFI op "**Setup Mode**" worden gezet **vóór** de installatie. Dit is vereist om je eigen Secure Boot-sleutels te kunnen registreren met `sbctl`.

---
## 2. Opstarten en Initiële Setup
### 2.1. Opstarten vanaf USB
Zo kom je binnen:
1. Plaats de Arch Linux USB-stick in de laptop.
2. Start de laptop en druk herhaaldelijk op **F12** om het bootmenu te openen.
3. Selecteer de USB-stick als opstartapparaat.

### 2.2. Beep uitzetten: Rust voor de ziel.
```bash
rmmod pcspkr
```
> Die luide piep bij het opstarten, of als je backspace in een lege terminal drukt? Dat is de **pc speaker**. Deze module is vaak overbodig en kan je installatie verpesten. Met dit commando verwijder je de module direct uit de kernel. Doodse stilte. Heerlijk. 🔇

### 2.3. Wi-Fi verbinden (met iwctl)
Internet. Nodig voor alles.
```bash
iwctl
station wlan0 scan
station wlan0 get-networks
station wlan0 connect <SSID>
exit
```
Check je verbinding:
```bash
ping 1.1.1.1 -c 4
```

### 2.4. SSH Remote Installatie (optioneel): Werk op afstand.
Voor de luie techneut. Installeer via SSH.
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

---
## 3. Pre-Installatie Setup
Voordat we dieper graven, een paar belangrijke stappen.

### 3.1. Verwijder oude EFI entries indien nodig.
Weg met de rommel. Vervang **X** met het juiste nummer.
```bash
efibootmgr
efibootmgr -b X -B
```

### 3.2. Update GPG keys vanaf de live omgeving.
Dit is een slimme zet vóór de installatie.
```bash
pacman -Sy archlinux-keyring
```

---
## 4. Disk Partitioning (GPT)
Tijd om de schijf op te delen. We maken een EFI partitie en de rest gaat naar een LUKS root.
Partitioneer de schijf: **EFI** (500MB) en de rest van de schijf voor **LUKS root**.
```bash
sgdisk --clear --align-end \
  --new=1:0:+500M --typecode=1:ef00 --change-name=1:"EFI system partition" \
  --new=2:0:0 --typecode=2:8309 --change-name=2:"Linux LUKS" \
  /dev/nvme0n1
```

---
## 5. Filesystem Creation
De bestandsystemen. De fundering van je systeem.
Formatteer de EFI partitie. Geoptimaliseerd voor NVMe 4K sectorgrootte.
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
Iets sneller maar nog steeds supersterk. Ideaal voor dagelijks gebruik. Het verschil met optie 1 zit in `--iter-time 2000`. Dit opent 2,5× sneller.
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
Nadeel: PBKDF2 is gevoeliger voor GPU-aanvallen dan Argon2id.

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

---
## 6. Filesystem Subvolumes en Mounten
Dit is het hart van de BTRFS setup. Maak subvolumes aan en monteer ze. Goed voor snapshots en veerkracht.

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
mount -o rw,noatime,nodiratime,nodev,nosuid,noexec,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120,subvol=@home /dev/mapper/cryptarch /mnt/home
mount -o rw,noatime,nodiratime,nodev,nosuid,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120,subvol=@srv /dev/mapper/cryptarch /mnt/srv
mount -o rw,noatime,nodiratime,nodev,nosuid,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120,subvol=@games /dev/mapper/cryptarch /mnt/opt/games
```
Controleer de gemounte bestandsystemen. Alles correct? Check dit.
```bash
lsblk
df -h
```

---
## 7. Maak een Swapbestand
Hier maken we het swapbestand. Efficiënt geheugenbeheer is cruciaal.
Maak een 4GB swapbestand aan op het BTRFS subvolume.
```bash
btrfs filesystem mkswapfile --size 4g /mnt/.swap/swapfile
chmod 600 /mnt/.swap/swapfile
```

---
## 8. Installeer het Basis Systeem
De fundering van je systeem. Dit installeert het broodnodige.
Installeer basispakketten, firmware, EFI tools, BTRFS-ondersteuning, nano en secure boot tools.
```bash
pacstrap /mnt \
  base base-devel linux linux-firmware intel-ucode \
  nano efibootmgr btrfs-progs sbctl nvidia iwd
```

---
## 9. Genereer fstab
Nu maken we het fstab bestand. Dit vertelt je systeem waar alles staat.
Genereer fstab met UUID's.
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```
Controleer fstab en pas aan. Let op `0 1` om de bestandssysteemcheck op de root te activeren.
```bash
nano -w /mnt/etc/fstab
```
Content:
```bash
UUID=<BTRFS-UUID-PARTITION>      /       btrfs           rw,noatime,nodiratime,compress=zstd:3,ssd,discard=async,space_cache=v2,commit=120,subvol=/@           0 1
```

---
## 10. Start Chroot
Stap in je nieuwe systeem.
Verander de root naar het nieuwe systeem.
```bash
arch-chroot /mnt
```

---
## 11. Stel Taal en Toetsenbord in
Stel de taal en toetsenbordindeling in.
Stel het virtuele consoletoetsenbord in op US.
```bash
nano -w /etc/vconsole.conf
```
Inhoud:
```bash
KEYMAP=us
FONT=lat9w-16
```
Stel de systeembrede locale in.
```bash
nano -w /etc/locale.conf
```
Inhoud:
```bash
LANG=en_US.UTF-8
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
```
Activeer de vereiste locales.
```bash
nano -w /etc/locale.gen
```
Uncomment:
```bash
en_US.UTF-8 UTF-8
```
Genereer de locale definities.
```bash
locale-gen
```

---
## 12. Host Identiteit Instellen
Geef je systeem een identiteit.
Stel de systeemhostname in.
```bash
nano -w /etc/hostname
```
Inhoud:
```bash
xps
```
Stel de hosts file entries in voor lokaal netwerk.
```bash
nano -w /etc/hosts
```
Inhoud:
```bash
127.0.0.1       localhost
::1             localhost
192.168.2.10    xps
```

---
## 13. Tijdzone en Klok Instellen
Tijd is alles. Stel het correct in.
Stel de systeemtijdzone in.
```bash
ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
```
Sync de hardwareklok met de systeemtijd.
```bash
hwclock --systohc
```

---
## 14. Initramfs Configuratie (Systemd, LUKS, Keyboard)
Bewerk initramfs hooks om systemd & encryptie te includeren.
```bash
nano -w /etc/mkinitcpio.conf
```
Inhoud:
```bash
HOOKS=(systemd autodetect microcode modconf kms keyboard sd-vconsole block sd-encrypt filesystems sd-shutdown)
```
Stel het versleutelde volume in voor systemd om te ontgrendelen via TPM2.
**Haal eerst de UUID op van de LUKS-partitie en plak die handmatig in het bestand.**
```bash
lsblk -dno UUID /dev/nvme0n1p2
```
Kopieer de UUID en bewerk het bestand.
```bash
nano -w /etc/crypttab.initramfs
```
Inhoud:
```bash
cryptarch UUID=<nvme-UUID> none tpm2-device=auto,password-echo=no,x-systemd.device-timeout=0,timeout=0,no-read-workqueue,no-write-workqueue,discard
```

---
## 15. Kernel Command Line Configuratie (UKI + zswap)
Root en logging opties (read-only fs is handled by systemd and to fsck /)
Creëer de map voor kernel command line bestanden. Dit is essentieel.
```bash
mkdir -p /etc/cmdline.d
```
Nu kun je de bestanden aanmaken.
```bash
nano -w /etc/cmdline.d/01-root.conf
```
Inhoud:
```bash
root=/dev/mapper/cryptarch rootfstype=btrfs rootflags=subvol=@ ro loglevel=3
```
Configureer zswap parameters voor prestaties.
```bash
nano -w /etc/cmdline.d/02-zswap.conf
```
Inhoud:
```bash
zswap.enabled=1 zswap.max_pool_percent=20 zswap.zpool=zsmalloc zswap.compressor=zstd zswap.accept_threshold_percent=90
```

---
## 16. Initramfs Preset voor Unified Kernel Image (UKI)
Setup `mkinitcpio` preset om een UKI te genereren.
```bash
nano -w /etc/mkinitcpio.d/linux.preset
```
Inhoud alleen:
```bash
ALL_kver="/boot/vmlinuz-linux"
PRESETS=('default')
default_uki="/efi/EFI/Linux/arch-linux.efi"
default_options="--splash=/usr/share/systemd/bootctl/splash-arch.bmp"
```

---
## 17. Secure Boot met sbctl
Creëer Secure Boot sleutels.
```bash
sbctl create-keys
```
**Fix onveranderlijke EFI-variabelen.** Voer deze commando's uit als je de foutmelding `File is immutable` krijgt.
```bash
chattr -i /sys/firmware/efi/efivars/KEK-*
chattr -i /sys/firmware/efi/efivars/db-*
```
Schrijf aangepaste sleutels en microsoft sleutels in.
```bash
sbctl enroll-keys -m
```
Genereer de Unified Kernel Image.
```bash
mkdir -p /efi/EFI/Linux
mkinitcpio -p linux
```

---
## 18. EFI Boot Entry
Registreer UKI bij UEFI firmware.
```bash
efibootmgr --create --disk /dev/nvme0n1 --part 1 \
  --label "Arch Linux" --loader /EFI/Linux/arch-linux.efi --unicode
```

---
## 19. LUKS TPM2 Sleutel Registratie
Registreer TPM2 sleutel (PCR 0 = firmware, PCR 7 = Secure Boot state).
```bash
systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/nvme0n1p2
```

---
## 20. Optimaliseer Swappiness
Verlaag de swappiness om RAM te verkiezen boven swap.
```bash
nano -w /etc/sysctl.d/99-swappiness.conf
```
Inhoud, 80% RAM-gebruik voor het swappen:
```bash
vm.swappiness=20
```

---
## 21. Versleutelde Swap Instellen
Voeg versleutelde swap entry toe met `/dev/urandom`.
```bash
nano -w /etc/crypttab
```
Inhoud:
```bash
swap      /.swap/swapfile         /dev/urandom          swap,cipher=aes-xts-plain64,sector-size=4096
```
Voeg swap toe aan fstab.
```bash
nano -w /etc/fstab
```
Inhoud:
```bash
# /.swap/swapfile       CRYPTED SWAPFILE
/dev/mapper/swap      none      swap      defaults      0 0
```

---
## 22. Pacman Configuratie
Activeer multilib, parallel downloads & negeer snapper cron jobs.
```bash
nano -w /etc/pacman.conf
```
Inhoud:
```bash
NoExtract = etc/cron.daily/snapper etc/cron.hourly/snapper
Color
ParallelDownloads = 10
[multilib]
Include = /etc/pacman.d/mirrorlist
```bash
pacman -Sy
```

---
## 23. NetworkManager
Installeer networkmanager en network-manager-applet.
> \[!NOTE]
> Je zult een foutmelding krijgen zoals `Running in chroot, ignoring command 'stop'`. Dit is normaal. Het `systemd` van de live-USB beheert de services, niet de `systemd` in de chroot. Negeer de melding en ga verder met de volgende stappen.

```bash
pacman -S networkmanager network-manager-applet
```
Stop en schakel systemd-networkd uit.
```bash
systemctl stop systemd-networkd
systemctl disable systemd-networkd
```
Start en schakel NetworkManager in.
```bash
systemctl enable NetworkManager
systemctl start NetworkManager
```

---
## 24. Basispakketten: Bluetooth, Snapper, Pacman Cache Service, Reflector
Installeer essentiële tools.
```bash
pacman -Syy bluez snapper pacman-contrib reflector
```

---
## 25. Tijd Sync met Nederlandse NTP Servers
Stel `systemd-timesyncd` in om Nederlandse pool servers te gebruiken met iburst.
```bash
nano -w /etc/systemd/timesyncd.conf
```
Inhoud:
```bash
[Time]
NTP=0.nl.pool.ntp.org 1.nl.pool.ntp.org 2.nl.pool.ntp.org 3.nl.pool.ntp.org
FallbackNTP=0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
```

---
## 26. I/O Scheduler Optimalisatie voor NVMe
Schakel de I/O scheduler uit op het NVMe-apparaat voor prestaties.
```bash
nano -w /etc/udev/rules.d/60-schedulers.rules
```
Inhoud:
```bash
ACTION=="add|change", KERNEL=="nvme0n1", ATTR{queue/scheduler}="none"
```

---
## 27. DNS Stub Resolver via systemd-resolved
Koppel de stub resolver aan /etc/resolv.conf
```bash
ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
```

---
## 28. Reflector Configuratie (Spiegel-lijst Bijwerken)
Optimaliseer pacman mirrors op leeftijd, land en protocol
```bash
nano -w /etc/xdg/reflector/reflector.conf
```
Inhoud:
```bash
--save /etc/pacman.d/mirrorlist
--country Netherlands,Belgium,Germany
--protocol https
--latest 5
--sort age
```

---
## 29. Belangrijke Services Inschakelen
Schakel netwerk- en systeemservices in
```bash
systemctl enable systemd-networkd.service
systemctl enable systemd-resolved.service
systemctl enable bluetooth.service
systemctl enable systemd-timesyncd.service
systemctl enable paccache.timer
systemctl enable reflector.timer
```

---
## 30. sudo configureren
Geef sudo-rechten aan de wheel-groep
```bash
EDITOR=nano visudo
```
Inhoud:
```bash
%wheel ALL=(ALL:ALL) NOPASSWD: ALL
```

---
## 31. Gebruiker toevoegen
Maak je eigen gebruiker aan. Je wilt niet alles als `root` doen. Geef de gebruiker de juiste groepen, inclusief `wheel` voor sudo-rechten.
```bash
useradd -m -g users -G wheel,storage,power rroethof
passwd rroethof
```

---
## 32. makepkg Configuratie (Compilatie Optimalisatie)
Optimaliseer `makepkg` om je CPU optimaal te benutten en de tijdelijke bestanden in het geheugen te bewaren. Dit versnelt het compileren van pakketten aanzienlijk.
Bewerk de vlaggen van `makepkg` voor je specifieke architectuur en gebruik `/tmp` voor de builds.
```bash
nano -w /etc/makepkg.conf
```
Inhoud:
```bash
CFLAGS="-march=native -O2 -pipe -fstack-protector-strong -fno-plt"
CXXFLAGS="${CFLAGS}"
RUSTFLAGS="-C opt-level=2 -C target-cpu=native"
LDFLAGS="-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now"
BUILDDIR=/tmp/makepkg
```
Maak een aparte configuratie voor Rust om er zeker van te zijn dat de vlaggen correct worden toegepast.
```bash
nano -w /etc/makepkg.conf.d/rust.conf
```
Inhoud:
```bash
RUSTFLAGS="-C opt-level=2 -C target-cpu=native"
```

---
## 33. Root Wachtwoord Instellen
Stel het wachtwoord in voor de **root-gebruiker**.
```bash
passwd
```

---
## 34. Chroot verlaten en Herstarten
Verlaat de chroot-omgeving en herstart de machine. Start direct in het UEFI/BIOS om te controleren of Secure Boot is ingeschakeld.
```bash
exit
umount -R /mnt
systemctl reboot --firmware-setup
```

---
## 35. Na de Eerste Reboot
Oké, je hebt opnieuw opgestart. Het systeem is nog niet volledig geautomatiseerd. Dat komt zo. Volg deze stappen om het te fixen.

### 35.1. Log In
Voer de passphrase van je LUKS-volume in als daarom wordt gevraagd. Dit is normaal op de eerste boot. Log vervolgens in met je aangemaakte gebruiker.

### 35.2. Connecteer met Wi-Fi
NetworkManager is ingeschakeld, maar mogelijk nog niet actief. Fix dit handmatig.
```bash
# Gebruik iwctl om de verbinding te herstellen
iwctl
station wlan0 scan
station wlan0 get-networks
station wlan0 connect <SSID>
exit
```
Controleer daarna of je een IP-adres hebt en verbinding met internet.
```bash
ip addr show wlan0
ping 1.1.1.1 -c 4
```

### 35.3. Controleer NetworkManager Status
Als je verbinding hebt, check dan of de service draait:
```bash
systemctl status NetworkManager
```
Als de status niet `active (running)` is, start je de service handmatig:
```bash
sudo systemctl start NetworkManager
```
> \[!NOTE]
> Je hebt een NetworkManager applet nodig voor een grafische interface. Dit wordt later geregeld. Je kunt NetworkManager ook direct configureren met `nmtui`.

---
## 36. Snapper Configureren (Na Herstart)
Nu je weer in je nieuwe systeem zit, configureer je Snapper voor snapshots.
```bash
# Verwijder de standaard Snapper-subvolume om conflicten te vermijden
umount /.snapshots
rm -r /.snapshots
# Initialiseer Snapper voor het root-bestandssysteem
snapper -c root create-config /
# Verwijder het subvolume dat Snapper zojuist heeft gemaakt
btrfs subvolume delete /.snapshots
# Hercreëer het mount point en mount het
mkdir /.snapshots
mount /.snapshots
```

---
## 37. Snapper Snapshots Beveiligen en Instellen
Beveilig de Snapper-directory en pas de snapshot-instellingen aan.
```bash
chmod 750 /.snapshots
```
Configureer de snapshot-instellingen voor automatische snapshots op je root-subvolume.
```bash
nano -w /etc/snapper/configs/root
```
Inhoud:
```bash
TIMELINE_CREATE="yes"
TIMELINE_CLEANUP="yes"
NUMBER_MIN_AGE="1800"
NUMBER_LIMIT="10"
NUMBER_LIMIT_IMPORTANT="10"
TIMELINE_MIN_AGE="1800"
TIMELINE_LIMIT_HOURLY="5"
TIMELINE_LIMIT_DAILY="7"
TIMELINE_LIMIT_WEEKLY="0"
TIMELINE_LIMIT_MONTHLY="0"
TIMELINE_LIMIT_YEARLY="0"
```

---
## 38. Custom Pacman Hook voor /efi Backup
Maak een Pacman-hook die een backup maakt van de `/efi`-directory vóór een belangrijke systeemupdate.
```bash
# Maak de hook aan
nano -w /etc/pacman.d/hooks/10-efi_backup.hook
```
Inhoud:
```bash
## PACMAN EFI BACKUP HOOK
## /etc/pacman.d/hooks/10-efi_backup.hook
[Trigger]
Type = Path
Operation = Install
Operation = Upgrade
Operation = Remove
Target = usr/lib/initcpio/*
Target = usr/lib/firmware/*
Target = usr/lib/modules/*/extramodules/
Target = usr/lib/modules/*/vmlinuz
Target = usr/src/*/dkms.conf
[Trigger]
Type = Package
Operation = Install
Operation = Upgrade
Operation = Remove
Target = mkinitcpio
Target = mkinitcpio-git
[Action]
Description = Backing up /efi...
When = PreTransaction
Exec = /usr/local/sbin/efi_backup.sh
```bash
# Maak het backup-script aan
nano -w /usr/local/sbin/efi_backup.sh
```
Inhoud:
```bash
#!/bin/bash
## SCRIPT EFI BACKUP
## /usr/local/sbin/efi_backup.sh
tar -czf "/.efibackup/efi-$(date +%Y%m%d-%H%M%S).tar.gz" -C / efi
ls -1t /.efibackup/efi-*.tar.gz | tail -n +4 | xargs -r rm --
```

---
## 39. Finaliseren van /efi Backup Hook en fstrim
Nu we het script hebben aangemaakt, maken we het uitvoerbaar en beperken we `fstrim` tot alleen de `/efi`-partitie.
```bash
# Maak het script uitvoerbaar
chmod +x /usr/local/sbin/efi_backup.sh
```bash
# Override de standaard `fstrim` service om alleen `/efi` te trimmen
systemctl edit fstrim.service
```
Voeg de volgende content toe en sla het bestand op:
```bash
[Service]
ExecStart=
ExecStart=/usr/sbin/fstrim -v /efi
```

---
## 40. Onderhoudstimers Inschakelen
Schakel de benodigde timers in voor automatisch onderhoud.
```bash
# Activeer de TRIM-timer voor wekelijks onderhoud op /efi
systemctl enable fstrim.timer
```bash
# Activeer de Snapper-timeline timer voor periodieke snapshots
systemctl enable snapper-timeline.timer
```bash
# Activeer de Snapper-cleanup timer voor het opruimen van oude snapshots
systemctl enable snapper-cleanup.timer
```

---
## 41. Pacman-transactie Snapshots Inschakelen
Installeer `snap-pac` om automatisch snapshots te maken vóór en na elke pacman-operatie. Dit is essentieel voor het veilig herstellen van je systeem.
```bash
pacman -S snap-pac
```

---
## 42. Snapper Initiële Snapshots Opschonen
Snapper heeft mogelijk snapshots gemaakt tijdens de installatie. Het is het beste om deze te verwijderen en te beginnen met een schone lei.
```bash
# Toon de huidige lijst van snapshots
snapper -c root list
```bash
# Verwijder een reeks snapshots (bijv. 1 tot 2)
snapper -c root delete 1-2
```

---
## 43. Eerste Systeem Snapshot Maken
Maak handmatig de allereerste "schone" snapshot van je zojuist geïnstalleerde systeem. Dit is je herstelpunt.
```bash
# Creëer een handmatige snapshot met een beschrijving
snapper -c root create -d "init"
```
 

---
## 44. Arch Linux Post Installatie
De basis staat, maar je bent er nog niet. Tijd om het systeem te perfectioneren.

### 44.1. Microcode & Drivers
Installeer de microcode voor je Intel CPU en de drivers voor de geïntegreerde Intel GPU en de discrete NVIDIA GPU. Dit zorgt voor optimale prestaties en stabiliteit.
```bash
pacman -S intel-ucode
pacman -S mesa vulkan-intel intel-media-driver libva-utils vulkan-tools
pacman -S nvidia-open-dkms nvidia-utils nvidia-settings opencl-nvidia
```

### 44.2. TLP voor Batterijduur
Installeer TLP. Dit is een energiebeheertool die de batterijduur aanzienlijk kan verbeteren. Activeer de service direct na installatie.
```bash
pacman -S tlp
systemctl start tlp.service
systemctl enable tlp.service
```

---
## 45. Hyprland Installatie
Nu de drivers en optimalisaties gereed zijn, is het tijd voor de Hyprland desktop. Met het installatiescript van JaKooLit kun je snel een volledig geconfigureerde Hyprland-omgeving opzetten.

```bash
git clone --depth=1 [https://github.com/JaKooLit/Arch-Hyprland.git](https://github.com/JaKooLit/Arch-Hyprland.git) ~/Arch-Hyprland
cd ~/Arch-Hyprland
chmod +x install.sh
./install.sh
```

---
## Veelgestelde Vragen
### Waarom geen bootloader?
Omdat **UKI** het mogelijk maakt de kernel direct vanaf de EFI-partitie op te starten. GRUB of systemd-boot zijn niet nodig.

### Kan ik dit op mijn laptop gebruiken?
Ja - dit is ideaal voor moderne laptops met TPM2 en Secure Boot ingeschakeld.
