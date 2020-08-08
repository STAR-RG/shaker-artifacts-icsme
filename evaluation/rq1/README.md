# RQ1 - Do tests fail more often in noisy environments than in regular (non noisy) environments?

The purpose of this question is to evaluate if executing tests in noisy environments has the effect of making tests fail more often. This is an important question because `Shaker` builds on that assumption to detect flaky tests. To assess this we used the following proceedings. Beware that we parameterize the number of executions in the script, since running 30 times all tests might result in an average of 15 hours to execute (per environment type). 

We assume that `emulator` is already configured in the environment. Typically you can find it under the `Sdk` folder of your Android installation, for instance `$HOME/Android/Sdk/emulator/emulator`.

#### 1. Run emulator device
Run the emulator by executing `emulator @d &`. This yields the PID of the emulator

#### 2. Run standard execution environment

```
python3 exec.py normal 30 {PID}
```

This command executes all of the 75 tests we used 30 times in a standard execution environment, without any noise. 

#### 3. Run noisy environment

```
python3 exec.py shaker 30 {PID}
```
This command executes all of the 75 tests we used 30 times in a noisy execution environment. 

#### 4. Run statistical tests

```
python3 rq1.py
```

This script performs a statistical test that takes two paired distributions on input--one distribution associated with standard executions and one distribution associated with noisy executions. Each number in the distribution corresponds to the rate of failures in one execution of the test suite, that is, the fraction of the tests from our data set that fails. Each distribution contains as many samples as parameterized by the scripts above.