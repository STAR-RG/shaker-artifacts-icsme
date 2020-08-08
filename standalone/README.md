# How to run Shaker in your app

We assume that `emulator` is already configured in the environment. Typically you can find it under the `Sdk` folder of your Android installation, for instance `$HOME/Android/Sdk/emulator/emulator`.

#### 1. Run emulator device
Run the emulator by executing `emulator @d &`. This yields the PID of the emulator

#### 2. Add you call to adb test

Add the call to adb run to your test in the file `tests.sh`, following the pattern described below (also commented in the script).
```
adb shell am instrument -w -r    -e package PACKAGE_NAME -e debug false FULLY_QUALIFIED_NAME_TO_YOUR_TEST/androidx.test.runner.AndroidJUnitRunner
```

An example would be:
```
adb shell am instrument -w -r    -e package org.liberty.android.fantastischmemo -e debug false org.liberty.android.fantastischmemo.test/androidx.test.runner.AndroidJUnitRunner
```

#### 3. Execute Shaker
```
python3 exec.py 10 {name_app} {PID}
```
This will run all tests of the app given by the `{name_app}` parameter (use the package name), for 10 times with 4 configurations from MHS.

#### 4. Examine output

After executing the script, the `results.txt` file will contain the list of tests that failed together with the number of times that it failed.
