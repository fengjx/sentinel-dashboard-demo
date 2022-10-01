#!/usr/bin/env bash

# 并发测试脚本

url="http://localhost:8080/ping"

succ=0
err=0

for i in {1..10}; do
  status_code=$(curl --write-out %{http_code} --silent --output /dev/null ${url})
  if [[ "$status_code" -ne 200 ]]; then
    echo "${i} err $status_code"
    err=$((err+1))
  else
    echo "${i} ok"
    succ=$((succ+1))
  fi
  # 可以按测试需求修改
  sleep 0.2
done

echo "success ${succ}, err: ${err}"

