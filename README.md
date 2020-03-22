# DECHO

## Goal
The goal is to accelerate the process of bootstrapping an Restfull API base golang application

## How
Docker is used to accelerate local setup for [Echo framework](https://github.com/labstack/echo) and also you can generate a `scratch` image with a minimum footprint that can be used in production.

## Setup local environment variables
```bash
cp .env.example .env
```

## The command script
```bash
./app {cmd}
```

## Build local dev
```bash
# build local docker container and download required libs
./app build
```

## Run local dev
```bash
# run local docker container
./app run
```

## Dev server URL
`http://127.0.0.1:3000`

## Production docker image
```bash
# creates a docker production image
./app prd
```

## Full list of commands:
```bash
Commands:

 build         Build local docker container and download required libs
 run           Run local docker container
 stop          Stop your local docker container
 remove        Remove local containers and everything related to them
 test          Run unit tests
 cover         Run unit tests and generate coverage file
 fmt           Format the code with go standards
 vet           Check and report likely mistakes in packages
 mod [COMMAND] Commands for go module maintenance
 bash          Enter dockers bash interface
 prd           Build scratch production image
 rprd          Run production image
 codegen       Generate code from the open api documentation
```

## Re-run on the fly
The app uses [Reflex](https://github.com/cespare/reflex) for re-running your app when you change your code

## Project Layout
The app follows the [Standard Go Project Layout](https://github.com/golang-standards/project-layout) so the directory structure includes folders like `cmd`, `internal`, `pkg` and `build`. Standard Go Project Layout is an emerging project layout base on the Go ecosystem.

## API-First approach
Edit file `apidoc.yaml` and generate code using [OAPI-Codegen](https://github.com/deepmap/oapi-codegen)
```bash
# generate code from open api yaml file
./app codegen
```
The `codegen` command reads `apidoc.yaml` and generates two files `server.go` and `types.go` under `internal/codegen`. `types.go` has the data structures deffined on `apidoc.yaml` and the `server.go` file has the server side setup for the API.