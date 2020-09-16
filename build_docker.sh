#!/bin/bash
docker build -t shaker .
docker run --privileged -it shaker bash -c "./e.sh && ./install-apps.sh"