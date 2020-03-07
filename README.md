# DECHO
Docker setup for [Echo framework](https://github.com/labstack/echo)

## Commands scripts
```bash
./app {cmd}
```

## The commands list:
```bash
Commands:

 build         Build docker environment
 run           Run local dev app
 test          Run unit tests
 cover         Run unit tests and generate coverage file
 fmt           Format the code with go standards
 vet           Check and reports suspicious constructs
 bash          Enter the bash interface
 prd           Build production image
 rprd          Run production image
 mod [COMMAND] Command to manage go modules
```

## Initialize local dev
```bash
# build the docker container 
./app build

# run the docker container
./app run
```

## Rerun on the fly
DECHO uses [Reflex](https://github.com/cespare/reflex) for re-running your app when files change

## Production docker image
```bash
# creates a docker production image
./app prd
```