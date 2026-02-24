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
    distrobox enter nix-tools -- bash -c "
        nix run github:caelestia-dots/cli -- --help
        nix run github:caelestia-dots/shell -- --help
    "

    echo "Creating launcher scripts on host..."
    mkdir -p ~/.local/bin
    cat > ~/.local/bin/caelestia << 'EOF'
#!/usr/bin/env bash
distrobox enter nix-tools -- caelestia "$@"
EOF
    chmod +x ~/.local/bin/caelestia

    echo "Done! Run: caelestia shell -d"
