#!/bin/bash
jq \
    --arg pid $(jq -r ".type" input.json | fold -1 | head -n 1)$(echo $SHA | fold -w 7 | head -n 1) \
    '. | {pid: $pid, name: .name, version: .version, fields: .fields, type: .type, runner_script: .runner_script}' \
    input.json > data.json
NAME=$(jq -r ".name" input.json)
export TARNAME=$NAME\_$(jq -r ".version" input.json).tar.gz
echo "TARNAME=$TARNAME" >> $GITHUB_ENV
tar -czvf $TARNAME data.json $NAME