#!/bin/bash
#nohup /usr/bin/mongod &
mongod --config /etc/mongod.conf &
sh /root/bindaas/bin/startup.sh &
#preload camicroscope template
sleep 5
mongo 127.0.0.1:27017/quip /root/scripts/db_index.js
mongo < /root/bindaas/bin/loadCamicroscopeTemplate.js
while true; do sleep 1000; done
