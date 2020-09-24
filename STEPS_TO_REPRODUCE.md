


# Using docker
* For now our approach using docker only works on linux.
* Check if you environment has support to [hardware acceleration](https://developer.android.com/studio/run/emulator-acceleration#vm-linux-check-kvm).

You can build a docker image or uses the image from shaker in dockerhub:

#### Building the docker image

* Make sure your repo is up to date. Run ">host# git pull" first.
* Build. This will take ~10m and your machine will busy! Be patient. Run `./build_docker.sh`

  @Denini, gere um arquivo com log contendo pontos de verificacao para verificar (quando vc. quiser inspecionar a minha exec. e de Leopoldo) se a execucao foi bem sucedida (se mal sucedida, entender o porque).
* Log into the container. Run the command `docker run --privileged -it shaker /bin/bash`

#### Using the Dockerhub
* Run the command  `docker run --privileged -it shakerproject/shaker /bin/bash`



### Runing the tests
Assuming you are inside the container

* Execute tests from within the shaker container. Run the comand  `./run_tests.sh`

* Copy log files. Run the command ..........................

  @Denini, indique como copiar logs da construcao do container e da execucao dos testes (que estao dentro do container)
