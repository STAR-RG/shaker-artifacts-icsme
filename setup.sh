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

#Download APKs
# AntennaPod
wget --no-check-certificate https://drive.google.com/uc?export=download&id=12_vjyZehbBpRHeoxCy2WVCGZBAQA0Kd8 AntennaPod.apk
# AnyMemo
wget https://drive.google.com/uc?export=download&id=1SgyyoCPLjWQDPSWcZKWdGWTvy3bJ50yv
# Espresso
wget https://drive.google.com/uc?export=download&id=1WASqSL854zTG1cppz-Iys9bZq1I1VJQn
# FirefoxLite
wget https://drive.google.com/uc?export=download&id=1Uin8q9lRdx-0ShHOAPkT2KqBiSvQmuQr
# flexbox
wget https://drive.google.com/uc?export=download&id=1sObUYlPyxtjhHWROwi0aJ3U73ILn4CN3
# KISS
wget https://drive.google.com/uc?export=download&id=1IIdqiwjoh9iwraB3AgtzgjZ3qMVle8w_
# OmniNotes
wget https://drive.google.com/uc?export=download&id=1cT1n1bzhAX6T4odYp2-W08kDz0rB31Im
# Orgzly
wget https://drive.google.com/uc?export=download&id=18T7S3ki2x_N0nu-xRUW3dxWHukrgueac
# Paintroid
wget https://drive.google.com/uc?export=download&id=1GwoI2cEgan-FPyu697cU3FdD5_FeCveM
# susi
wget https://drive.google.com/uc?export=download&id=1pYbS8TdLFe5Dczjojm79BItgZFcY9Zn5
# WifiAnalyzer
wget https://drive.google.com/uc?export=download&id=17AXcaB-jKGV5b0Q0zC6uSPOkMeK-_iEF