#!/bin/bash
set -euo pipefail

# Add the Hyprland COPR
cat > /etc/yum.repos.d/lionheartp-Hyprland.repo << 'EOF'
[copr:copr.fedorainfracloud.org:lionheartp:Hyprland]
name=Copr repo for Hyprland owned by lionheartp
baseurl=https://download.copr.fedorainfracloud.org/results/lionheartp/Hyprland/fedora-43-x86_64/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://download.copr.fedorainfracloud.org/results/lionheartp/Hyprland/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1
EOF

cat > /etc/yum.repos.d/errornointernet-quickshell.repo << 'EOF'
[copr:copr.fedorainfracloud.org:errornointernet:quickshell]
name=Copr repo for quickshell owned by errornointernet
baseurl=https://download.copr.fedorainfracloud.org/results/errornointernet/quickshell/fedora-43-x86_64/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://download.copr.fedorainfracloud.org/results/errornointernet/quickshell/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1
EOF

# Install Hyprland and runtime dependencies needed by caelestia-shell
dnf install -y \
    hyprland \
    hyprlock \
    hypridle \
    hyprpaper \
    hyprpicker \
    hyprpolkitagent \
    xdg-desktop-portal-hyprland \
    quickshell-git \
    breakpad \
    gpu-screen-recorder \
    scdoc \
    qt6-qtdeclarative \
    qt6-qtdeclarative-devel \
    qt6-qtwayland \
    qt6-qtsvg \
    ddcutil \
    brightnessctl \
    lm_sensors \
    fish \
    swappy \
    cmake \
    ninja-build \
    gcc-c++ \
    kitty \
    cava \
    aubio \
    libqalculate \
    libnotify \
    grim \
    slurp \
    wl-clipboard \
    cliphist \
    fuzzel \
    curl \
    unzip \
    fontconfig \
    NetworkManager

dnf clean all

