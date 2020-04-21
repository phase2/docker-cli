#!/bin/sh

set -e

versions=("7.2" "7.3" "7.4")
default_version="7.3"
for version in $versions; do
  docker build --build-arg DOCKSAL_CLI=2-php${version} -t outrigger/cli:2-php${version} .
done
#docker tag "outrigger/cli:2-php${default_version}" "outrigger/cli:latest"
