#!/usr/bin/env bash

set -e

function usage() {
  echo ""
  echo "Commands:"
  echo ""
  echo " run           Build and Run local dev app"
  echo " stop          Stop your local container"
  echo " remove        Remove local containers and everything related to them"
  echo " test          Run unit tests"
  echo " cover         Run unit tests and generate coverage file"
  echo " fmt           Format the code with go standards"
  echo " vet           Check and reports suspicious constructs"
  echo " bash          Enter the bash interface"
  echo " prd           Build production image"
  echo " rprd          Run production image"
  echo " mod [COMMAND] Command to manage go modules"
  echo " codegen       Generate code from the open api documentation"
  echo ""
  exit 0
}

APP_NAME="app"
COMPOSE="docker-compose"

if [ $# -gt 0 ];then

    if [ "$1" == "run" ]; then
        ${COMPOSE} build
        ${COMPOSE} run --rm -w /go ${APP_NAME} go get github.com/cespare/reflex
        ${COMPOSE} run --rm -w /go ${APP_NAME} go get github.com/deepmap/oapi-codegen
        ${COMPOSE} run --rm ${APP_NAME} go get -d -v ./...
        ${COMPOSE} up ${APP_NAME}

    elif [ "$1" == "stop" ]; then
        ${COMPOSE} stop

    elif [ "$1" == "remove" ]; then
        ${COMPOSE} down -v --rmi all --remove-orphans

    elif [ "$1" == "test" ]; then
        ${COMPOSE} exec ${APP_NAME} go test -v ./...

    elif [ "$1" == "cover" ]; then
        ${COMPOSE} exec ${APP_NAME} go test ./... -coverprofile=test-coverage.out
        ${COMPOSE} exec ${APP_NAME} go test ./... -json | sed -n '1!p' > src/test-report.json

    elif [ "$1" == "fmt" ]; then
        ${COMPOSE} exec ${APP_NAME} go fmt ./...
    
    elif [ "$1" == "vet" ]; then
        ${COMPOSE} exec ${APP_NAME} go vet ./...

    elif [ "$1" == "bash" ]; then
        ${COMPOSE} exec ${APP_NAME} /bin/bash

    elif [ "$1" == "prd" ]; then
        shift 1
        docker build -t decho -f ./build/prd.Dockerfile .

    elif [ "$1" == "rprd" ]; then
        shift 1
        docker run --rm -p 80:3000 -it decho

    elif [ "$1" == "mod" ]; then
        shift 1
        ${COMPOSE} exec ${APP_NAME} go mod $@

    elif [ "$1" == "codegen" ]; then
        shift 1
        ${COMPOSE} exec ${APP_NAME} oapi-codegen --package=codegen --generate types -o internal/codegen/types.go api/openapi.yaml 
        ${COMPOSE} exec ${APP_NAME} oapi-codegen --package=codegen --generate server,spec -o internal/codegen/server.go api/openapi.yaml 
    else
        ${COMPOSE} exec ${APP_NAME} "$@"
    fi

else
    usage
fi