#!/bin/bash

export REDIS_HOST=$1
export KERNEL_HOST=$2

jq --arg REDIS_HOST "$REDIS_HOST" '.redis.host=$REDIS_HOST' ./config.json | sponge ./config.json
jq --arg REDIS_HOST "$REDIS_HOST" '.defaultPoolConfigs.redis.host=$REDIS_HOST' ./config.json | sponge ./config.json

jq --arg KERNEL_HOST "$KERNEL_HOST" '.daemons[0].host=$KERNEL_HOST' ./pool_configs/aion.json | sponge ./pool_configs/aion.json
jq --arg KERNEL_HOST "$KERNEL_HOST" '.paymentProcessing.daemon.host=$KERNEL_HOST' ./pool_configs/aion.json | sponge ./pool_configs/aion.json

./run.sh