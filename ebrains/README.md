# datalad-wrappers with EBRAIN support

This folder contains:

* a `DataladEbrainsDockerfile` for building a AlmaLinux container with
  datalad, git-annex and the ebrains support module

## Building the image with Docker

```shell
cd this_repo/ebrains
docker build -f DataladEbrainsDockerfile .
docker tag HEXCODE_OF_YOUR_IMAGE dalatad:ebrains  # or whatever tag you prefer
```

The docker image will need to be given a name, which you can do
with the 'docker tag' command.  See the docker manual for more
information.

## Building the apptainer image from the Docker image

```shell
# Given you tagged the Docker build as 'datalad:ebrains' as show above...
apptainer build datalad_ebrains.sif docker-daemon://datalad:ebrains
```

## How to use the wrapper

This repo contains a bash script called simply 'datalad'.
Please see the README.md a the top of the repo for more information.
The script expects to be able to find the file 'datalad.sif'
somewhere, which you can replace by the 'datalad_ebrains.sif'
created by the instructions above.

