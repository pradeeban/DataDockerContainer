#!/bin/bash
nohup /usr/bin/mongod &

sh startup.sh &
while true; do sleep 1000; done
