#!/bin/bash -ex
docker build . --tag forward-logs-to-influxdb
docker run \
  -p 6380:6380 \
  -v $PWD/config:/config \
  forward-logs-to-influxdb \
  /forward-logs-to-influxdb /config/config.json.dev
