# ILLiad templates

[![CircleCI](https://circleci.com/gh/NYULibraries/illiad-templates.svg?style=svg)](https://circleci.com/gh/NYULibraries/illiad-templates)
[![Docker Repository on Quay](https://quay.io/repository/nyulibraries/illiad-templates/status "Docker Repository on Quay")](https://quay.io/repository/nyulibraries/illiad-templates)

This project contains the logic for templating ILLiad (Interlibrary Loan software) with Mustache, stylesheets in SASS and scripts in CoffeeScript.

* Uses [https://github.com/barnabyalter/microservice_precompiler](https://github.com/barnabyalter/microservice_precompiler) to render, compile and compress this project.
* Uses [Docker](https://docker.com), [Kubernetes](https://kubernetes.io) and [LFTP](http://lftp.yar.ru/) to deploy after compile to on-prem Windows Servers.
* ~~Requires a proxy to pass from Kubernetes (on AWS) to the ILLiad servers (on-prem)~~
    * If a proxy is required for LFTP it can be reenabled by doing `echo "set ftp:proxy ${FTP_PROXY}\n" >> /home/docker/.lftp/rc`

## Usage

### Compile and deploy

#### With Docker

Compile:

```shell
docker compose run compile
```

Assuming FTP credentials are set up in _docker-compose.yml_ (for local deploys) or in Kubernetes secrets (for remote deploys):

```shell
docker compose build dev-deploy
docker compose run dev-deploy
```

~~For more information on how we're serverlessly deploying these templates see [this article](https://github.com/NYULibraries/WebServices-Wiki/wiki/Serverless-deploys-via-Kubernetes).~~ This is now implemented in the [Hermes server API.](https://github.com/NYULibraries/hermesserver)

#### Compile without Docker

This is run within the Docker build, but to see it locally:

* Uncomment `volumes` in the `compile` service to allow creation of _dist/_ outside
of the container:

```yaml
  volumes:
  - .:/app
```

Note that _dist/_ is being git-ignored, so won't show up
in `git status` output.

* Run the compile script:

```
ruby compile.rb
```

## Institutions

We allow other institutions to manage their pages without having to use our static pages by letting them submit PRs into `institutions/{ILLIAD_INST_NAME}` in the ILLiad proprietary HTML already prebuilt.

## Read the [wiki](https://github.com/NYULibraries/illiad-templates/wiki) for more information
