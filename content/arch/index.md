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
showTableOfContents: false
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
Arch Linux Installatie: Fort Knox Editie met TPM2, UKI en Hyprland 🚀
{{< /typeit >}}

Hier vind je een **ultieme stap-voor-stap handleiding** om Arch Linux te installeren op je **Dell XPS 9530**. De focus ligt op een **clean base** met verhoogde beveiliging en performance: **UEFI**, geoptimaliseerd **Btrfs**, **Unified Kernel Images (UKI)**, **Secure Boot**, en **TPM2-gebaseerde automatische encryptie**. Afgesloten met een naadloze **Hyprland** desktop en **snelle data recovery** via rclone.

---

## 1. Voorbereiding
- Arch Linux ISO (laatste release) op USB-stick (`dd` of `Rufus`)
- UEFI geactiveerd in BIOS
- Secure Boot tijdelijk **uit** in BIOS (schakelen we straks weer in)
- TPM 2.0 ingeschakeld in BIOS
- Internetverbinding

Controleer connectiviteit:
```bash
ping archlinux.org
```

---

## 2. Boot & Basisinstellingen
Toetsenbordlayout instellen:
```bash
loadkeys us           # of 'nl'
```

Tijd synchroniseren:
```bash
timedatectl set-ntp true
```

Controleer UEFI boot:
```bash
ls /sys/firmware/efi/efivars
```

---

## 3. Schijfindeling (Btrfs + LUKS2)
We maken **twee partities**: een kleine EFI en de rest voor de geëncrypteerde root.
Voorbeeld schijf: `/dev/nvme0n1`.

Partitioner:
```bash
gdisk /dev/nvme0n1
# Druk op 'n' voor nieuwe partitie
# Eerste partitie: +512M, type EF00 (EFI System Partition)
# Druk op 'n' voor nieuwe partitie
# Tweede partitie: Gebruik de rest, type 8300 (Linux filesystem)
# Druk op 'w' om wijzigingen weg te schrijven
```

Formatteren EFI partitie:
```bash
mkfs.fat -F32 /dev/nvme0n1p1
```

LUKS2 encryptie op root partitie (stel een **sterk passphrase** in!):
```bash
cryptsetup luksFormat --type luks2 /dev/nvme0n1p2
```

Ontgrendel de root partitie:
```bash
cryptsetup open /dev/nvme0n1p2 cryptroot
```

Creëer Btrfs bestandssysteem:
```bash
mkfs.btrfs /dev/mapper/cryptroot
```

---

## 4. Btrfs Subvolumes
Mount de Btrfs root en maak subvolumes:
```bash
mount /dev/mapper/cryptroot /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
umount /mnt
```

Mount de subvolumes met optimale Btrfs opties:
```bash
mount -o subvol=@,compress=zstd:3,noatime,ssd,space_cache=v2,discard=async /dev/mapper/cryptroot /mnt
mkdir -p /mnt/{boot,home,.snapshots}
mount -o subvol=@home,compress=zstd:3,noatime,ssd,space_cache=v2,discard=async /dev/mapper/cryptroot /mnt/home
mount -o subvol=@snapshots,compress=zstd:3,noatime,ssd,space_cache=v2,discard=async /dev/mapper/cryptroot /mnt/.snapshots
mount /dev/nvme0n1p1 /mnt/boot
```

---

## 5. Basisinstallatie
Installeer essentiële pakketten:
```bash
pacstrap /mnt base linux linux-firmware btrfs-progs vim networkmanager git openssh
```

Genereer fstab:
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

Change root naar nieuwe systeem:
```bash
arch-chroot /mnt
```

---

## 6. Systeemconfiguratie
Tijdzone instellen:
```bash
ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
hwclock --systohc
```

Locale instellen (pas aan naar wens, UTF-8 is standaard):
```bash
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen
```

Hostnaam instellen:
```bash
echo "xps" > /etc/hostname
```

Wachtwoord root gebruiker:
```bash
passwd
```

Creëer een normale gebruiker:
```bash
useradd -m -g users -G wheel,storage,power -s /bin/bash rroethof
passwd rroethof
```

---

## 7. Sudo Configuratie: Veiligheid of Gemak?
Kies je pad: beveiliging óf gemak.

