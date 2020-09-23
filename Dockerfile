FROM ubuntu:18.04

RUN apt update && apt install -y openjdk-8-jdk vim git unzip libglu1 libpulse-dev libasound2 libc6  libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxi6  libxtst6 libnss3 wget

ARG ANDROID_API_LEVEL=28
ARG ANDROID_BUILD_TOOLS_LEVEL=28.0.3
ARG EMULATOR_NAME='d'
RUN mkdir Android

RUN wget 'https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip' -P /tmp 
RUN unzip -d /Android /tmp/commandlinetools-linux-6609375_latest.zip 
RUN rm -f /tmp/commandlinetools-linux-6609375_latest.zip

RUN yes Y | /Android/tools/bin/sdkmanager --sdk_root=/Android/ "tools"

RUN /Android/tools/bin/sdkmanager --version --sdk_root=/Android/
RUN yes Y | /Android/tools/bin/sdkmanager  "platforms;android-${ANDROID_API_LEVEL}" "system-images;android-${ANDROID_API_LEVEL};google_apis;x86" "build-tools;${ANDROID_BUILD_TOOLS_LEVEL}"
RUN yes Y | /Android/tools/bin/sdkmanager --licenses
RUN echo "no" | /Android/tools/bin/avdmanager create avd --name ${EMULATOR_NAME} --package "system-images;android-${ANDROID_API_LEVEL};google_apis;x86"


ENV ANDROID_HOME=/Android
ENV PATH "$PATH:$GRADLE_HOME/bin:/opt/gradlew:$ANDROID_HOME/emulator:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"
ENV LD_LIBRARY_PATH "$ANDROID_HOME/emulator/lib64:$ANDROID_HOME/emulator/lib64/qt/lib"
ENV PATH_ADB=$HOME/Android/platform-tools
ENV PATH_EMULATOR=$HOME/Android/emulator

## setup shaker

RUN apt-get install -y stress-ng python3 python3-pip nano
ADD . shaker/
WORKDIR /shaker/