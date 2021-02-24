# datalad-wrappers

This repository contains:

* a `Dockerfile` for building a Ubuntu container with datalad and git-annex
* a _Singularity definition file_ `ubuntu.def` for building a similar container with Singularity
* a bash wrapper script named `datalad` that can act as the datalad command or the git-annex command through the Singularity container

Right now, (Feb 2021) the Singularity container created with the
definition file results in a container with **datalad 0.11** while
the container created with the Dockerfile has **datalad 0.12** . I
am not sure how to adjust the definition file in order to get 0.12.
Suggestions welcome.

## Building the image with Docker

```shell
cd this_repo
docker build .
```

The docker image will need to be given a name, which you can do
with the 'docker tag' command.  See the docker manual for more
information.

## Building the image with Singularity

```shell
singularity build datalad.sif ubuntu.def
```

## Building the singularity image from the Docker image

An alternative path to creating the singularity image directly is
it build it from the local docker image created above.

```shell
singularity build datalad.sif docker-daemon:/name_given/with_dockertag:something
```

## How to use the wrappers

This repo contains a bash script called simply 'datalad'. It is a
wrapper that will act as the datalad command provided that the
singularity image `datalad.sif` (created by one of the two steps
above) is installed at an appropriate location. The script will try
to find `datalad.sif` using the environment variable DATALAD_SIF,
or failing that under the exact same directory where the script
itself is installed. It's up to you to decide which of these two
ways you prefer to deploy the command.

The script can be used to invoke ANY command inside the singularity
container, not just datalad. The name of the script itself will be
the command that is invoked inside the container. So you can install
the script several time with several names in order to access as
many commands as you want from the container. An example of that
is provided here by having a symbolic link to it created under the
name "git-annex", which means we can invoke the git-annex command
from the container.

