# Bindaas-Mongo Integrated Container

FROM     ubuntu:18.04
LABEL maintainer="ashish@dbmi.emory.edu"

### update
RUN apt-get -q update
RUN apt-get -q -y upgrade
RUN apt-get -q -y dist-upgrade
RUN apt-get install -y gnupg2
RUN apt-get install -q -y libcurl3 

RUN mkdir /root/src


# Add group Bindaas and user Bindaas
RUN groupadd -g 9999 bindaas && useradd -r -u 9999 -g bindaas bindaas

WORKDIR /root/src

# Java
RUN apt-get install -y openjdk-8-jre

# Add java to path
ENV PATH /root/src/jre1.8.0_171/bin:$PATH
 
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E52529D4

# Install MongoDB.
RUN echo "deb http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list
RUN apt-get update
RUN apt-get install -y mongodb-org --allow-change-held-packages


# Bindaas
RUN mkdir -p /root/bindaas

ADD https://github.com/sharmalab/bindaas/releases/download/v3.3.5/bindaas-dist-3.3.5.tar.gz /root/bindaas/bindaas.tar.gz
WORKDIR /root/bindaas
RUN tar -xvf bindaas.tar.gz && rm bindaas.tar.gz
COPY projects /root/bindaas/bin/projects

COPY bindaas.config.json /root/bindaas/bin/
#COPY log/bindaas.log /root/bindaas/log/

COPY /run.sh /root/bindaas/bin/run.sh

COPY mongod.conf /etc/mongod.conf

RUN chown -R bindaas:bindaas /root/
#RUN chown -R bindaas:bindaas /root/bindaas/
#RUN chown -R bindaas:bindaas /root/bindaas/log/
RUN chown -R bindaas:bindaas /var/log/mongodb/
RUN chown -R bindaas:bindaas /var/lib/mongodb/

WORKDIR /root/bindaas/bin

USER bindaas

EXPOSE 9099

CMD ["sh", "run.sh"]
