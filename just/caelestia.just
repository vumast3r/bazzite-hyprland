# Install Caelestia Shell UI (run once after first boot)
install-caelestia:
    #!/usr/bin/env bash
    set -euo pipefail

    # Guard against re-running
    if [ -d "$HOME/.config/quickshell/caelestia" ]; then
        echo "Caelestia already installed. Skipping."
        exit 0
    fi

    echo "Installing caelestia-cli..."
    git clone https://github.com/caelestia-dots/cli /tmp/caelestia-cli
    cd /tmp/caelestia-cli
    cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr
    cmake --build build
    sudo cmake --install build

    echo "Installing caelestia-shell..."
    mkdir -p ~/.config/quickshell
    git clone https://github.com/caelestia-dots/shell.git ~/.config/quickshell/caelestia
    cd ~/.config/quickshell/caelestia
    cmake -B build -G Ninja \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/ \
        -DINSTALL_QSCONFDIR=~/.config/quickshell/caelestia
    cmake --build build
    sudo cmake --install build
    sudo chown -R $USER ~/.config/quickshell/caelestia

    echo "Cleaning up..."
    rm -rf /tmp/caelestia-cli

    echo "Done! Start the shell with: caelestia shell -d"
    echo "Or log out and select Hyprland at the login screen."
