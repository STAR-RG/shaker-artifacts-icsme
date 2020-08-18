#!/bin/bash

PATH_SDKMAN="./Android/cmdline-tools/tools/bin"
PATH_ADB="./Android/platform-tools"
PATH_EMULATOR="./Android/emulator"

cd ~

# Download packages
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk stress-ng python3-pip unzip r-base

# Download Python packages
pip3 install python-sat
pip3 install numpy==1.16.1

#Download and unpack command line tools
wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip
unzip commandlinetools-linux-6609375_latest.zip
rm -f commandlinetools-linux-6609375_latest.zip
mkdir cmdline-tools
mv tools/ cmdline-tools
mkdir Android
mv cmdline-tools/ Android

#Configure Android
yes | $PATH_SDKMAN/sdkmanager --licenses
$PATH_SDKMAN/sdkmanager "platforms;android-28"
$PATH_SDKMAN/sdkmanager "system-images;android-28;default;x86"
$PATH_SDKMAN/sdkmanager "build-tools;28.0.3"
echo no | $PATH_SDKMAN/avdmanager create avd --name d --package "system-images;android-28;default;x86"

source ./setvars.sh