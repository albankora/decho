#!/usr/bin/env bash

set -e

function usage() {
  echo ""
  echo "Commands:"
  echo ""
  echo " build         Build local docker container and download required libs"
  echo " run           Run local docker container"
  echo " stop          Stop your local docker container"
  echo " remove        Remove local containers and everything related to them"
  echo " test          Run unit tests"
  echo " cover         Run unit tests and generate coverage file"
  echo " fmt           Format the code with go standards"
  echo " vet           Check and report likely mistakes in packages"
  echo " mod [COMMAND] Commands for go module maintenance"
  echo " codegen       Generate code from the open api documentation"
  echo " bash          Enter dockers bash interface"
  echo " prd           Build scratch production image"
  echo " rprd          Run production image"
  echo ""
  exit 0
}

APP_NAME="app"
COMPOSE="docker-compose -f build/docker-compose.yml"

if [ $# -gt 0 ];then

    if [ "$1" == "build" ]; then
        ${COMPOSE} build
        ${COMPOSE} run --rm -w /go ${APP_NAME} go get github.com/cespare/reflex
        ${COMPOSE} run --rm -w /go ${APP_NAME} go get github.com/deepmap/oapi-codegen/cmd/oapi-codegen
        ${COMPOSE} run --rm ${APP_NAME} go get -d -v ./...

    elif [ "$1" == "run" ]; then
        ${COMPOSE} up ${APP_NAME}

    elif [ "$1" == "stop" ]; then
        ${COMPOSE} stop

    elif [ "$1" == "remove" ]; then
        ${COMPOSE} down -v --rmi all --remove-orphans

    elif [ "$1" == "test" ]; then
        ${COMPOSE} exec ${APP_NAME} go test -v ./...

    elif [ "$1" == "cover" ]; then
        ${COMPOSE} exec ${APP_NAME} go test ./... -coverprofile=test-coverage.out
        ${COMPOSE} exec ${APP_NAME} go test ./... -json | sed -n '1!p' > test-report.json

    elif [ "$1" == "fmt" ]; then
        ${COMPOSE} exec ${APP_NAME} go fmt ./...
    
    elif [ "$1" == "vet" ]; then
        ${COMPOSE} exec ${APP_NAME} go vet ./...

    elif [ "$1" == "mod" ]; then
        shift 1
        ${COMPOSE} exec ${APP_NAME} go mod $@

    elif [ "$1" == "bash" ]; then
        ${COMPOSE} exec ${APP_NAME} /bin/bash

    elif [ "$1" == "prd" ]; then
        docker build -t decho -f build/prd.Dockerfile .

    elif [ "$1" == "rprd" ]; then
        docker run --rm -p 80:3000 -it decho

    elif [ "$1" == "codegen" ]; then
        ${COMPOSE} exec ${APP_NAME} oapi-codegen --package=codegen --generate types -o internal/codegen/types.go apidoc.yaml 
        ${COMPOSE} exec ${APP_NAME} oapi-codegen --package=codegen --generate server,spec -o internal/codegen/server.go apidoc.yaml 
    else
        ${COMPOSE} exec ${APP_NAME} "$@"
    fi

else
    usage
fi