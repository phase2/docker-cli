#!/bin/sh

set -ex

# Arguments: $1 CLI_VERSION
CLI_VERSION=${1:-8.3}

# Install SQLite 3.x for Drupal 11 testing if CLI version >= 8.3
INSTALL_SQLITE=false
if [ "$(echo "${CLI_VERSION} >= 8.3" | bc -l)" -eq 1 ]; then
  INSTALL_SQLITE=true
fi

docker build --build-arg CLI_VERSION=php"$CLI_VERSION" --build-arg INSTALL_SQLITE="$INSTALL_SQLITE" -t phase2/docker-cli:php"$CLI_VERSION" ./src
