#!/bin/bash
docker build -t shaker .
docker run --privileged shaker bash -c "./e.sh && ./install-apps.sh && adb emu kill && sleep 10"
h=$(docker ps -a | grep -vE "CONTAINER ID" | head -1 | cut -f1 -d" ")
docker commit $h shaker
echo "shaker:latest added successfully. To enter in the container type: 'docker run --privileged -it shaker /bin/bash'"