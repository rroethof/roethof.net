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

Hier vind je mijn stap-voor-stap handleiding voor Arch Linux op je Dell XPS 9530. We focussen op een clean base met maximale beveiliging en prestaties. Denk aan:

 * Partitioning & formatting: De fundering.
 * LUKS2 setup with TPM2: Volledige schijfencryptie, hardware-verankerd.
 * Mounting and subvolume layout: Geoptimaliseerd Btrfs voor veerkracht en snelheid.
 * Base system installation: Alleen wat nodig is, geen ballast.
 * Chroot configuration: De basis goed neerzetten.
 * UKI creation and signing: Unified Kernel Images en Secure Boot voor veiligheid.
 * EFI setup: Jouw systeem direct klaar voor actie.
 * Snapper configuration: Snelle data recovery via rclone wordt kinderspel.
 * Swap and zswap activation: Efficiënt geheugenbeheer.

En als klap op de vuurpijl sluiten we af met een naadloze Hyprland desktop.

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
Optie 1. Sterke encryptie is de norm.
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

Optie 2. Een iets vriendelijkere maar nog steeds zeer sterke versie.
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

Verschil:

--iter-time 2000 i.p.v. 5000 → nog steeds zwaar genoeg voor brute force, maar opent 2,5× sneller.

Rest is identiek, dus je behoudt AES-XTS 512-bit, Argon2id, 4K sectoren.

Waarom dit slim is

Veiligheid: Argon2id is geheugenhard, dus 2 seconden op jouw CPU kost een aanvaller ook 2 seconden per gok, en vaak nog meer op GPU’s.

Praktisch: Als je je laptop meerdere keren per dag opent, scheelt dit veel wachttijd.


### 5.2. Open de LUKS container. 
We noemen hem cryptarch.

```bash
cryptsetup --allow-discards --persistent open --type luks2 \
  /dev/nvme0n1p2 cryptarch
```

Formatteer het ontgrendelde LUKS volume met BTRFS. Ook in 4K. 
```bash
mkfs.btrfs -L "Arch Linux" -s 4096 /dev/mapper/cryptarch
```
## 6. Filesystem Subvolumes en Mounten
Tijd om BTRFS subvolumes aan te maken en ze netjes te mounten. Dit geeft je flexibiliteit en maakt snapshots mogelijk.
```bash
Maak de BTRFS subvolumes aan. Alles op zijn plek.
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@opt
btrfs subvolume create /mnt/@.snapshots
btrfs subvolume create /mnt/@srv
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@var_abs
btrfs subvolume create /mnt/@var_cache
btrfs subvolume create /mnt/@var_log
```

Ontkoppel het hoofdvolume. Klaar voor de echte mount.
```bash
umount /mnt
```

Koppel de subvolumes met de juiste opties. Maximale prestaties.
```bash
mount -o noatime,compress=zstd,space_cache=v2,ssd,discard=async,subvol=@ /dev/mapper/cryptarch /mnt
mkdir -p /mnt/{boot,home,var/log,var/cache,var/abs,opt,srv,.snapshots,tmp}
mount -o noatime,compress=zstd,space_cache=v2,ssd,discard=async,subvol=@home /dev/mapper/cryptarch /mnt/home
mount -o noatime,compress=zstd,space_cache=v2,ssd,discard=async,subvol=@log /dev/mapper/cryptarch /mnt/var/log
mount -o noatime,compress=zstd,space_cache=v2,ssd,discard=async,subvol=@opt /dev/mapper/cryptarch /mnt/opt
mount -o noatime,compress=zstd,space_cache=v2,ssd,discard=async,subvol=@.snapshots /dev/mapper/cryptarch /mnt/.snapshots
mount -o noatime,compress=zstd,space_cache=v2,ssd,discard=async,subvol=@srv /dev/mapper/cryptarch /mnt/srv
mount -o noatime,compress=zstd,space_cache=v2,ssd,discard=async,subvol=@tmp /dev/mapper/cryptarch /mnt/tmp
mount -o noatime,compress=zstd,space_cache=v2,ssd,discard=async,subvol=@var_abs /dev/mapper/cryptarch /mnt/var/abs
mount -o noatime,compress=zstd,space_cache=v2,ssd,discard=async,subvol=@var_cache /dev/mapper/cryptarch /mnt/var/cache
mount -o noatime,compress=zstd,space_cache=v2,ssd,discard=async,subvol=@var_log /dev/mapper/cryptarch /mnt/var/log
mount -o umask=0077 /dev/nvme0n1p1 /mnt/boot
```

Controleer de gemounte bestandsystemen. Alles correct? Check dit.
```bash
lsblk
df -h
```
