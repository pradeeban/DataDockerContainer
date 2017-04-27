#!/bin/bash
#nohup /usr/bin/mongod &
mongod --config /etc/mongod.conf &
sh startup.sh &
#mongod
while true; do sleep 1000; done

#pre-load Camicroscope Template document
runingMongod=$(ps -a |grep mongod)
#echo ${#runingMongod}
tmplength=${#runingMongod}
while [ $tmplength -eq 0 ] ; 
   do  echo "mongod is not runing." && 
       sleep 1000 && 
       runingMongod=$(ps -a |grep mongod) &&
       tmplength=${#runingMongod}       
done
mongo < /root/bindaas/bin/loadCamicroscopeTemplate.js
