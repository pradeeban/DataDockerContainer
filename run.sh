#!/bin/bash
mongod --config /etc/mongod.conf &
sh /root/bindaas/bin/startup.sh &
while true; do sleep 1000; done

