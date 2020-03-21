FROM golang:1.14-alpine

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash git zip unzip wget

ENV GOOS="linux"
ENV GOARCH="amd64"
ENV GO111MODULE="on"
ENV CGO_ENABLED="0"

WORKDIR /app

COPY reflex.conf /

CMD ["/go/bin/reflex", "-c", "/reflex.conf"]