---
date: '2025-02-24T07:12:32+01:00'
draft: false
title: 'Taming the Beast: My Arch Linux Install for a Clean, Mean, and Secure Work Machine'
tags:
  - 'Arch Linux'
  - 'system installation'
  - 'security'
  - 'configuration'
  - 'setup guides'
  - 'productivity'
  - 'clean install'
  - 'mean machine'
categories:
  - 'Linux'
  - 'Arch Linux'
  - 'System Installation'
  - 'Security'
  - 'Configuration'
  - 'Setup Guides'
  - 'Productivity'
---

So, I've done it again. I've decided to ditch Windows on my company laptop (for the, uh, nth time). I briefly flirted with FreeBSD (it was okay, but let's just say my other laptop wasn't playing nice with it), and I really wanted a consistent setup across both machines.

Normally, my server go-to is Debian.  Rock solid, reliable, the workhorse of the internet. But for this project, I felt the pull of the Arch.  

## Why Arch?

A few key reasons:

 * Lightweight: Arch is lean and mean. It lets you build up your system exactly how you want it, without any bloat. Perfect for squeezing every ounce of performance out of your hardware.
 * Customizable: Want a system tailored just for you? Arch's the answer. From the kernel to the desktop environment, you're in control.
 * Community Driven: The Arch community is amazing. Super active, incredibly helpful, and a treasure trove of information. Stuck? Someone's probably already solved it (and documented it).
 * Surprisingly Simple (for Linux veterans): Okay, "simple" is relative.  Arch's process is actually quite elegant. It's a hands-on experience, but that's part of the fun!


