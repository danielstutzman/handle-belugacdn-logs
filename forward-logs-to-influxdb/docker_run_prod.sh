#!/bin/bash -ex

rsync -e "ssh -i ~/.ssh/vultr" -r config/ root@belugacdn-logs.danstutzman.com:/config/

docker save forward-logs-to-influxdb \
  | gzip \
  | ssh -i ~/.ssh/vultr root@belugacdn-logs.danstutzman.com 'gunzip | docker load'

#ssh -i ~/.ssh/vultr root@belugacdn-logs.danstutzman.com 'docker run --net host -v /config:/config forward-logs-to-influxdb /forward-logs-to-influxdb /config/config.json.prod'
ssh -i ~/.ssh/vultr root@belugacdn-logs.danstutzman.com 'docker run -p 6380:6380 -v /config:/config forward-logs-to-influxdb /forward-logs-to-influxdb /config/config.json.prod'
