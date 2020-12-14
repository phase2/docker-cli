# Outrigger cli

> Docker image adding pa11y and other common tools to [Docksal CLI](https://github.com/docksal/service-cli).

[![GitHub tag](https://img.shields.io/github/tag/phase2/docker-cli.svg)](https://github.com/phase2/docker-cli) [![Docker Stars](https://img.shields.io/docker/stars/outrigger/cli.svg)](https://hub.docker.com/r/outrigger/cli) [![Docker Pulls](https://img.shields.io/docker/pulls/outrigger/cli.svg)](https://hub.docker.com/r/outrigger/cli) [![](https://images.microbadger.com/badges/image/outrigger/cli:dev.svg)](https://microbadger.com/images/outrigger/cli:latest "Get your own image badge on microbadger.com")

This Docker image adds the following tools to the docksal/cli image:
* [pa11y v5](https://github.com/pa11y/pa11y)
* [puppeteer v1.2](https://github.com/puppeteer/puppeteer) (needs testing with v2.x)
* vim

## DockerHub Integration

* To generate new images for the latest Docksal version, add a new tag off `master` like `2.12`
* To enable more PHP versions like `php7.4`, go into DockerHub and add another automated build target:
  * Source Type: `Tag`
  * Source: `^[0-9.]+$`
  * Docker Tag: `{sourceref}-php7.4`
  * Dockerfile Location: `Dockerfile`
  * Build Context: `/`
  * Autobuild: On
  * Build Caching: Off
* DockerHub has automated builds configured to watch for new [tags](https://github.com/phase2/docker-cli/tags)
* It will match any tag with the pattern `[0-9.]+` basically so we can keep up with Docksal's #.## versioning format
* DockerHub uses [hooks/build](hooks/build) to override the `CLI_VERSION` value with the matched tag for each of the PHP versions in the automated builds list

## Using pa11y with Docksal

In the project `.docksal/docksal.env` set the following:

```
CLI_IMAGE='outrigger/cli'
```

Then start your project with `fin start`.  Once the containers have started, run
the webpack-dev-server for your theme:

```
cd THEME_PATH
fin exec npm run theme
```
where the `theme` job is defined in `package.json` as:
```
scripts:
    "theme": "cross-env-shell NODE_ENV=development \"webpack-dev-server --config ./webpack.config.js --hot\"",
```

This will use your webpack config and enter watch mode to recompile when changes
are detected to your theme files.

Once the theme has compiled and the webpack-dev-server is running, execute pa11y
tests via:

```
fin exec npm run pa11y
```
where the `pa11y` job is defined in `package.json` as:
```
scripts:
  "pa11y": "pa11y-ci --config pa11y.js"
```

## Resources

* General questions on Docksal should go to the [docksal documenation](https://docs.docksal.io/)
* General issues on Puppeteer should check out the [base Puppeteer image](https://hub.docker.com/r/alekzonder/puppeteer/). Note: you can follow the instructions in that README to take screenshots. Since this image is based on that, you should not need a further Docker iamge download.
* [Puppeteer Github Project](https://github.com/GoogleChrome/puppeteer)
* [Official Puppeteer Docker guidance](https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#running-puppeteer-in-docker)
* [pa11y @ Github](https://github.com/pa11y/pa11y)

## Security Reports

Please email outrigger@phase2technology.com with security concerns.

## Maintainers

[![Phase2 Logo](https://s3.amazonaws.com/phase2.public/logos/phase2-logo.png)](https://www.phase2technology.com)