### Optie 1: Met Wachtwoord (Standaard Beveiligd)
Gebruikers in de wheel groep typen hun wachtwoord in bij elk sudo commando. Extra check, minder snel.
```bash
echo "%wheel ALL=(ALL:ALL) ALL" | sudo tee /etc/sudoers.d/wheel_sudo > /dev/null
```

### Optie 2: Zonder Wachtwoord (Snel en Risicovol)
Gebruikers in wheel voeren sudo commando's uit zonder wachtwoord. Snel, maar minder veilig.
```bash
echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/wheel_sudo > /dev/null
```

**Let op:** Wijzig `sudoers` altijd met `visudo`. Dit voorkomt fouten. Bovenstaande commando's zijn voor een snelle setup, maar wees je bewust van de risico's.

---

## 8. UKI + mkinitcpio
Installeer vereisten voor UKI:
```bash
pacman -S systemd mkinitcpio mkinitcpio-systemd-tools
```

Pas `/etc/mkinitcpio.conf` aan. Voeg NVIDIA modules toe voor je 4070 en de benodigde hooks:
```bash
vim /etc/mkinitcpio.conf
```

`MODULES=(i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm)`
`HOOKS=(systemd autodetect keyboard sd-vconsole modconf block sd-encrypt filesystems)`

Maak UKI buildconfig `/etc/mkinitcpio.d/linux.preset`. Deze zorgt dat UKI's in EFI-partitie komen:
```bash
vim /etc/mkinitcpio.d/linux.preset
```

`PRESETS=('default')`
`default_uki="/efi/EFI/Linux/arch.efi"`

Bouw de Unified Kernel Image:
```bash
mkinitcpio -P
```

---

## 9. Secure Boot met sbctl
Installeer sbctl:
```bash
pacman -S sbctl
```

Genereer Secure Boot sleutels:
```bash
sbctl create-keys
```

Enroleer Microsoft sleutels voor compatibiliteit (optioneel, maar aanbevolen):
```bash
sbctl enroll-keys --microsoft
```

Signeer je UKI en EFI binaries:
```bash
sbctl sign -s /efi/EFI/Linux/arch.efi
sbctl sign -s /boot/EFI/systemd/systemd-bootx64.efi
```

---

## 10. TPM Auto-Decrypt
Installeer tools:
```bash
pacman -S systemd-cryptenroll tpm2-tools
```

Koppel LUKS key slot aan TPM2 module. **BELANGRIJK:** Gebruik het apparaat (`/dev/nvme0n1p2`), niet de mapper (`/dev/mapper/cryptroot`):
```bash
systemd-cryptenroll --tpm2-device=auto /dev/nvme0n1p2
```

Voeg TPM2 device toe aan `crypttab.initramfs` voor automatische ontgrendeling. Dit bestand wordt gebruikt door de initramfs:
```bash
echo "cryptroot /dev/nvme0n1p2 none tpm2-device=auto" > /etc/crypttab.initramfs
```

**Herbouw mkinitcpio** om de TPM2 configuratie in de initramfs op te nemen:
```bash
mkinitcpio -P
```

---

## 11. Bootloader (systemd-boot)
Installeer systemd-boot:
```bash
bootctl install
```

Configureer `/boot/loader/loader.conf`. **Voeg Kernel Lockdown Mode toe:**
```bash
vim /boot/loader/loader.conf
```

`default arch`
`timeout 0`
`console-mode max`
`editor no`
`options lockdown=integrity`

**Let op**: Voor UKI's hoef je geen specifieke `.conf` entry te maken in `/boot/loader/entries/`. `systemd-boot` vindt de `arch.efi` UKI automatisch.

---

## 12. Secure Boot Heractiveren
Na test dat systeem correct opstart met TPM2 unlock:
- **Herstart** en ga naar je **BIOS/UEFI-instellingen**.
- Schakel **Secure Boot** in.
- Sla instellingen op en start opnieuw.
Controleer na boot de status:
```bash
sbctl verify
```

---

## 13. Eerste Reboot
Verlaat de chroot omgeving:
```bash
exit
```

Unmount alle partities:
```bash
umount -R /mnt
```

Reboot het systeem:
```bash
reboot
```

---

