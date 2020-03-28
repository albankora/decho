FROM golang:1.14-alpine

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash git zip unzip wget

ENV GOOS="linux"
ENV GOARCH="amd64"
ENV GO111MODULE="on"
ENV CGO_ENABLED="0"

COPY . /app

WORKDIR /app

COPY build/reflex.conf /