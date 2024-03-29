#!/bin/bash

#
# Copyright (C) 2024 Nethesis S.r.l.
# SPDX-License-Identifier: GPL-3.0-or-later
#

# Terminate on error
set -e

# Prepare variables for later use
images=()
# The image will be pushed to GitHub container registry
repobase="${REPOBASE:-ghcr.io/nethserver}"

# build the runtime image
DNSMASQ_VERSION=2.89
podman build \
    --force-rm \
    --layers \
    --tag "${repobase}/dnsmasq-server" \
    --build-arg "DNSMASQ_VERSION=${DNSMASQ_VERSION}" \
    container

images+=("${repobase}/dnsmasq-server")

# Build NS8-image

podman build \
    --force-rm \
    --layers \
    --tag "${repobase}/dnsmasq" \
    --label org.nethserver.images="ghcr.io/nethserver/dnsmasq-server:${IMAGETAG:-latest}" \
    .

images+=("${repobase}/dnsmasq")

if [[ -n "${CI}" ]]; then
    # Set output value for Github Actions
    printf "images=%s\n" "${images[*],,}" >> "${GITHUB_OUTPUT}"
else
    # Just print info for manual push
    printf "Publish the images with:\n\n"
    for image in "${images[@],,}"; do printf "  buildah push %s docker://%s:%s\n" "${image}" "${image}" "${IMAGETAG:-latest}" ; done
    printf "\n"
fi
