# Shaker

SHAKER is a lightweight approach to detect flakiness in time-constrained tests by adding noise in the execution environment. This repository is organized in the following structure:
- the [`dataset`](ICSME2020/dataset) folder contains the set of flaky tests we used in the paper;
- the [`raw_results`](ICSME2020/raw_results) folder contains the raw data produced from the evaluation we performed; 
- the [`evaluation`](ICSME2020/evaluation) folder contains the toolset developed for running `Shaker` against the apps listed below and producing the raw data described above.
- the [`standalone`](standalone) folder contains the instructions for running `Shaker` in other apps.

## Setup Instructions

The minimum requirements for running the tools and scripts we developed for this work are described below. These steps were executed and tested using a fresh install of the Ubuntu 18.04 LTS environment. The approach relies on running an emulator, and some steps might take long to execute, although we paremeterize our scripts so it is not necessary to run the exact number of replications we executed for each experiment in the paper (see the [`evaluation`](evaluation) folder). 

The step by step instructions follow below, but these are all automated under the [`setup.sh`](setup.sh) script.

#### Install Linux packages
```
sudo apt-get update 
sudo apt-get install -y openjdk-8-jdk stress-ng python3-pip unzip r-base
```

#### Install required Python libraries:

We assume a working Python3 environment. We require installing the following libraries for executing the Minimal Hitting-Set (MHS) algorithm.
```
pip3 install python-sat
pip3 install numpy==1.16.1
```

#### Install Android Command Line tools

```
wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip
unzip commandlinetools-linux-6609375_latest.zip
rm -f commandlinetools-linux-6609375_latest.zip
mkdir cmdline-tools
mv tools/ cmdline-tools
mkdir Android
mv cmdline-tools/ Android
```

#### Configure the Android SDK version and AVD from the command line (Android API version 28)
```
yes | $HOME/Android/cmdline-tools/tools/bin/sdkmanager --licenses
$HOME/Android/cmdline-tools/tools/bin/sdkmanager "platforms;android-28"
$HOME/Android/cmdline-tools/tools/bin/sdkmanager "system-images;android-28;default;x86"
$HOME/Android/cmdline-tools/tools/bin/sdkmanager "build-tools;28.0.3" 
```

If you want to use another API version, such as 23, just change the numbers in `platforms` and `system-images`:
```
$HOME/Android/cmdline-tools/tools/bin/sdkmanager "platforms;android-28"
$HOME/Android/cmdline-tools/tools/bin/sdkmanager "system-images;android-28;default;x86"
```

#### Create AVD device (Android API version 28): 
```
echo no | $HOME/Android/cmdline-tools/tools/bin/avdmanager create avd --name EmuAPI28 --package "system-images;android-28;default;x86"
```

If you want to use another API version, such as 23, just change the corresponding numbers:
```
echo no | $HOME/Android/cmdline-tools/tools/bin/avdmanager create avd --name EmuAPI23 --package "system-images;android-23;default;x86"
```

#### Run the emulator
To run the emulator created by the `setup.sh` script, just execute:
```
./runemulator.sh
```

This will run the `DEFAULT_EMULATOR` defined in the `runemulator.sh`. If you want to run a particular emulator that you have previously created, with a different name, change the variable inside the script or provide the name as the first argument:
```
./runemulator.sh AVD_NAME
```

Finally, if you want to run in headless mode (`-no-window`), you might execute the following script that runs the default emulator: 
```
./runemulator-nogui.sh
```

Again, if you want to run a particular emulator that you have previously created, with a different name, change the variable inside the script or provide it as the first argument:
```
./runemulator-nogui.sh AVD_NAME
```

After finishing booting the emulator for the first time (wait for the boot complete message in the console), the apps we have used for the evaluation can be installed using the [`install-apps.sh`](`install-apps.sh`) script.

#### Executing Shaker

This is all it takes for configuring the environment for running *Shaker* by using the predefined scripts for each research question from the paper, which are available at the [`evaluation`](evaluation) folder. You can also run the `icsme2020-eval.sh` or `quick-eval.sh` to go through all RQs.

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
	booktitle={2020 IEEE International Conference on Software Maintenance and Evolution (ICSME)},
	title = {{Shake It! Detecting Flaky Tests Caused by Concurrency with Shaker}},
	year = {2020},
	pages={301-311},
	doi={10.1109/ICSME46990.2020.00037}
}
```
