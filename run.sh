#!/bin/bash
#nohup /usr/bin/mongod &
service mongod start
sh startup.sh &
#mongod
while true; do sleep 1000; done
