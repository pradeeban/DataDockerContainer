# CaMicroscope DATA container
# DOCKER-VERSION 0.3.4
# Mongo, Bindass

# VERSION               0.3.1

FROM     ubuntu:14.04
MAINTAINER Ganesh Iyer "lastlegion@gmail.com"

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
RUN  apt-get install -y default-jdk
#RUN sudo apt-get install -y openjdk-8-jre
# Add java to path

ENV PATH /root/src/jre1.6.0_45/bin:$PATH
 
# Install MongoDB.
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
RUN apt-get update
RUN mkdir -p /data/db
RUN apt-get install -y adduser mongodb-org-server mongodb-org-shell


# Define mountable directories.
VOLUME ["/data/db"]

# Define working directory.
WORKDIR /data

# Expose ports.
#   - 27017: process
#   - 28017: http
EXPOSE 27017
EXPOSE 28017


# Bindaas
RUN mkdir -p /root/bindaas
#COPY bindaas.tar.gz /root/bindaas/
ADD http://imaging.cci.emory.edu/wiki/download/attachments/4915228/bindaas-dist-2.0.2-201603312230-min.tar.gz?version=1&modificationDate=1459806174096&api=v2 /root/bindaas/bindaas.tar.gz
WORKDIR /root/bindaas
RUN tar -xvf bindaas.tar.gz && rm bindaas.tar.gz
COPY Camicroscope_DataLoader.project /root/bindaas/bin/projects/Camicroscope_DataLoader.project
COPY Camicroscope_Annotations.project /root/bindaas/bin/projects/Camicroscope_Annotations.project
COPY bindaas.config.json /root/bindaas/bin/

EXPOSE 9099
#EXPOSE 8080
WORKDIR /root/bindaas/bin
COPY /run.sh /root/bindaas/bin/run.sh
CMD ["sh", "run.sh"]

