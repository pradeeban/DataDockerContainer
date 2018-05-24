FROM     ubuntu:16.04
MAINTAINER Ganesh Iyer "lastlegion@gmail.com"

# build with
#  sudo docker build --rm=true -t="repo/imgname" .



### update
RUN apt-get -q update
RUN apt-get -q -y upgrade
RUN apt-get -q -y dist-upgrade
RUN apt-get install -q -y libcurl3 

RUN addgroup --gid 1002 fatemeh && \
    useradd --uid 1002 --gid 1002 fatemeh
USER fatemeh
USER root
# Java
RUN mkdir /root/src

RUN chown 1002:1002 /root/src && \
    chmod 744 /root/src

WORKDIR /root/src


    
RUN  apt-get install -y default-jdk
#RUN sudo apt-get install -y openjdk-8-jre
# Add java to path

ENV PATH /root/src/jre1.6.0_45/bin:$PATH


RUN chown 1002:1002 /root/src/jre1.6.0_45/bin:$PATH && \
    chmod 744 /root/src/jre1.6.0_45/bin:$PATH
    
    
# Install MongoDB.
RUN apt-get install -y upstart
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list
RUN  apt-get update
RUN apt-get install -y mongodb-org

USER fatemeh
# Define mountable directories.
VOLUME ["/data/db"]

# Define working directory.
WORKDIR /data

# Expose ports.
#   - 27017: process
#   - 28017: http
#EXPOSE 27017
#EXPOSE 28017

USER root

# Bindaas
RUN mkdir -p /root/bindaas

RUN chown 1002:1002 /root/bindaas && \
    chmod 744 /root/bindaas

#COPY bindaas.tar.gz /root/bindaas/
ADD http://imaging.cci.emory.edu/wiki/download/attachments/4915228/bindaas-dist-2.0.2-201603312230-min.tar.gz?version=1&modificationDate=1459806174096&api=v2 /root/bindaas/bindaas.tar.gz
WORKDIR /root/bindaas
RUN tar -xvf bindaas.tar.gz && rm bindaas.tar.gz
COPY projects /root/bindaas/bin/projects

RUN chown -R 1002:1002 /root/bindaas/bin && \
    chmod -R 744 /root/bindaas/bin
    
RUN chown -R 1002:1002 /root/bindaas/bin/projects && \
    chmod -R 744 /root/bindaas/bin/projects
    
#COPY Camicroscope_DataLoader.project /root/bindaas/bin/projects/Camicroscope_DataLoader.project
#COPY Camicroscope_Annotations.project /root/bindaas/bin/projects/Camicroscope_Annotations.project
COPY bindaas.config.json /root/bindaas/bin/

COPY trusted-applications.config.json /root/bindaas/bin/trusted-applications.config.json

RUN chown -R 1002:1002 /root/bindaas/bin/trusted-applications.config.json && \
    chmod -R 744 /root/bindaas/bin/trusted-applications.config.json

#EXPOSE 9099
#EXPOSE 8080
#WORKDIR /root/bindaas/bin
COPY scripts/db_index.js /root/bindaas/bin/db_index.js
#WORKDIR /root/scripts


RUN chown -R 1002:1002 /root/bindaas/bin/db_index.js && \
    chmod -R 744 /root/bindaas/bin/db_index.js


COPY /run.sh /root/bindaas/bin/run.sh

RUN chown -R 1002:1002 /root/bindaas/bin/run.sh && \
    chmod -R 744 /root/bindaas/bin/run.sh




#pre-load Camicroscope Template document
COPY /loadCamicroscopeTemplate.js /root/bindaas/bin/loadCamicroscopeTemplate.js

RUN chown -R 1002:1002 /root/bindaas/bin/loadCamicroscopeTemplate.js && \
    chmod -R 744 /root/bindaas/bin/loadCamicroscopeTemplate.js



#pre-load admin credential document
COPY /load_admin_info.js /root/bindaas/bin/load_admin_info.js

RUN chown -R 1002:1002 /root/bindaas/bin/load_admin_info.js && \
    chmod -R 744 /root/bindaas/bin/load_admin_info.js

COPY mongod.conf /etc/mongod.conf

RUN chown -R 1002:1002 /etc/mongod.conf && \
    chmod -R 744 /etc/mongod.conf
    
    
RUN chown -R 1002:1002 /etc && \
    chmod -R 744 /etc


WORKDIR /root/bindaas/bin

RUN chown -R 1002:1002 /root/bindaas/bin && \
    chmod -R 744 /root/bindaas/bin
    
 USER fatemeh
 
 WORKDIR /root/bindaas/bin
 


CMD ["sh", "run.sh"]
