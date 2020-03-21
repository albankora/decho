# DECHO
Docker setup for [Echo framework](https://github.com/labstack/echo)

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
# run the docker container
./app build
```

## Run local dev
```bash
# run the docker container
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
 vet           Check and reports suspicious constructs
 mod [COMMAND] Command to manage go modules
 bash          Enter the bash interface
 prd           Build production image
 rprd          Run production image
 codegen       Generate code from the open api documentation
```

## Re-run on the fly
DECHO uses [Reflex](https://github.com/cespare/reflex) for re-running your app when you change your code

## Project Layout
DECHO follows the [Standard Go Project Layout](https://github.com/golang-standards/project-layout) so inside `src` directory you will find folders like `cmd`, `api`, `internal`, `pkg` and `deployments`. Standard Go Project Layout is an emerging project layout base on the Go ecosystem.

## API-First approach
Edit file `src/api/openapi.yaml` and generate code using [OAPI-Codegen](https://github.com/deepmap/oapi-codegen)
```bash
# generate code from open api yaml file
./app codegen
```
The `codegen` command reads `src/api/openapi.yaml` and generates two files `server.go` and `types.go` under `src/internal/codegen` those two files are used by the route handlers functions. `types.go` has the data structures deffined on `src/api/openapi.yaml` and the `server.go` file has the server side setup for the API.