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

## Initialize local dev
```bash
# run the docker container
./app run
```

## Dev server URL
`http://127.0.0.1:3000`

## Re-run on the fly
DECHO uses [Reflex](https://github.com/cespare/reflex) for re-running your app when you change your code

## Production docker image
```bash
# creates a docker production image
./app prd
```

## API-First Approach
Edit file `docs/petstore.yaml` and generate code using [OAPI-Codegen](github.com/deepmap/oapi-codegen)
```bash
# generate code from open api yaml file
./app codegen
```

## The commands list:
```bash
Commands:

 run           Build and Run local dev app
 stop          Stop your local container
 remove        Remove local containers and everything related to them
 test          Run unit tests
 cover         Run unit tests and generate coverage file
 fmt           Format the code with go standards
 vet           Check and reports suspicious constructs
 bash          Enter the bash interface
 prd           Build production image
 rprd          Run production image
 mod [COMMAND] Command to manage go modules
 codegen       Generate code from the open api documentation
```