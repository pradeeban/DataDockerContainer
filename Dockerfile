# Mongo, Bindaas Integrated Container

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
RUN apt-get install -y openjdk-8-jre
# Add java to path

ENV PATH /root/src/jre1.8.0_171/bin:$PATH
 
# Install MongoDB.
#RUN apt-get install -y upstart
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

ADD https://github.com/sharmalab/bindaas/releases/download/v3.3.5/bindaas-dist-3.3.5.tar.gz /root/bindaas/bindaas.tar.gz
WORKDIR /root/bindaas
RUN tar -xvf bindaas.tar.gz && rm bindaas.tar.gz
COPY projects /root/bindaas/bin/projects

COPY bindaas.config.json /root/bindaas/bin/

EXPOSE 9099

WORKDIR /root/bindaas/bin

COPY /run.sh /root/bindaas/bin/run.sh

COPY mongod.conf /etc/mongod.conf


CMD ["sh", "run.sh"]
