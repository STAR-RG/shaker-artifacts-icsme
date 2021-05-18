# RQ5 - How effective is Shaker to find _new_ flaky tests?

For fairness with `ReRun`, RQ4 restricted the evaluation of `Shaker` to the set of flaky tests that `ReRun` itself was able to discover within 50 re-executions. This question evaluates the ability of `Shaker` to discover flaky tests not detected by `ReRun` in the same set of projects.

We ran `Shaker` on each project for 5h with the goal of finding additional flaky tests. We discarded tests with the `@FlakyTest` annotation from our search to avoid the risk of inflating our results given that developers already signaled a potential issue on those tests. As such, we needed to discard the `Flexbox-layout` project as all tests from that project contain that annotation.

We assume that `emulator` is already configured in the environment. Typically you can find it under the `Sdk` folder of your Android installation, for instance `$HOME/Android/Sdk/emulator/emulator`.

#### 1. Run emulator device
Run the emulator by executing `emulator @d &`. This yields the PID of the emulator

#### 2. Execute Shaker
```
python3 exec.py 10 {name_app} {PID}
```
This will run all tests of the app given by the `{name_app}` parameter, for 10 times with 4 configurations (from MHS).

The list of available apps that can be provided as `{name_app}` is:
```
anymemo
antennapod
espresso
orgzly
firefoxlite
susi
paintroid
omninotes
kiss
wifi
```

#### 3. Examine output

After executing the script, the `results.txt` file will contain the list of tests that failed together with the number of times that it failed.
