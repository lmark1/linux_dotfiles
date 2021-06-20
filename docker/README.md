# Docker tutorial

## Introduction

| Description   |      Command      |
|:---------|:------------------------:|
| Run an example docker file |  ```docker run hello-world``` |
| List all the containers (running and exited) |    ```docker ps -a```   |

## Running Conatiners

| Description   |      Command      |
|:---------|:------------------------:|
| Run a command in a docker container.<br/> ```-p``` publish containers ports to the host <br/> ```-d``` run conatiner in background <br/> ```--rm``` automatically delete the container once it exits <br/> ```-P``` publish all exposed ports | ```docker run -p0.0.0.0:80:80 -d ubuntu:latest``` |
| See all the ports that container is running | ```docker port [CONTAINER] ```|
| Run a ```/bin/bash``` command in the ubuntu container <br/> ```-i``` connect the open I/O process streams  <br/> ```-t``` with an allocated TTY terminal |```docker run -it --name mydocker ubuntu /bin/bash```|

## Managing containers

| Description   |      Command      |
|:---------|:------------------------:|
| Stop the docker image (go to EXIT state) | ```docker stop mydocker``` |
| Kill a container from a running state | ```docker kill mydocker``` | 
| Remove a conatiner | ```docker rm mydocker``` |
| Remove all containers | ```docker rm $(docker ps -a -q)```|
| Remove all stopped containers | ```docker container prune```|

## Working with DockerHub registry

| Description   |      Command      |
|:---------|:------------------------:|
|Fetch an image from the DockerHub registry | ```docker pull busybox```|
