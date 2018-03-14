#!/bin/bash

function prop {
  grep $1 deployment.properties | cut -d "=" -f2
}

IMAGE_NAME=$(prop 'image.name')

docker ps -a | grep $IMAGE_NAME | awk '{print $1}' | xargs docker rm -f

docker images -a | grep $IMAGE_NAME | awk '{print $3}' | xargs docker rmi -f
