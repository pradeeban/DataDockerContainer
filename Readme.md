# DataManager for Camicroscope

* Installs Mongo
* Installs Bindaas
* Install DataLoader.py and DataLoader API
* Uses `.project` files for Bindaas


## Running container
_make sure you're logged in using `docker login` with your dockerhub credentials and have access to this *private* repository_

* `docker pull lastlegion/dataloader`
* `docker run -itd -p <API_PORT>:3000 -p <BINDAAS_PORT>:9099 -v <IMAGE_DIRECTORY>:/data/images lastlegion/dataloader`

where 
    `<API_PORT>` and `<BINDAAS_PORT>` are arbitrary port numbers on the host machine
    `<IMAGE_DIRECTORY>` is the directory that'll store all the images on the host machine

