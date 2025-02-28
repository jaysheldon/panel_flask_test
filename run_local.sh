#!/bin/bash

# Kill any Docker containers running on port 8080
docker ps -q --filter "publish=8080" | grep -q . && docker stop $(docker ps -q --filter "publish=8080")

# Forcefully remove any Docker containers with the name myapp_container
docker ps -q --filter "name=myapp_container" | grep -q . && docker rm -f myapp_container

docker rm -f myapp_container
docker container prune -f
# Build the Docker image
docker build -t myapp .

# Run the Docker container
docker run -d -p 8080:8080 -v "$(pwd)":/app --name myapp_container myapp

# View the logs of the running container
docker logs -f myapp_container