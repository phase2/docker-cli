#!/bin/sh

set -e

CLI_VERSION="2.10"
for tag in {"php7.2" "php7.3"}; do
  docker build \
    --build-arg CLI_VERSION="${CLI_VERSION}-${tag}" \
    -t outrigger/cli:${CLI_VERSION}-${tag} \
    .
done
