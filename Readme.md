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


## Dataloader API
Following examples assume `<API_PORT>==32799`

### POST /submitData
`curl -v -F id=TCGA-02-0001 -F upload=@TCGA-02-0001-01Z-00-DX1.83fce43e-42ac-4dcd-b156-2908e75f2e47.svs http://localhost:32799/submitData`
Return type: `json`
On success returns: `{"status":"success"}`

### GET /subjectIdExists
`curl localhost:32799/subjectIdExists?SubjectUID=TCGA-02-0001`
Returns an array with subjectID and file path.
Empty array if subject Id doesnt exist

### GET /getMD5ForImage
`curl localhost:32799/getMD5ForImage?imageFileName=TCGA-02-0001-01Z-00-DX1.83fce43e-42ac-4dcd-b156-2908e75f2e47.svs`
Returns an array with MD5 of the image
`[{"md5sum":"418a0724b0a2113bcd2956bacae105b7"}]`