#!/bin/bash
#nohup /usr/bin/mongod &
mongod --config /etc/mongod.conf &
sh startup.sh &
#mongod
while true; do sleep 1000; done

