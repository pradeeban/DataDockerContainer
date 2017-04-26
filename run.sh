#!/bin/bash
#nohup /usr/bin/mongod &
mongod --config /etc/mongod.conf &
#preload caMicroscope Template document
mongo < /root/bindaas/bin/loadCamicroscopeTemplate.js
sh startup.sh &
#mongod
while true; do sleep 1000; done

