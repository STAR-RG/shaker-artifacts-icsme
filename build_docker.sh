#!/bin/bash
docker build -t shaker .
docker run --privileged -it shaker bash -c "./e.sh && ./install-apps.sh"
docker commit shaker:latest shaker:latest
h=$(docker ps -a | grep -vE "CONTAINER ID" | head -1 | cut -f1 -d" ")
docker commit $h shaker:latest
echo "shaker:latest added successfully. To enter in the container type: 'docker run --privileged -it shaker'"