#
# Docker file for a basic DataLad installation
# Pierre Rioux, pierre.rioux@mcgill.ca, February 2021, August 2022
#

FROM ubuntu:22.04

# Update the system
RUN [ "apt-get", "update", "-qq" ]

# Neurodebian package repo
RUN [ "apt-get", "install", "-y", "--no-install-recommends", "gnupg", "wget", "curl", "ca-certificates" ]
RUN [ "bash", "-e", "-c", "shopt -o -s errexit;wget -O- http://neuro.debian.net/lists/jammy.us-ca.libre | tee /etc/apt/sources.list.d/neurodebian.sources.list" ]
RUN [ "apt-key", "adv", "--recv-keys", "--keyserver", "hkps://keys.openpgp.org:443", "0xa5d32f012649a5a9" ]

# Install datalad from neurodebian
RUN [ "bash", "-e", "-c", "DEBIAN_FRONTEND=noninteractive apt-get install -y datalad git-annex" ]
ENTRYPOINT [ "datalad" ]
