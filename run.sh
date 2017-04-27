#!/bin/bash
#nohup /usr/bin/mongod &
mongod --config /etc/mongod.conf &
sh startup.sh &
#mongod
while true; do sleep 1000; done

#pre-load Camicroscope Template document
runingMongod=$(ps -a |grep mongod)
echo ${#runingMongod}
tmplength=${#runingMongod}
if [ $tmplength -gt 0 ] ; 
   then  echo "mongod is runing." && 
      mongo < /root/bindaas/bin/loadCamicroscopeTemplate.js
   else  echo "mongod is NOT runing."    
fi
