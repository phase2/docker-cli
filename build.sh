#!/bin/sh

set -e

# Arguments: $1 tag, $2 CLI_VERSION
build() {
  docker build \
    --build-arg CLI_VERSION="${2}-${1}" \
    -t outrigger/cli:"${2}-${1}" \
    .
}

build "php7.2" "2.10"

for tag in "php7.3" "php7.4"; do
  build $tag "2.12"
done
