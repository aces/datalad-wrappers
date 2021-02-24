#
# Docker file for a basic DataLad installation
# Pierre Rioux, pierre.rioux@mcgill.ca, February 2021
#

FROM ubuntu:20.04

# Update the system
RUN [ "apt-get", "update", "-qq" ]

# Neurodebian package repo
RUN [ "apt-get", "install", "-y", "--no-install-recommends", "gnupg", "wget" ]
RUN [ "bash", "-e", "-c", "shopt -o -s errexit;wget -O- http://neuro.debian.net/lists/focal.de-fzj.libre | tee /etc/apt/sources.list.d/neurodebian.sources.list" ]
RUN [ "apt-key", "adv", "--recv-keys", "--keyserver", "hkp://pool.sks-keyservers.net:80", "0xA5D32F012649A5A9" ]

# Install datalad from neurodebian
RUN [ "bash", "-e", "-c", "DEBIAN_FRONTEND=noninteractive apt-get install -y datalad git-annex" ]
ENTRYPOINT [ "datalad" ]
