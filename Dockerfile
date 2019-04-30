ARG DOCKSAL_PHP_VERSION=7.1
FROM docksal/cli:2.6-php$DOCKSAL_PHP_VERSION

RUN apt-get update && apt-get install --no-install-recommends -y \
  vim-tiny \
  && rm -rf /var/lib/apt/lists/*
