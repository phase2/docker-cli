#!/bin/sh

set -e

# Get the versions to build

# If they are passed as args
if [ $# -gt 0 ]; then
  buildDirs="$@"
else
  # else, get all the relevant dirs
  buildDirs=$(ls | grep -E '^php[0-9\.]+$')
fi

# Build each one of them
for version in $buildDirs; do
  pushd $version
  docker build -t outrigger/cli:2-${version} .
  popd
done
