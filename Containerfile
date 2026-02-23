# Containerfile
ARG BASE_IMAGE_NAME=bazzite-nvidia-open
ARG FEDORA_VERSION=stable

FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}:${FEDORA_VERSION}

# Point directly to the folder where the script lives
COPY build_files/build.sh /tmp/build.sh

# Execute the build script to layer your packages
RUN /tmp/build.sh
