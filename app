#!/usr/bin/env bash

set -e

function usage() {
  echo ""
  echo "Commands:"
  echo ""
  echo " build         Build docker environment"
  echo " run           Run local dev app"
  echo " test          Run unit tests"
  echo " cover         Run unit tests and generate coverage file"
  echo " fmt           Format the code with go standards"
  echo " vet           Check and reports suspicious constructs"
  echo " bash          Enter the bash interface"
  echo " prd           Build production image"
  echo " rprd          Run production image"
  echo " mod [COMMAND] Command to manage go modules"
  echo ""
  exit 0
}

APP_NAME="app"
COMPOSE="docker-compose"

if [ $# -gt 0 ];then

    if [ "$1" == "build" ]; then
        ${COMPOSE} build
        ${COMPOSE} run --rm -w /go ${APP_NAME} go get github.com/cespare/reflex
        ${COMPOSE} run --rm ${APP_NAME} go get -d -v ./...

    elif [ "$1" == "run" ]; then
        ${COMPOSE} run --rm -p 80:3000 ${APP_NAME}

    elif [ "$1" == "test" ]; then
        ${COMPOSE} run --rm ${APP_NAME} go test -v ./...

    elif [ "$1" == "cover" ]; then
        ${COMPOSE} run --rm ${APP_NAME} go test ./... -coverprofile=test-coverage.out
        ${COMPOSE} run --rm ${APP_NAME} go test ./... -json | sed -n '1!p' > src/test-report.json

    elif [ "$1" == "fmt" ]; then
        ${COMPOSE} run --rm ${APP_NAME} go fmt ./...
    
    elif [ "$1" == "vet" ]; then
        ${COMPOSE} run --rm ${APP_NAME} go vet ./...

    elif [ "$1" == "bash" ]; then
        ${COMPOSE} run --rm ${APP_NAME} /bin/bash

    elif [ "$1" == "mod" ]; then
        shift 1
        ${COMPOSE} run --rm ${APP_NAME} go mod $@

    elif [ "$1" == "prd" ]; then
        shift 1
        docker build -t decho -f ./build/prd.Dockerfile .

    elif [ "$1" == "rprd" ]; then
        shift 1
        docker run --rm -p 80:3000 -it decho

    else
        ${COMPOSE} run --rm ${APP_NAME} "$@"
    fi

else
    usage
fi