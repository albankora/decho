FROM golang:1.14-alpine as builder

# Install git
RUN apk update && apk add --no-cache git

ENV GOOS="linux"
ENV GOARCH="amd64"
ENV GO111MODULE="on"
ENV CGO_ENABLED="0"

# Create appuser
RUN adduser -D -g '' appuser

COPY ./ /build

WORKDIR /build

# get all dependancies and compile
RUN go get -d -v ./... \
    && go mod tidy \
    && go build -ldflags '-w -s' -a -installsuffix cgo -o decho decho/cmd/decho

# start from scratch
FROM scratch

# Set base enviroment variables
ENV APP_ENV prod
ENV APP_NAME decho

# Copy our static executable and pass
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /build/decho /app/main

USER appuser

EXPOSE 3000

ENTRYPOINT ["/app/main"]