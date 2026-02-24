install-caelestia:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Creating Nix toolbox..."
    distrobox create --name nix-tools \
        --image nixos/nix \
        --volume /tmp:/tmp \
        --env WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
        --env XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
        --yes

    echo "Installing Caelestia inside toolbox..."
    distrobox enter nix-tools -- bash -c "nix run github:caelestia-dots/shell"

    echo "Creating launcher scripts on host..."
    mkdir -p ~/.local/bin
    LAUNCHER=~/.local/bin/caelestia
    echo '#!/usr/bin/env bash' > $LAUNCHER
    echo 'distrobox enter nix-tools -- bash -c "caelestia $*"' >> $LAUNCHER
    chmod +x $LAUNCHER

    echo "Done! Run: caelestia shell -d"
