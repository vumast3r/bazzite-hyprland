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
    pipewire \
    ddcutil \
    brightnessctl \
    lm_sensors \
    fish \
    swappy \
    cmake \
    ninja-build \
    gcc-c++ \
    NetworkManager

dnf clean all
