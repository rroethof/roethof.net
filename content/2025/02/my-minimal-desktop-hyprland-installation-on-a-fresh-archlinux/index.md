---
date: '2025-02-25T12:25:32+01:00'
draft: false
title: 'My minimal desktop (Hyprland) installation on a fresh Archlinux'
tags:
  - 'Arch Linux'
  - 'HyprLand'
  - 'desktop environments'
  - 'minimalist setup'
  - 'system installation'
  - 'command line'
  - 'hyprland'
categories:
  - 'Linux'
  - 'Arch Linux'
  - 'HyprLand'
  - 'Desktop Environments'
  - 'Minimalist Setup'
  - 'System Installation'
  - 'Command Line'
---

## We Tamed the Beast! Arch Linux + Hyprland = 🔥

Okay, folks, the deed is done! We finally wrestled Arch Linux onto our metal monster (aka "the beast").  It was a bit of a marathon, but we emerged victorious. Now, the real fun begins: crafting a minimal, sleek desktop experience.  Our weapon of choice? Wayland, naturally, and the star of the show: Hyprland.

## Hyprland: What's the Hype?
If you haven't heard of Hyprland, you're missing out.  It's a Wayland compositor (think of it as the brains behind your desktop visuals) written in C++ that's making waves.  Why?  Because it's dynamic.  We're talking smooth animations that'll make your eyes happy, tiling that adapts to your workflow like a chameleon, and, yes, rounded corners because who doesn't love rounded corners? It's like the cool kid on the Wayland block.

## Getting Our Hands Dirty: Installing yay
First things first, we need to talk about the AUR (Arch User Repository). It's like a treasure trove of packages that aren't in the official Arch repos. To access this goldmine, we need an AUR helper.  Our go-to? _yay_.

Think of _yay_ as your friendly neighborhood package manager for the AUR. It makes installing stuff a breeze. Here's the drill:

    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si

Basically, we're grabbing the _yay_ source code, compiling it, and installing it. Easy peasy.

Lets update the _yay_ packages

    yay -Suy

## Prerequisits

Check the GPU vendor

    if lspci | grep "VGA" | grep "Intel" > /dev/null; then
        export GPU_PACKAGES="vulkan-intel intel-media-driver intel-gpu-tools"
        export GPU_MKINITCPIO_MODULES="i915"
        export LIBVA_ENV_VAR="LIBVA_DRIVER_NAME=iHD"
    elif lspci | grep "VGA" | grep "AMD" > /dev/null; then
        export GPU_PACKAGES="vulkan-radeon libva-mesa-driver radeontop mesa-vdpau"
        export GPU_MKINITCPIO_MODULES="amdgpu"
        export LIBVA_ENV_VAR="LIBVA_DRIVER_NAME=radeonsi"
    fi

Install GPU drivers related packages

    sudo pacman -S --noconfirm mesa vulkan-icd-loader vulkan-mesa-layers ${GPU_PACKAGES}

Override VA-API driver via environment variable

    echo "${LIBVA_ENV_VAR}" | sudo tee -a /etc/environment

Set env vars for AMDGPU

    if lspci | grep "VGA" | grep "AMD" > /dev/null; then
        echo "AMD_VULKAN_ICD=RADV" | sudo tee -a /etc/environment
        echo "VDPAU_DRIVER=radeonsi" | sudo tee -a /etc/environment

    elif lspci | grep "VGA" | grep "Intel" > /dev/null; then
        echo "VDPAU_DRIVER=va_gl" | sudo tee -a /etc/environment
    fi

Install Video tools

    sudo pacman -S --noconfirm libva-utils vdpauinfo vulkan-tools

## Install PipeWire and WirePlumber

    sudo pacman -S --noconfirm pipewire pipewire-alsa pipewire-jack pipewire-pulse libpulse wireplumber --ask 4

## Hyprland Time: Let's Get This Show on the Road!

Alright, folks, the moment we've all been waiting for: Hyprland installation time! Since Hyprland lives in the AUR (Arch User Repository), our trusty sidekick _yay_ is gonna help us out.

### Taming the WiFi Beast (Power Save Off!)

Before we dive in, let's wrangle that pesky WiFi power saving feature.  It can sometimes cause hiccups, so we're disabling it preemptively.  Better safe than sorry, right?

    echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a /etc/NetworkManager/conf.d/wifi-powersave.conf
    sudo systemctl restart NetworkManager

This little snippet tells NetworkManager to chill with the power saving on our WiFi connection.

### Hyprland and Friends: The Installation Fiesta!

Now, let's bring on the main attraction! We're not just installing Hyprland; we're grabbing a whole bunch of essential tools to make our desktop sing.

    yay -S --noconfirm hyprland kitty waybar wofi mako polkit-gnome python-requests grim slurp pamixer brightnessctl gvfs bluez bluez-utils blueman xdg-desktop-portal-hyprland

That's a hefty command, but it's all good stuff.  We're getting:

 * Hyprland itself, of course!
 * _kitty_ for a blazing-fast terminal.
 * _waybar_ to keep us informed with a stylish status bar.
 * _wofi_ for launching apps like a pro.
 * _mako_ for notifications that don't get in the way.
 * _polkit-gnome_ for handling permissions.
 * _python-requests_ (a dependency, but important!).
 * _grim_ and _slurp_ for screenshotting magic.
 * _pamixer_ and _brightnessctl_ for controlling audio and brightness.
 * _gvfs_ for accessing remote files.
 * _bluez_, _bluez-utils_ and _blueman_ for Bluetooth connectivity.
 * _xdg-desktop-portal-hyprland_ to make sure sandboxed apps play nice with our system.

### Bluetooth Activation and Portal Cleanup

We're not quite done yet! Let's fire up the Bluetooth service:

    sudo systemctl enable --now bluetooth.service

And to avoid any portal conflicts down the road, we're clearing out some potentially problematic packages:

    yay -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk
    
Alright! The foundation is laid. Hyprland is primed and ready.  Now, the real fun begins: customizing it to our liking.  Stay tuned for the next post where we'll transform this raw power into a personalized, productivity-boosting machine!  Let's fire it up:

    hyprland