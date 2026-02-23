#!/bin/bash
set -euo pipefail

# Add the Hyprland COPR
cat > /etc/yum.repos.d/lionheartp-Hyprland.repo << 'EOF'
[copr:copr.fedorainfracloud.org:lionheartp:Hyprland]
name=Copr repo for Hyprland owned by lionheartp
baseurl=https://download.copr.fedorainfracloud.org/results/lionheartp/Hyprland/fedora-$releasever-$basearch/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://download.copr.fedorainfracloud.org/results/lionheartp/Hyprland/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1
EOF

# Install Hyprland and runtime dependencies needed by caelestia-shell
dnf install -y \
    hyprland \
    hyprlock \
    hypridle \
    xdg-desktop-portal-hyprland \
    qt6-qtdeclarative \
    qt6-qtshadertools \
    qt6-qtshadertools-devel \
    qt6-qtdeclarative-devel \
    qt6-qtwayland \
    qt6-qtwayland-devel \
    qt6-qtsvg \
    spirv-tools \
    wayland-devel \
    wayland-protocols-devel \
    libxcb-devel \
    libdrm-devel \
    mesa-libgbm-devel \
    vulkan-headers \
    jemalloc-devel \
    pam-devel \
    polkit-devel \
    glib2-devel \
    cli11-devel \
    pkg-config \
    clang \
    ddcutil \
    brightnessctl \
    lm_sensors \
    fish \
    swappy \
    cmake \
    ninja-build \
    gcc-c++ \
    kitty \
    swaybg \
    cava \
    aubio \
    libqalculate \
    libnotify \
    grim \
    slurp \
    wl-clipboard \
    cliphist \
    fuzzel \
    NetworkManager

dnf clean all

