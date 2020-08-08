# Shaker

SHAKER is a lightweight approach to detect flakiness in time-constrained tests by adding noise in the execution environment. This repository is organized in the following structure:
- the [`dataset`](dataset) folder contains the set of flaky tests we used in the paper;
- the [`raw_results`](raw_results) folder contains the raw data produced from the evaluation we performed; 
- the [`evaluation`](evaluation) folder contains the toolset developed for running `Shaker` and producing the raw data described above.

## Setup Instructions

The minimum requirements for running the tools and scripts we developed for this work are described below. These steps were executed and tested using a fresh install of the Ubuntu 18.04 LTS environment. The approach relies on running an emulator, and some steps might take long to execute, although we paremeterize our scripts so it is not necessary to run the exact number of replications we executed for each experiment in the paper. Virtual machines might be unable to execute, since they might prevent running Android device emulators (we have used an Intel x86 image for the emulator device, which can't be executed inside an instance of a VirtualBox VM).

#### Install Java
Install OpenJDK 8:
```
sudo apt-get update && sudo apt-get install openjdk-8-jdk
```

#### Install Android Studio

Donwload the [Android Studio](https://developer.android.com/studio) .zip file.
Unzip at the `$HOME` folder, and manually install it by running the `studio.sh` script from the `bin` folder. 

#### Install stress-ng:
```
$ sudo apt-get update && sudo apt-get install stress-ng
```

#### Install required Python libraries:

We assume a working Python3 environment. We require installing the following libraries for executing the Minimal Hitting-Set (MHS) algorithm.
```
$ pip3 install python-sat
$ pip3 install numpy==1.16.1
```

#### Configure the SDK version and AVD from the command line (Android API version 28)
```
$ $HOME/Android/Sdk/tools/bin/sdkmanager "platforms;android-28"
$ $HOME/Android/Sdk/tools/bin/sdkmanager "system-images;android-28;default;x86"
$ $HOME/Android/Sdk/tools/bin/sdkmanager "build-tools;28.0.3" 
```

#### Create AVD device: 
```
$ $HOME/Android/Sdk/tools/bin/avdmanager create avd --name d --package "system-images;android-28;default;x86"
```

#### Download the apps:
To download the apps and use the exactly same commit that we used for each app, execute the following script:
```
$ ./install_apps.sh
```
This will create a folder called `projects` with all the projects used

#### Install the apps in AVD
Start the AVD:
```
$ emulator @d
```
Manually install the apps using Android Studio. Do so by opening each project and choosing to run any AndroidTest, this way it will install the app and tests into the emulator device.

#### Executing Shaker

This is all it takes for configuring the environment for running *Shaker* by using the predefined scripts for each research question from the paper, which are available at the [`evaluation`](evaluation) folder.

## Apps used as Objects of Analyses 

| Name                                                                    | SHA     |
|-------------------------------------------------------------------------|---------|
| [AntennaPod](https://github.com/AntennaPod/AntennaPod)                  | [dd5234c](https://github.com/AntennaPod/AntennaPod/tree/dd5234cd2f91f30947cdbe7c60a47b4a01a4879c) |
| [AnyMemo](https://github.com/helloworld1/AnyMemo)                       | [7e674fb](https://github.com/helloworld1/AnyMemo/tree/7e674fbe3564d22f02338554d53c0542aa171574) |
| [Espresso](https://github.com/TonnyL/Espresso)                          | [043d028](https://github.com/TonnyL/Espresso/tree/043d02860bddc2054257196212d171128b79c96e) |
| [Flexbox-layout](https://github.com/google/flexbox-layout)              | [611c755](https://github.com/google/flexbox-layout/tree/611c7554c7758a0f096573c943c7db6e3199d45b) |
| [FirefoxLite](https://github.com/mozilla-tw/FirefoxLite)                | [048d605](https://github.com/mozilla-tw/FirefoxLite/tree/048d605fb33cab750c7902ad9314158badc3d7c1)  |
| [Kiss](https://github.com/Neamar/KISS)                                  | [00011ce](https://github.com/Neamar/KISS/tree/00011ce861e0d2916a43f741978d27f06651db92) |
| [Omni-Notes](https://github.com/federicoiosue/Omni-Notes)               | [b7f9396](https://github.com/federicoiosue/Omni-Notes/tree/b7f9396288360dbe2ceaa3dd3ac4db73ddaad21f) |
| [Orgzly](https://github.com/orgzly/orgzly-android)                      | [d74235e](https://github.com/orgzly/orgzly-android/tree/d74235e1fc4444962cec9e0b9b17802745df8944) |
| [Paintroid](https://github.com/Catrobat/Paintroid)                      | [1f302a2](https://github.com/Catrobat/Paintroid/tree/1f302a2f3f0a9f0714d98056dbb37af2270f7edb) |
| [Susi](https://github.com/fossasia/susi_android)                        | [17a7031](https://github.com/fossasia/susi_android/tree/17a703154d1cba1d005c674c51683b4d7089c370) |
| [WiFiAnalyzer](https://github.com/VREMSoftwareDevelopment/WiFiAnalyzer) | [80e0b5d](https://github.com/VREMSoftwareDevelopment/WiFiAnalyzer/tree/80e0b5d8504859ac78a142a619e388f2a53d7ee8) |

## Issues opened

For each project where we found flaky tests, we opened issues:

* [AntennaPod (answered)](https://github.com/AntennaPod/AntennaPod/issues/4194)
* [FirefoxLite (answered)](https://github.com/mozilla-tw/FirefoxLite/issues/5013)
* [Espresso](https://github.com/TonnyL/Espresso/issues/22)
* [Kiss](https://github.com/Neamar/KISS/issues/1509)
* [Omni-Notes](https://github.com/federicoiosue/Omni-Notes/issues/761)
* [Orgzly](https://github.com/orgzly/orgzly-android/issues/722)
* [Paintroid](https://jira.catrob.at/browse/PAINTROID-166)
* [WiFiAnalyzer](https://github.com/VREMSoftwareDevelopment/WiFiAnalyzer/issues/298)

## How to cite Shaker

```
@inproceedings{STA:ICSME2020,
	author = {Silva, Denini and Teixeira, Leopoldo and d'Amorim, Marcelo},
	booktitle = {Proceedings of the 36th International Conference on Software Maintenance and Evolution (ICSME 2020)},
	title = {{Shake It! Detecting Flaky Tests Caused by Concurrency with Shaker}},
	year = {2020}
}
```