#!/bin/bash

function prop {
  grep $1 deployment.properties | cut -d "=" -f2
}

IMAGE_USER=$(prop 'image.user')
IMAGE_NAME=$(prop 'image.name')
IMAGE_VERSION=$(prop 'image.version')

echo "Building container $IMAGE_USER/$IMAGE_NAME:$IMAGE_VERSION"

docker run \
  --interactive \
  --tty \
  --name $IMAGE_NAME \
  --hostname $IMAGE_NAME \
  --publish 80:80 \
  --publish 443:443 \
  --publish 9009:9009 \
  $IMAGE_USER/$IMAGE_NAME:${IMAGE_VERSION}
