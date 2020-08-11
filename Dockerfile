FROM golang:1.14-buster AS builder

RUN mkdir -p /go/src/digitalocean-exporter
COPY . /go/src/digitalocean-exporter
WORKDIR /go/src/digitalocean-exporter
RUN go build

FROM alpine:latest
RUN apk add --update ca-certificates

COPY --from=builder /go/src/digitalocean-exporter/digitalocean_exporter /usr/bin/digitalocean_exporter

EXPOSE 9212

ENTRYPOINT ["/usr/bin/digitalocean_exporter"]
