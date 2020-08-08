#!/bin/bash

# Create a dir to save the projects
mkdir projects
cd projects

# AntennaPod 
git clone https://github.com/AntennaPod/AntennaPod
( 
    cd AntennaPod
    git checkout dd5234c
)

# AnyMemo
git clone https://github.com/helloworld1/AnyMemo
( 
    cd AnyMemo
    git checkout 7e674fb
)
# Espresso
git clone https://github.com/TonnyL/Espresso
( 
    cd Espresso
    git checkout 043d028
)
# FirefoxLite
git clone https://github.com/mozilla-tw/FirefoxLite
( 
    cd FirefoxLite
    git checkout 048d605
)
# Flexbox-layout
git clone https://github.com/google/flexbox-layout
( 
    cd Flexbox-layout
    git checkout 611c755
)
# Kiss
git clone https://github.com/Neamar/KISS
( 
    cd Kiss
    git checkout 00011ce
)
# Omni-Notes
git clone https://github.com/federicoiosue/Omni-Notes
( 
    cd Omni-Notes
    git checkout b7f9396
)
# Orgzly
git clone https://github.com/orgzly/orgzly-android
( 
    cd Orgzly
    git checkout d74235e
)
# Paintroid
git clone https://github.com/Catrobat/Paintroid
( 
    cd Paintroid
    git checkout 1f302a2
)
# Susi
git clone https://github.com/fossasia/susi_android
( 
    cd susi_android
    git checkout 17a7031
)
# WiFiAnalyzer
git clone https://github.com/VREMSoftwareDevelopment/WiFiAnalyzer
( 
    cd WiFiAnalyzer
    git checkout 80e0b5d
)