This isn't just any Arch install, though.  We're going all the way:

 * Clean Base: We're starting from scratch, building a pristine system.
 * Btrfs Filesystem: Modern, flexible, and perfect for snapshots (because who doesn't love snapshots?).
 * Unified Kernel Images (UKIs) with mkinitcpio: For a faster and more secure boot process. UKIs combine the kernel, initramfs, and other necessary components into a single, easily manageable file.
 * Secure Boot with sbctl: Locking down the boot process to prevent any nasty surprises. sbctl makes managing Secure Boot keys a breeze.
 * TPM-Backed Encryption: Using your Trusted Platform Module for secure and automatic unlocking of your encrypted drives. Think of it as Fort Knox for your data.
 * Your DE of Choice: The beauty of Arch! You get to pick your favorite Desktop Environment. *But that is for a next blogpost.*

Ready to dive in?  First, you'll need the latest Arch Linux ISO.  Grab it from https://geo.mirror.pkgbuild.com/iso/latest/.

Next, you'll need to write that ISO to a USB drive.  Tools like dd, Rufus, or Etcher all work great for this.  Once you've got your bootable USB, fire it up and make sure you have an internet connection.  Then, we can start the real fun!  Stay tuned for the next post where we'll walk through the installation steps.

## Disk Prep: Laying the Foundation for Our Arch Fortress

Alright, let's get down to the nitty-gritty: preparing our disk for the Arch Linux adventure.  We're going for a clean and secure setup, so we'll be using a 512MB FAT32 partition for our EFI system partition and a LUKS-encrypted Btrfs partition for our root filesystem. And because we're all about doing things right, we'll use the correct partition types so systemd can easily find everything [more on that here: (https://uapi-group.org/specifications/specs/discoverable_partitions_specification/)].

First, we need to identify our target drive.  Double-check this step!  Formatting the wrong drive can lead to data loss. Use _lsblk_ for a clear overview:

```
lsblk
```

This will list your drives and partitions.  In this example, our drive is _/dev/nvme0n1_, but yours might be different!  It could be _/dev/sda_, _/dev/sdb_, etc.  Replace _/dev/nvme0n1_ with your actual drive name throughout this guide.

```
lsblk
    NAME  MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
    loop0     7:0    0   673M  1 loop /run/archiso/airootfs
    sr0      11:0    1 793.3M  0 rom  /run/archiso/bootmnt
    nvme0n1 259:0    0 953.9G  0 disk
```

Now that we've identified our drive (_/dev/nvme0n1_ in this example - remember to change this if yours is different), we'll use _sgdisk_ to partition it:

```
# Read partition table
partprobe /dev/nvme0n1
```

```
# Delete old partition layout
wipefs -af /dev/nvme0n1
sgdisk --zap-all --clear /dev/nvme0n1
```

```
# Read partition table
partprobe /dev/nvme0n1
```

```
# Partition disk and re-read partition table
sgdisk -n 1:0:+512M -t 1:ef00 -c 1:EFI /dev/nvme0n1
sgdisk -n 2:0:0 -t 2:8304 -c 2:LINUXROOT /dev/nvme0n1
```

```
# Read partition table
partprobe -s /dev/nvme0n1
```

This creates two partitions:

 * /dev/nvme0n1p1: 512MB, EFI System Partition
 * /dev/nvme0n1p2: Remaining space, for our encrypted root partition

Let's verify:

```
lsblk /dev/nvme0n1
    NAME        MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
    nvme0n1     259:0    0 953.9G  0 disk  
    ├─nvme0n1p1 259:1    0   512M  0 part  
    └─nvme0n1p2 259:3    0 953.4G  0 part  
```

Looking good! Now, encrypt the root partition using LUKS2:
```
# Encrypt and open LUKS partition
cryptsetup --type luks2 --hash sha512 --use-random luksFormat /dev/disk/by-partlabel/LINUXROOT
cryptsetup luksOpen /dev/disk/by-partlabel/LINUXROOT linuxroot
```

Next, create the filesystems:
```
# Format partition 
mkfs.vfat -F32 -n EFI /dev/disk/by-partlabel/EFI
mkfs.btrfs -f -L linuxroot /dev/mapper/linuxroot
```

Mount the partitions and create Btrfs subvolumes:
```
# List of subvolumes (excluding @)
subvolumes=(
    "@root"
    "@home"
    "@srv"
    "@opt"
    "@tmp"
    "@var"
    "@var_log"
    "@var_log_audit"
    "@var_lib"
    "@var_cache"
    "@var_pkgs"
    "@var_spool"
    "@var_tmp"
    "@usr"
    "@usr_local"
    "@snapshots"
)
```

```
# Mount options
mount_opts="rw,noatime,compress=zstd:3,ssd,subvol="
```

```
# Base mount directory
base_mount="/mnt"
```

```
# --- Create Subvolumes ---
echo "Creating subvolumes..."
mount /dev/mapper/linuxroot /mnt #Mount root volume to /mnt to create subvolumes.
```

```
btrfs subvolume create "$base_mount/@"
```

```
for subvol in "${subvolumes[@]}"; do
    btrfs subvolume create "$base_mount/$subvol"
    if [ $? -ne 0 ]; then
        echo "Failed to create subvolume $subvol"
        exit 1
    fi
done
```

```
umount /mnt #Unmount root volume.
echo "Subvolumes created."
```

```
# --- Mount Subvolumes ---
echo "Mounting subvolumes..."

# Mount the @ subvolume
echo "Mounting @ subvolume..."
mkdir -p "$base_mount"
mount -o rw,noatime,compress=zstd:3,ssd,subvol=@ /dev/mapper/linuxroot "$base_mount"
echo "@ subvolume mounted."
```

```
# Mount the other subvolumes
for subvol in "${subvolumes[@]}"; do
    echo "Mounting $subvol subvolume..."
    mount_point="$base_mount/${subvol#@}"

    mkdir -p "$mount_point"

    mount -o ${mount_opts}${subvol} /dev/mapper/linuxroot "$mount_point"

    if [ $? -ne 0 ]; then
        echo "Failed to mount subvolume $subvol to $mount_point"
        exit 1
    fi
    echo "$subvol subvolume mounted."
done

echo "All subvolumes created and mounted successfully."
```

```
btrfs subvolume list /mnt

    ID 256 gen 9 top level 5 path @
    ID 257 gen 9 top level 5 path @root
    ID 258 gen 9 top level 5 path @home
    ID 259 gen 9 top level 5 path @srv
    ID 260 gen 9 top level 5 path @opt
    ID 261 gen 9 top level 5 path @tmp
    ID 262 gen 9 top level 5 path @var
    ID 263 gen 9 top level 5 path @var_log
    ID 264 gen 9 top level 5 path @var_log_audit
    ID 265 gen 9 top level 5 path @var_lib
    ID 266 gen 9 top level 5 path @var_cache
    ID 267 gen 9 top level 5 path @var_pkgs
    ID 268 gen 9 top level 5 path @var_spool
    ID 269 gen 9 top level 5 path @var_tmp
    ID 270 gen 9 top level 5 path @usr
    ID 271 gen 9 top level 5 path @usr_local
    ID 272 gen 9 top level 5 path @snapshots
```

```
mkdir /mnt/efi
mount /dev/disk/by-partlabel/EFI /mnt/efi
```

## Base Install
Now, let's update the pacman mirrors and install the base system:

```
# CPU vendor
if cat /proc/cpuinfo | grep "vendor" | grep "GenuineIntel" > /dev/null; then
    export CPU_MICROCODE="intel-ucode"
elif cat /proc/cpuinfo | grep "vendor" | grep "AuthenticAMD" > /dev/null; then
    export CPU_MICROCODE="amd-ucode"
    export AMD_SCALING_DRIVER="amd_pstate=active"
fi
```

###
```
reflector --country NL --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
```

```
pacman-key --init
pacman-key --populate
pacstrap -K /mnt base base-devel linux linux-firmware vim nano cryptsetup btrfs-progs dosfstools util-linux git unzip sbctl kitty networkmanager sudo tpm2-tools tpm2-tss openssh ${CPU_MICROCODE}
```

This installs the essential packages for a functional Arch system.  We've included some handy tools like _vim_, _nano_, _git_, _unzip_, _sbctl_, _kitty_, _networkmanager_ and _sudo_.  Remember to adjust the _--country_ flag in _reflector_ if you're not in the Netherlands.

```
# Generate filesystem tab
genfstab -U /mnt >> /mnt/etc/fstab
```
## Locale configuration

Let's configure our locale settings:
```
sed -i -e "/^#"en_US.UTF-8"/s/^#//" /mnt/etc/locale.gen
systemd-firstboot --root /mnt --prompt
```

This interactive prompt will guide you through setting the keymap, timezone, and hostname.  For example:

```
    Welcome to your new installation of Arch Linux!
    Please configure your system!

    -- Press any key to proceed --
    ‣ Please enter system keymap name or number (empty to skip, "list" to list options): us
    /mnt/etc/vconsole.conf written.
    ‣ Please enter timezone name or number (empty to skip, "list" to list options): Europe/Amsterdam
    /mnt/etc/localtime written
    ‣ Please enter hostname for new system (empty to skip): xps
    /mnt/etc/hostname written.
```

Generate the locales:
```
arch-chroot /mnt locale-gen
    Generating locales...
    en_US.UTF-8... done
    Generation complete.
```
## User creation

Create your user account (replace rroethof with your desired username):
```
arch-chroot /mnt useradd -G wheel -m rroethof 
arch-chroot /mnt passwd rroethof
```
Add your user to the wheel group for sudo privileges:
```
sed -i -e '/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/s/^# //' /mnt/etc/sudoers
```

## Unified Kernel fun

Let's configure Unified Kernel Images (UKIs). First, create the kernel command line file:
```
echo "quiet rw" >/mnt/etc/kernel/cmdline
```

Create the EFI directory structure:
```
mkdir -p /mnt/efi/EFI/Linux
```

We need to change the HOOKS in _mkinitcpio.conf_ to use systemd, so make yours look like:
```
nano -w /mnt/etc/mkinitcpio.conf
```

### 
```
# vim:set ft=sh
MODULES=(BTRFS)

BINARIES=()

FILES=()

HOOKS=(base systemd autodetect modconf kms keyboard sd-vconsole sd-encrypt block filesystems fsck)
```

Update the _.preset_ file (_/mnt/etc/mkinitcpio.d/linux.preset_):
```
nano -w /mnt/etc/mkinitcpio.d/linux.preset
```

### 
```
# mkinitcpio preset file to generate UKIs

ALL_config="/etc/mkinitcpio.conf"
ALL_kver="/boot/vmlinuz-linux"
ALL_microcode=(/boot/*-ucode.img)

PRESETS=('default' 'fallback')

#default_config="/etc/mkinitcpio.conf"
#default_image="/boot/initramfs-linux.img"
default_uki="/efi/EFI/Linux/arch-linux.efi"
default_options="--splash /usr/share/systemd/bootctl/splash-arch.bmp"

#fallback_config="/etc/mkinitcpio.conf"
#fallback_image="/boot/initramfs-linux-fallback.img"
fallback_uki="/efi/EFI/Linux/arch-linux-fallback.efi"
fallback_options="-S autodetect"
```

Generate the UKIs:
```
arch-chroot /mnt mkinitcpio -P
    ==> Building image from preset: /etc/mkinitcpio.d/linux.preset: 'default'
    ==> Using configuration file: '/etc/mkinitcpio.conf'
    ... (output omitted) ...
    ==> Unified kernel image generation successful
```
Verify the UKIs are in the EFI partition:
```
ls -lR /mnt/efi
    /mnt/efi:
    total 4
    drwxr-xr-x 3 root root 4096 Feb 23 21:55 EFI

    /mnt/efi/EFI:
    total 4
    drwxr-xr-x 2 root root 4096 Feb 23 21:55 Linux

    /mnt/efi/EFI/Linux:
    total 510464
    -rwx------ 1 root root 293854840 Feb 23 21:55 arch-linux-fallback.efi
    -rwx------ 1 root root 228859512 Feb 23 21:55 arch-linux.efi
```

## Services and Boot Loader

OK, we're just about done in the archiso, we just need to enable some services, and install our bootloader:
```
systemctl --root /mnt enable systemd-resolved systemd-timesyncd NetworkManager
systemctl --root /mnt mask systemd-networkd
arch-chroot /mnt bootctl install --esp-path=/efi
arch-chroot /mnt hwclock --systohc --localtime
```

## Reboot and Secure Boot Setup

Okay, we're in the home stretch!  It's time to reboot and finalize our Arch Linux installation.
```
sync  # Ensure all data is written to disk
systemctl reboot --firmware-setup  # Reboot and enter firmware setup
```

Crucially, while your system is rebooting, you'll need to enter your UEFI/BIOS settings and enable "Setup Mode" for Secure Boot.  The exact steps for this vary depending on your motherboard manufacturer.  Consult your motherboard's manual or search online for instructions specific to your system.  Generally, you'll be looking for something like "Secure Boot," "Setup Mode," "Enroll EFI Key," or similar terms.

Why Setup Mode?  We need to enroll our Secure Boot keys so that our system trusts the newly generated UKIs and can boot securely.

Once you've entered Setup Mode, you'll typically need to navigate to a section related to Secure Boot keys.  There should be an option to "Enroll EFI Key" or "Add New Key."  You'll want to point this to the EFI partition on your Arch Linux installation, specifically the UKI files we created earlier.  The path will likely be something like _/efi/EFI/Linux/arch-linux.efi_.  You may need to repeat this process for both _arch-linux.efi_ and _arch-linux-fallback.efi_.

After enrolling the keys, make sure to exit Setup Mode and enable Secure Boot in your UEFI/BIOS settings.  Again, consult your motherboard's documentation for the exact procedure.

## Secure Boot with TPM2 Unlocking

Now that we've rebooted, let's configure Secure Boot and TPM2 unlocking for our encrypted root partition.

First, check the Secure Boot status:
```
sbctl status
    Installed:  ✓ sbctl is installed
    Setup Mode: ✗ Enabled
    Secure Boot:    ✗ Disabled
    Vendor Keys:    none
```

Looks good! Let's create and enroll our Secure Boot keys:
```
sudo sbctl create-keys
sudo sbctl enroll-keys -m
```

The _-m_ option enrolls the Microsoft vendor key along with our own.  This is generally recommended for broader hardware compatibility.  However, be aware that enrolling the Microsoft key could potentially introduce security vulnerabilities if Microsoft's signing keys are ever compromised.  If you're absolutely certain none of your hardware relies on Microsoft signed Option ROMs (OPROMs), you can omit the _-m_ flag.  This is a risk you must assess yourself.

Now, sign the EFI files using _sbctl_. The _-s_ option ensures automatic resigning when kernels or bootloaders are updated:

```
sudo sbctl sign -s -o /usr/lib/systemd/boot/efi/systemd-bootx64.efi.signed /usr/lib/systemd/boot/efi/systemd-bootx64.efi
sudo sbctl sign -s /efi/EFI/BOOT/BOOTX64.EFI
sudo sbctl sign -s /efi/EFI/Linux/arch-linux.efi
sudo sbctl sign -s /efi/EFI/Linux/arch-linux-fallback.efi
```

Reinstall the kernel to trigger the automatic resigning of the UKI:

```
    sudo pacman -S linux
        ... (output omitted) ...
        (4/4) Signing EFI binaries...
        Generating EFI bundles....
        ✓ Signed /efi/EFI/Linux/arch-linux-fallback.efi
        ✓ Signed /efi/EFI/Linux/arch-linux.efi
```
Reboot your PC to save the Secure Boot settings.

Unless you want to continue to be able to unlock your partition with the password you originally setup, you should run 'sudo systemd-cryptenroll --wipe-slot=0' to remove it. I assume you would want to do this if you are generating and saving a 'recovery key', otherwise it's just redundant with your original password.
```
    sudo systemd-cryptenroll --wipe-slot=0'
```

After rebooting, configure automatic unlocking of the root filesystem using the TPM. Generate a recovery key (keep this extremely safe!):
```
    sudo systemd-cryptenroll /dev/gpt-auto-root-luks --recovery-key
```

Now, enroll the system firmware and Secure Boot state with the TPM.  The _--tpm2-pcrs=0+7_ option binds the LUKS key to PCRs 0 and 7, which represent the system firmware and Secure Boot state, respectively.  For added security, you can use _--tpm2-with-pin=yes_ to require a PIN at boot.
```
    sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/gpt-auto-root-luks  
    sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7,10 /dev/gpt-auto-root-luks  
```

Or with PIN: _--tpm2-with-pin=yes_
```
    sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/gpt-auto-root-luks -tpm2-with-pin=yes
    sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7,10 /dev/gpt-auto-root-luks -tpm2-with-pin=yes
```

### Key Differences and Security Implications:

#### PCRs 0+7 (Command 1):
This notation means PCRs 0 through 7 are used.
These PCRs are measured early in the boot process.
They tend to be relatively static, meaning their values don't change much between boots.
This makes them vulnerable to attacks where an attacker replays an earlier boot state.
#### PCRs 7,10 (Command 2):
This notation means PCRs 7 and 10 are used.
PCR 10, in particular, is measured later in the boot process.
This makes it more dynamic, as its value can change based on the OS and kernel configuration.
Using a dynamic PCR like 10 significantly enhances security.
#### Which One Is Correct?
For enhanced security, Command 2 (--tpm2-pcrs=7,10) is the correct choice.
It incorporates a dynamic PCR, making it much harder for an attacker to bypass the TPM-based encryption.

Reboot and test the TPM unlocking.  If everything is configured correctly, your encrypted root partition should unlock automatically (or with the PIN, if you set that up).

# Job Done!

Congratulations! You now have a secure and customized Arch Linux installation with Secure Boot and TPM2 unlocking.  You can now install your preferred Desktop Environment and further customize your system.

![The beast running Arch Linux](/image/neofetch.png)