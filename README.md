# Local RStudio with Databricks SQL Endpoint

This is a guide on connecting RStudio on a local machine through to a Databricks SQL Endpoint as a service.


# How to use:

Edit the environment flags in the Dockerfile with the ones for your environment.

Adjust the test query and tables as needed

Docker build 

```bash

cd docker_image
docker build . -t datadrone/rstudio_dbsql:latest


```

then run with:

```bash

docker run --rm -p 8787:8787 -e PASSWORD=<set a password> datadrone/rstudio_dbsql:latest


```

login to image with 
username: rstudio
password: the-password-you-set-in-the-docker-run-command