#!/bin/sh

set -ex

# Arguments: $1 CLI_VERSION
docker build --build-arg CLI_VERSION=php"${1:-8.0}" -t phase2/docker-cli:php"${1:-8.0}" ./src
