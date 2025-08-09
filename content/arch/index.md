---
date: 2025-05-18
description: "Complete Arch Linux installatiehandleiding met Btrfs, UKI, Secure Boot, TPM2 encryptie en Hyprland op mijn Dell XPS 9530."
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
Arch Linux Installatie met TPM2 Encryptie, UKI en Hyprland 🚀
{{< /typeit >}}

Hier vind je een strakke, stap-voor-stap handleiding om Arch Linux te installeren op een **Dell XPS 9530** met 32GB RAM, GeForce 4070 en 1TB NVMe.  
De installatie gebruikt **UEFI**, **Btrfs**, **Unified Kernel Images**, **Secure Boot** en **TPM2-gebaseerde automatische encryptie**, en eindigt met een volledige **Hyprland** desktopomgeving.

---

## 1. Voorbereiding
- Arch Linux ISO (laatste release) op USB-stick (`dd` of `Rufus`)
- UEFI geactiveerd
- Secure Boot tijdelijk **uit**
- TPM 2.0 ingeschakeld
- Internetverbinding

```bash
ping archlinux.org
```

---

## 2. Boot & Basisinstellingen
```bash
loadkeys us
timedatectl set-ntp true
ls /sys/firmware/efi/efivars
```

---

## 3. Schijfindeling (Btrfs + LUKS2)
```bash
gdisk /dev/nvme0n1
# EFI 512M type EF00
# Rest type 8300
mkfs.fat -F32 /dev/nvme0n1p1
cryptsetup luksFormat --type luks2 /dev/nvme0n1p2
cryptsetup open /dev/nvme0n1p2 cryptroot
mkfs.btrfs /dev/mapper/cryptroot
```

---

## 4. Btrfs Subvolumes
```bash
mount /dev/mapper/cryptroot /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
umount /mnt
mount -o subvol=@,compress=zstd,noatime /dev/mapper/cryptroot /mnt
mkdir -p /mnt/{boot,home,.snapshots}
mount -o subvol=@home,compress=zstd,noatime /dev/mapper/cryptroot /mnt/home
mount -o subvol=@snapshots,compress=zstd,noatime /dev/mapper/cryptroot /mnt/.snapshots
mount /dev/nvme0n1p1 /mnt/boot
```

---

## 5. Basisinstallatie
```bash
pacstrap /mnt base linux linux-firmware btrfs-progs vim networkmanager
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```

---

## 6. Systeemconfiguratie
```bash
ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
hwclock --systohc
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen
echo "xps" > /etc/hostname
```

---

## 7. UKI + mkinitcpio
```bash
pacman -S systemd mkinitcpio mkinitcpio-systemd-tools
```

`/etc/mkinitcpio.conf`:
```bash
MODULES=(i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm)
HOOKS=(systemd autodetect keyboard sd-vconsole modconf block sd-encrypt filesystems)
```

`/etc/mkinitcpio.d/linux.preset`:
```bash
PRESETS=('default')
default_uki="/efi/EFI/Linux/arch.efi"
```

```bash
mkinitcpio -P
```

---

## 8. Secure Boot met sbctl
```bash
pacman -S sbctl
sbctl create-keys
sbctl enroll-keys --microsoft
sbctl sign -s /efi/EFI/Linux/arch.efi
```

---

## 9. TPM Auto-Decrypt
```bash
pacman -S systemd-cryptenroll tpm2-tools
systemd-cryptenroll --tpm2-device=auto /dev/nvme0n1p2
echo "cryptroot /dev/nvme0n1p2 none tpm2-device=auto" > /etc/crypttab.initramfs
mkinitcpio -P
```

---

## 10. Bootloader
```bash
bootctl install
```

`/boot/loader/loader.conf`:
```bash
default arch
timeout 0
console-mode max
editor no
```

---

## 11. Hyprland Auto-Install
```bash
pacman -S git
git clone https://github.com/JaKooLit/Arch-Hyprland.git
cd Arch-Hyprland
./install.sh
```

Voordeel: Direct complete Wayland-setup met Hyprland, Waybar, Kitty en optimalisaties.

---

## 12. Secure Boot Heractiveren
Na succesvolle boot:
- Secure Boot in BIOS aanzetten
- Verifiëren:
```bash
sbctl
```

---

## 13. Eerste Reboot
Verlaat chroot en unmount alles:
```bash
exit
umount -R /mnt
reboot
```

---

## 14. Rclone Installatie
Na inloggen op je nieuwe Arch Linux:
```bash
sudo pacman -S rclone
```

---

## 15. Google Drive Configuratie
```bash
rclone config
```
- Kies **n** (new remote)
- Geef een naam, bijvoorbeeld `gdrive`
- Kies **13** voor Google Drive
- Beantwoord de vragen (client_id leeg laten tenzij je custom API keys hebt)
- Kies **1** voor volledige toegang
- Laat advanced config leeg
- Kies **auto config** als je een browser hebt, anders handmatig via token kopiëren
- Sla op en verlaat (`q`)
```

---

## 16. Data Recovery
Maak een herstelmap aan:
```bash
mkdir -p ~/recovery
```

Download je Google Drive data:
```bash
rclone copy gdrive:/pad/naar/backups ~/recovery --progress
```

---

Nu staat je Google Drive data lokaal terug. 
Tip: Voor snelle restores in de toekomst kun je `rclone mount` gebruiken om Google Drive als een map in je bestandssysteem te benaderen.