# Containerfile
ARG BASE_IMAGE_NAME=bazzite-nvidia-open
ARG FEDORA_VERSION=stable

FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}:${FEDORA_VERSION}

# Point directly to the folder where the script lives
COPY build_files/build.sh /tmp/build.sh

# Copy caelestia to /usr/share
COPY just/caelestia.just /usr/share/ublue-os/just/60-caelestia.just

# Execute the build script to layer your packages
RUN /tmp/build.sh
