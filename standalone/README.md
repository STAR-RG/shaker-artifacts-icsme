We assume that `emulator` is already configured in the environment. Typically you can find it under the `Sdk` folder of your Android installation, for instance `$HOME/Android/Sdk/emulator/emulator`.

#### 1. Run emulator device
Run the emulator by executing `emulator @d &`. This yields the PID of the emulator

#### 2. Add you call to adb test

Add the call to adb run to your test in the file `tests.sh`, follow the example that is commented.

#### 3. Execute Shaker
```
python3 exec.py 10 {name_app} {PID}
```
This will run all tests of the app given by the `{name_app}` parameter, for 10 times with 4 configurations (from MHS).

#### 4. Examine output

After executing the script, the `results.txt` file will contain the list of tests that failed together with the number of times that it failed.
