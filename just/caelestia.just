install-caelestia:
    #!/usr/bin/env bash
    set -euo pipefail

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

    echo "Building caelestia-cli..."
    rm -rf /tmp/caelestia-cli
    git clone https://github.com/caelestia-dots/cli.git /tmp/caelestia-cli
    cd /tmp/caelestia-cli
    pip install build installer hatch hatch-vcs --break-system-packages
    python -m build --wheel
    sudo python -m installer dist/*.whl
    sudo cp completions/caelestia.fish /usr/share/fish/vendor_completions.d/caelestia.fish

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
