# Bindaas-Mongo Integrated Container

* Installs Mongo
* Installs Bindaas


## For the Bindaas User: Running the Docker Container

$ docker run --name bindaas-mongo -v $PWD/bin:/root/bindaas/bin/ -v $PWD/bundles:/root/bindaas/bundles/ -v $PWD/log:/root/bindaas/log/ -p 9099:9099 pradeeban/bindaas:3.3.5


## For the Bindaas Developer: Building the Docker Container

From the root directory,

$ docker build -t bindaas:3.3.5withMongo .

You will get the output "Successfully tagged bindaas:3.3.5withMongo" if everything went fine.


Confirm that by running

$ docker image ls

REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE

bindaas             3.3.5withMongo              a9a81d677bb2        5 minutes ago        59MB



### Tag the image with the user name:
 
 $ docker tag bindaas:3.3.5withMongo pradeeban/bindaas:3.3.5withMongo


 ### Log in and push the image to the Docker repository:

Before committing, make sure Bindaas runs fine in the container using the command above listed under the "For the Bindaas User" section.

 $ docker login

 $ **docker push pradeeban/bindaas:3.3.5withMongo**
