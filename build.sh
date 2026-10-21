#!/bin/sh

set -ex

# Arguments: $1 CLI_VERSION
CLI_VERSION=${1:-8.4}

docker build --build-arg CLI_VERSION=php"$CLI_VERSION" -t phase2/docker-cli:php"$CLI_VERSION" ./src
