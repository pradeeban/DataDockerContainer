# CaMicroscope DATA container
# DOCKER-VERSION 0.3.4
# Mongo, Bindaas

# VERSION               0.3.1

FROM     ubuntu:18.04
LABEL maintainer="ashish@dbmi.emory.edu"

# build with
#  sudo docker build --rm=true -t="repo/imgname" .

### update
RUN apt-get -q update
RUN apt-get -q -y upgrade
RUN apt-get -q -y dist-upgrade
RUN apt-get install -q -y libcurl3 

# Java
RUN mkdir /root/src

WORKDIR /root/src
RUN sudo apt-get install -y openjdk-8-jre
# Add java to path

ENV PATH /root/src/jre1.8.0_171/bin:$PATH
 
# Install MongoDB.
RUN apt-get install -y upstart
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list
RUN  apt-get update
RUN apt-get install -y mongodb-org


# Define mountable directories.
VOLUME ["/data/db"]

# Define working directory.
WORKDIR /data

# Bindaas
RUN mkdir -p /root/bindaas
#COPY bindaas.tar.gz /root/bindaas/
ADD https://github.com/sharmalab/bindaas/releases/download/v3.3.5/bindaas-dist-3.3.5.tar.gz /root/bindaas/bindaas.tar.gz
WORKDIR /root/bindaas
RUN tar -xvf bindaas.tar.gz && rm bindaas.tar.gz
COPY projects /root/bindaas/bin/projects
#COPY Camicroscope_DataLoader.project /root/bindaas/bin/projects/Camicroscope_DataLoader.project
#COPY Camicroscope_Annotations.project /root/bindaas/bin/projects/Camicroscope_Annotations.project
COPY bindaas.config.json /root/bindaas/bin/
COPY trusted-applications.config.json /root/bindaas/bin/trusted-applications.config.json

EXPOSE 9099

WORKDIR /root/bindaas/bin
COPY scripts/db_index.js /root/bindaas/bin/db_index.js
#WORKDIR /root/scripts
COPY /run.sh /root/bindaas/bin/run.sh



#pre-load Camicroscope Template document
COPY /loadCamicroscopeTemplate.js /root/bindaas/bin/loadCamicroscopeTemplate.js

#pre-load admin credential document
COPY /load_admin_info.js /root/bindaas/bin/load_admin_info.js

COPY mongod.conf /etc/mongod.conf
#WORKDIR /root/

CMD ["sh", "run.sh"]
