#!/bin/bash
#nohup /usr/bin/mongod &
mongod --config /etc/mongod.conf &
sh startup.sh &
#preload camicroscope template
sleep 5
mongo < /root/bindaas/bin/loadCamicroscopeTemplate.js
while true; do sleep 1000; done
