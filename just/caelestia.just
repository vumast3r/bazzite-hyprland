install-caelestia:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Creating Arch toolbox..."
    distrobox create --name caelestia-box \
        --image archlinux:latest \
        --yes

    echo "Installing Caelestia inside toolbox..."
    distrobox enter caelestia-box -- bash -c "
        sudo pacman -Syu --noconfirm
        sudo pacman -S --noconfirm git base-devel
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay && makepkg -si --noconfirm
        yay -S --noconfirm caelestia-shell caelestia-cli
    "

    echo "Creating launcher scripts on host..."
    mkdir -p ~/.local/bin
    LAUNCHER=~/.local/bin/caelestia
    echo '#!/usr/bin/env bash' > $LAUNCHER
    echo 'distrobox enter caelestia-box -- bash -c "caelestia $*"' >> $LAUNCHER
    chmod +x $LAUNCHER

    echo "Done! Run: caelestia shell -d"
