# Docker tutorial

## Introduction

| Description   |      Command      |
|:---------|:------------------------:|
| Run an example docker file |  ```docker run hello-world``` |
| List all the containers (running and exited) |    ```docker ps -a```   |

## Running Conatiners

| Description   |      Command      |
|:---------|:------------------------:|
| Run a command in a docker container, publish containers ports to the host ```-p``` and run conatiner in background ```-d``` | ```docker run -p0.0.0.0:80:80 -d ubuntu:latest``` |
| Run a ```/bin/bash``` command in the ubuntu container, connect the open I/O process streams ```-i``` with te allocated TTY terminal ```-t```|```docker run -it --name mydocker ubuntu /bin/bash```|

## Managing containers

| Description   |      Command      |
|:---------|:------------------------:|
| Stop the docker image (go to EXIT state) | ```docker stop mydocker``` |
| Kill a container from a running state | ```docker kill mydocker``` | 
| Remove a conatiner | ```docker rm mydocker``` |
| Remove all containers | ```docker rm $(docker ps -a -q)```|

