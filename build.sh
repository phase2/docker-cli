#!/bin/bash
set -e

if [ $# -ne 1 ];
then
    echo 1>&2 "Usage: $0 7.1 or $0 7.2"
    exit 1
fi

DOCKER_CMD=`which docker`
PHP_VERSION=$1

${DOCKER_CMD} build --no-cache --force-rm  -t outrigger/ci:php$PHP_VERSION --build-arg=DOCKSAL_PHP_VERSION=$PHP_VERSION .
