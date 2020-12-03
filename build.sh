#!/bin/sh

set -e

CLI_VERSION="2.10"
for tag in {"php7.2"}; do
  docker build \
    --build-arg CLI_VERSION="${CLI_VERSION}-${tag}" \
    -t outrigger/cli:${CLI_VERSION}-${tag} \
    .
done

CLI_VERSION="2.12"
for tag in {"php7.3" "php7.4"}; do
  docker build \
    --build-arg CLI_VERSION="${CLI_VERSION}-${tag}" \
    -t outrigger/cli:${CLI_VERSION}-${tag} \
    .
done
