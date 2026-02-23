install-caelestia:
    #!/usr/bin/env bash
    set -euo pipefail

    # Install app2unit
    echo "Installing app2unit..."
    rm -rf /tmp/app2unit
    git clone https://github.com/Vladimir-csp/app2unit.git /tmp/app2unit
    cd /tmp/app2unit
    sudo make install

    # Install dart-sass (pre-built binary)
    echo "Installing dart-sass..."
    SASS_VERSION=$(curl -s https://api.github.com/repos/sass/dart-sass/releases/latest | grep '"tag_name"' | cut -d'"' -f4)
    curl -L "https://github.com/sass/dart-sass/releases/download/${SASS_VERSION}/dart-sass-${SASS_VERSION}-linux-x64.tar.gz" -o /tmp/dart-sass.tar.gz
    sudo tar -xzf /tmp/dart-sass.tar.gz -C /opt/
    sudo ln -sf /opt/dart-sass/sass /usr/local/bin/sass

    # Install fonts
    echo "Installing fonts..."
    mkdir -p ~/.local/share/fonts
    # CaskaydiaCove Nerd Font
    curl -L "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip" -o /tmp/caskaydia.zip
    unzip -o /tmp/caskaydia.zip -d ~/.local/share/fonts/CaskaydiaCove
    # Material Symbols
    curl -L "https://github.com/google/material-design-icons/releases/latest/download/MaterialSymbols.zip" -o /tmp/material-symbols.zip
    unzip -o /tmp/material-symbols.zip -d ~/.local/share/fonts/MaterialSymbols
    fc-cache -fv

    # Build Quickshell
    echo "Building Quickshell..."
    rm -rf /tmp/quickshell
    git clone https://github.com/quickshell-mirror/quickshell.git /tmp/quickshell
    cd /tmp/quickshell
    cmake -GNinja -B build \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DCMAKE_C_COMPILER=clang \
        -DCMAKE_CXX_COMPILER=clang++
    cmake --build build
    sudo cmake --install build

    # Install caelestia-cli
    echo "Installing caelestia-cli..."
    rm -rf /tmp/caelestia-cli
    git clone https://github.com/caelestia-dots/cli.git /tmp/caelestia-cli
    cd /tmp/caelestia-cli
    pip install build installer hatch hatch-vcs --break-system-packages
    python -m build --wheel
    sudo python -m installer dist/*.whl
    sudo cp completions/caelestia.fish /usr/share/fish/vendor_completions.d/caelestia.fish

    # Build caelestia-shell
    echo "Building caelestia-shell..."
    rm -rf /tmp/caelestia-shell
    mkdir -p ~/.config/quickshell
    git clone https://github.com/caelestia-dots/shell.git /tmp/caelestia-shell
    cd /tmp/caelestia-shell
    cmake -B build -G Ninja \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/ \
        -DINSTALL_QSCONFDIR=~/.config/quickshell/caelestia
    cmake --build build
    sudo cmake --install build
    sudo chown -R $USER ~/.config/quickshell/caelestia

    echo "All done! Start with: caelestia shell -d"
