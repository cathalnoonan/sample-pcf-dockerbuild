#!/bin/sh


# Variable(s)
TEMP_CONTAINER_NAME='cn_pcf_build' # Name used for the temporary image & container


# Build: Create image & container
docker build -t "$TEMP_CONTAINER_NAME:Dockerfile" -f Dockerfile .
docker container create --name $TEMP_CONTAINER_NAME "$TEMP_CONTAINER_NAME:Dockerfile"

# Copy: Copy dist folder out of the container
docker container cp "$TEMP_CONTAINER_NAME":/app/dist .

# Cleanup: Delete container & image
docker container rm $TEMP_CONTAINER_NAME
docker image rm "$TEMP_CONTAINER_NAME:Dockerfile"
