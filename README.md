[![Docker](https://img.shields.io/docker/v/homeseer/homeseer/latest?color=darkgreen&logo=docker&label=DockerHub%20Latest%20Image)](https://hub.docker.com/repository/docker/homeseer/homeseer/)
[![Docker](https://img.shields.io/docker/v/homeseer/homeseer/beta?color=red&logo=docker&label=DockerHub%20Beta%20Image)](https://hub.docker.com/repository/docker/homeseer/homeseer/)

# Docker Container for HomeSeer 4 (Linux)

(Developed with ♥ by SavageSoftware, LLC.)

## Disclaimers

 -  This repository is not supported, sponsored or directly affiliated with Homeseer ([https://homeseer.com/](https://homeseer.com/)).
 -  This repository and container image are considered `EXPERIMENTAL` at this time.  
 -  We are not responsible for any data lost or systems corrupted! 

---

## Overview

This project provides Docker container images for HomeSeer 4 on Linux.     

The docker images are published via Docker Hub:
 - [https://hub.docker.com/repository/docker/homeseer/homeseer](https://hub.docker.com/repository/docker/homeseer/homeseer)
 - [![Docker](https://img.shields.io/docker/v/homeseer/homeseer/latest?label=DockerHub%20Latest%20Image&logo=docker&style=social)](https://hub.docker.com/repository/docker/homeseer/homeseer/)
 - [![Docker](https://img.shields.io/docker/v/homeseer/homeseer/beta?label=DockerHub%20Beta%20Image&logo=docker&style=social)](https://hub.docker.com/repository/docker/homeseer/homeseer/)

---

## Supported Architectures

- ARM 64-bit ( `arm64` )
- Intel/AMD 64-bit ( `amd64` / `x86_64` )

---

## Getting Started 

The following docker command will download and launch the latest HomeSeer 4 Docker image.
```bash
docker run \
       --interactive \
       --tty \
       --restart always \
       --name homeseer \
       --volume /etc/homeseer:/homeseer \
       --publish 80:80 \
       --publish 10200:10200 \
       --publish 10300:10300 \
       --publish 10401:10401 \
       --publish 11000:11000 \
       --env TZ=America/New_York \
       --env LANG=en_US.UTF-8 \
       homeseer/homeseer:latest
```

On the first run of the `homeseer` container, the script will take a few minutes while it 
installs the HomeSeer application files to the `/homeseer` mapped volume path.  Subsequent 
container restarts will occur much faster as the HomeSeer application files are already 
installed.  If the container is removed and a new container is launched, the HomeSeer
application file will be re-installed even if they already exist in the `/homeseer` 
mapped volume path.  Note: The installation process should not affect any user configuration, 
plugins or log files.  However, it is always a good idea to make sure you have a complete backup 
of the `/homeseer` mapped volume path prior to any upgrades.   

---

## Acknowledgments

Credit must be attributed to the following existing repositories and their respective authors.  Much of 
the logic used in this project was based on these prior works. 

 - https://github.com/marthoc/docker-homeseer
 - https://github.com/scyto/docker-homeseer
 - https://github.com/E1iTeDa357/docker-homeseer4
