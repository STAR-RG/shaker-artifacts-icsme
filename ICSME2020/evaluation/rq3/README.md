# RQ3 - How effective is the search for configurations of the noise generator that Shaker uses?

This question evaluates the effect of the (configuration) search strategies proposed by `Shaker` in their ability to detect flaky tests. More precisely, we evaluated three strategies for selecting configurations, namely, (i) Minimum Hitting Set (MHS), (ii) Greedy, and (iii) Random. MHS is the technique that finds the smallest set of configurations whose execution of the test suite is capable of detecting all flaky tests from the training set. Greedy is the technique that selects configurations with maximum individual fitness scores. Random serves as our control in this experiment. It is the technique that randomly selects configurations regardless of their scores. Both Greedy and Random select the same number of configurations as MHS. The metric we used to compare techniques is the ratio of flaky tests detected when re-running the test suite against all configurations in the set associated with a technique.

We assume that `emulator` is already configured in the environment. Typically you can find it under the `Sdk` folder of your Android installation, for instance `$HOME/Android/Sdk/emulator/emulator`.

#### 1. Run emulator device
Run the emulator by executing `emulator @d &`. This yields the PID of the emulator

#### 2. Execute training phase
```
python3 setup.py 15 3 0.66 {PID}
```
This will run all 35 tests, on 15 configurations, 3 times, the threshold is 0.66. Data is generated into the `abstract.csv` file. 

#### 3. Execute test phase
```
python3 exec.py {SEARCH_STRATEGY} 10 {PID}
```
This will run all 40 tests, on the chosen search strategy configuration (`greedy`, `MHS`, or `random`) for 10 times, the results are printed to the console. 
Please add it to the `results.csv` file, in the corresponding column, following the pattern.

```
greedy
MHS
random
```

#### 4. Run statistical tests

```
python3 rq3.py
```

This script performs the statistical tests to evaluate if there are differences in the measurements obtained by MHS, Greedy, and Random. The metric used was the fitness score, measured by the ratio of flaky tests detected when using each selection strategy. 