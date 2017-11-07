#!/bin/bash -ex

cat redis_input.txt \
  | awk '{printf "%s\r\n", $0}' \
  | netcat localhost 6380
