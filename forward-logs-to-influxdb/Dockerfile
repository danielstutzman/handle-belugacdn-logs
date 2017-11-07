FROM golang:1.8.1 AS builder
WORKDIR /go/src/forward-logs-to-influxdb
COPY fake_redis_server.go .
RUN go install -tags netgo
RUN ldd /go/bin/forward-logs-to-influxdb | grep -q "not a dynamic executable"

FROM scratch
COPY --from=builder /go/bin/forward-logs-to-influxdb /forward-logs-to-influxdb
CMD /forward-logs-to-influxdb
VOLUME /config
