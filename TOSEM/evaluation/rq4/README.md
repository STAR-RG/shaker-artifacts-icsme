# RQ4 - How effective is Shaker to find flaky tests?

This question evaluates how `Shaker` compares with `ReRun` to find the flaky tests in our data set. To answer this question, we measured how long `Shaker` and `ReRun` took to discover all flaky tests and how quickly each technique finds most tests. 

The goal of this research question is to evaluate `Shaker`'s performance. To that end, we analyzed two dimensions: (i) efficiency, i.e., how fast it finds flaky tests, and (ii) completeness, i.e., what is the fraction of the set of known flaky tests the technique detects. The set of flaky tests to be detected corresponds to the test set. 

We assume that `emulator` is already configured in the environment. Typically you can find it under the `Sdk` folder of your Android installation, for instance `$HOME/Android/Sdk/emulator/emulator`.

#### 1. Run emulator device
Run the emulator by executing `emulator @d &`. This yields the PID of the emulator

#### 2. Execute ReRun
```
./ReRun.sh 50
```
This will run all the 40 tests for 50 times in the standard execution mode.

#### 3. Collect and analyze ReRun results
```
python3 exec.py ReRun
```
This script collects the results from `ReRun`, which are saved to `rerun_RQ4.csv`.

#### 4. Execute SHAKER
```
python3 exec.py 15 {PID}
```
This will run all the 40 tests for 15 times with `Shaker`. The results are saved to `shaker_RQ4.csv`.

#### 5. Producing the Area Under the Curve image with R
```
Rscript auc.r
```