## 14. Hyprland Auto-Install (via JaKooLit/Arch-Hyprland)
**Voer dit uit ná de eerste reboot en login als je normale gebruiker.** Dit automatiseert de Wayland desktop setup.
Installeer Git:
```bash
sudo pacman -S git
```

Clone en voer het script uit:
```bash
git clone https://github.com/JaKooLit/Arch-Hyprland.git
cd Arch-Hyprland
./install.sh
```

Voordeel: Direct een complete Wayland-setup met Hyprland, Waybar, Kitty en geoptimaliseerde configuratie.

**NVIDIA Wayland fix (voor Hyprland)**: Voeg deze toe aan je kernel command line in `/etc/kernel/cmdline` of via je bootloader config.
```bash
nvidia_drm.modeset=1
```

En in je environment (bijvoorbeeld in `~/.bashrc` of `/etc/environment`):
```bash
WLR_NO_HARDWARE_CURSORS=1
```

---

## 15. Rclone Installatie
```bash
sudo pacman -S rclone
```

---

## 16. Google Drive Configuratie
Start de configuratie wizard:
```bash
rclone config
```

- Kies `n` voor nieuwe remote.
- Geef een naam, bijvoorbeeld `gdrive`.
- Kies het nummer voor Google Drive (meestal `13`).
- Beantwoord de vragen (laat `client_id` en `client_secret` leeg, tenzij je eigen API keys hebt).
- Kies `1` voor volledige toegang (`Full access all files`).
- Laat `advanced config` leeg.
- Kies `auto config` als je een browser hebt, anders volg de instructies voor handmatige authenticatie (token kopiëren).
- Sla de configuratie op en verlaat (`q`).

---

## 17. Data Recovery (Snelle modus)
Maak een herstelmap aan:
```bash
mkdir -p ~/recovery
```

Download je Google Drive data. Deze commando's zorgen voor optimale snelheid (hoge transfers, checkers, grotere chunks):
```bash
rclone copy gdrive:/pad/naar/backups ~/recovery --progress --transfers=16 --checkers=16 --drive-chunk-size=64M --fast-list
```

**Optioneel: Google Drive direct mounten** (voor directe toegang zonder kopiëren):
```bash
mkdir ~/GDrive
rclone mount gdrive:/ ~/GDrive --vfs-cache-mode=writes &
```

Dit mount je Google Drive als een lokale map.

---

## 18. Robuustheid & Herstel

### Btrfs Periodieke Controles
Voeg `systemd` timers toe voor periodieke `btrfs scrub` (data-integriteit) en `btrfs balance` (gelijkmatige dataverdeling):
```bash
sudo systemctl enable btrfs-scrub@-.timer
sudo systemctl start btrfs-scrub@-.timer
sudo systemctl enable btrfs-balance@-.timer
sudo systemctl start btrfs-balance@-.timer
```

### TPM2 Fallback Passphrase
Voeg een fallback passphrase toe aan LUKS voor het geval TPM2 om welke reden dan ook faalt (bijv. BIOS/firmware update):
```bash
sudo cryptsetup luksAddKey /dev/nvme0n1p2
```

Volg de instructies.

### Automatische UKI en Secure Boot Signing Hook
Maak een `pacman` hook die automatisch een nieuwe UKI bouwt en signeert na elke kernelupdate. Creëer `/etc/pacman.d/hooks/90-uki-secureboot.hook`:
```bash
[Trigger]
Operation = Install
Operation = Upgrade
Operation = Remove
Type = Package
Target = linux
[Action]
Description = Rebuilding UKI and signing with sbctl...
When = PostTransaction
Exec = /usr/bin/bash -c "mkinitcpio -P && sbctl sign -s /efi/EFI/Linux/arch.efi"
```

### Snapshot Automatiseren (voor rollback)
Installeer `snapper` en configureer het voor automatische snapshots bij `pacman` transacties:
```bash
sudo pacman -S snapper
sudo btrfs subvolume create /.snapshots
sudo mount -o subvol=/.snapshots,compress=zstd:3,noatime,ssd,space_cache=v2,discard=async /dev/mapper/cryptroot /.snapshots
sudo umount /.snapshots
sudo snapper -c root create-config /
```

Configureer vervolgens `/etc/snapper/configs/root` voor automatische pre- en post-installatie snapshots.

---
