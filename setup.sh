#!/bin/bash

cd ~

# Download packages
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk stress-ng python3-pip unzip

# Download Python packages
pip3 install python-sat
pip3 install numpy==1.16.1

#Download and unpack command line tools
wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip
unzip commandlinetools-linux-6609375_latest.zip
rm -f commandlinetools-linux-6609375_latest.zip
mkdir Android
cd Android
mkdir cmdline-tools
mv ../tools/ cmdline-tools
cd ~

#Configure Android
yes | ./Android/cmdline-tools/tools/bin/sdkmanager --licenses
./Android/cmdline-tools/tools/bin/sdkmanager "platforms;android-28"
./Android/cmdline-tools/tools/bin/sdkmanager "system-images;android-28;default;x86"
./Android/cmdline-tools/tools/bin/sdkmanager "build-tools;28.0.3"
echo no | ./Android/cmdline-tools/tools/bin/avdmanager create avd --name d --package "system-images;android-28;default;x86"