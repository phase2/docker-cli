# Phase2 Docksal CLI

> Docker image adding common tools to [Docksal CLI](https://github.com/docksal/service-cli).

[![GitHub tag](https://img.shields.io/github/tag/phase2/docker-cli.svg)](https://github.com/phase2/docker-cli) [![Docker Stars](https://img.shields.io/docker/stars/outrigger/cli.svg)](https://hub.docker.com/r/outrigger/cli) [![Docker Pulls](https://img.shields.io/docker/pulls/outrigger/cli.svg)](https://hub.docker.com/r/outrigger/cli) [![](https://images.microbadger.com/badges/image/outrigger/cli:dev.svg)](https://microbadger.com/images/outrigger/cli:latest "Get your own image badge on microbadger.com")

This Docker image adds the following tools to the docksal/cli image:
* kubectl
* helm3
* kustomize
* aws cli
* yq
* vim
* expect

## Using this image

This image can be used to directly replace the Docksal CLI image if these additional tools are needed.  Simply reference `phase2/docker-cli:TAG` (or `ghcr.io/phase2/docker-cli:TAG` to pull directly from GitHub).

## Handling different PHP versions

The GitHub actions in `.github/workflows/default.yml` define a matrix of PHP versions being generated. Update this list with any new version needed. Must ensure that the upstream Docksal CLI image is available for each version of PHP.

## Resources

* General questions on Docksal should go to the [docksal documentation](https://docs.docksal.io/)

## Security Reports

Please email outrigger@phase2technology.com with security concerns.

## Maintainers

[![Phase2 Logo](https://s3.amazonaws.com/phase2.public/logos/phase2-logo.png)](https://www.phase2technology.com)
