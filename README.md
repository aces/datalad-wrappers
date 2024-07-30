# datalad-wrappers (also, with EBRAINS support)

## Plain Datalad (without EBRAINS)

This repository contains:

* a `Dockerfile` for building a Ubuntu container with datalad and git-annex
* an _Apptainer definition file_ `ubuntu.def` for building a similar container with Apptainer
* a bash wrapper script named `datalad` that can act as the datalad command or the git-annex command through the Apptainer container

Right now, (Feb 2021) the Apptainer container created with the
definition file results in a container with **datalad 0.11** while
the container created with the Dockerfile has **datalad 0.12** . I
am not sure how to adjust the definition file in order to get 0.12.
Suggestions welcome.

## Datalad with EBRAINS

The folder 'ebrains' contains basically the same things as the top
level directory, but with the necessary code to build a container
that also support the special EBRAINS module for datalad. The
dockerfile in there use a more recent Linux distribution, AlmaLinux.
See the README.md in there for more information.

## Building the image with Docker

```shell
cd this_repo
docker build .
docker tag dalatad:ubuntu22  # or whatever tag you prefer
```

The docker image will need to be given a name, which you can do
with the 'docker tag' command.  See the docker manual for more
information.

## Building the image with Apptainer

```shell
apptainer build datalad.sif ubuntu.def
```

## Building the apptainer image from the Docker image

An alternative way to create the apptainer image directly is
to build it from the local docker image created above.

```shell
# Given you tagged the Docker build as 'datalad:ubuntu22' as show above...
apptainer build datalad.sif docker-daemon://datalad:ubuntu22
```

## How to use the wrappers

This repo contains a bash script called simply 'datalad'. It is a
wrapper that will act as the datalad command provided that the
apptainer image `datalad.sif` (created by one of the two steps
above) is installed at an appropriate location. The script will try
to find `datalad.sif` using the environment variable DATALAD_SIF,
or failing that under the exact same directory where the script
itself is installed. It's up to you to decide which of these two
ways you prefer to deploy the command.

The script can be used to invoke ANY command inside the apptainer
container, not just datalad. The name of the script itself will be
the command that is invoked inside the container. So you can install
the script several time with several names in order to access as
many commands as you want from the container. An example of that
is provided here by having a symbolic link to it created under the
name "git-annex", which means we can invoke the git-annex command
from the container.

