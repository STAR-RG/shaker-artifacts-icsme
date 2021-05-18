# RQ2 - How repeatable is the discovery of flaky tests with a given noise configuration?

This question analyzes the variance of results obtained with a given configuration of the noise generator. If results are very non-deterministic then selecting configurations, as described on Section~\ref{sec:search-configs}, is helpless as results would be unpredictable. 

To answer this question, we randomly selected 15 noise configurations and run the test suite on each one of them for 10 times, measuring the percentage of failures detected on each execution. For each one of the 15 configurations, we generated a distribution with 10 samples, where each sample indicates the percentages of failures detected on a given configuration. 

Using the standard parameters (15 configurations x 10 executions) we estimate an average of 28 hours to execute. 

We assume that `emulator` is already configured in the environment. Typically you can find it under the `Sdk` folder of your Android installation, for instance `$HOME/Android/Sdk/emulator/emulator`.

#### 1. Run emulator device
Run the emulator by executing `emulator @d &`. This yields the PID of the emulator

#### 2. Execute noise configurations
```
python3 exec.py 15 10 {PID}
```
This will run all 75 tests, on 15 configurations, 10 times. Data is generated into the `results.txt` file. 

#### 3. Generate boxplot

The `variance.r` script analyzes the data and produces a boxplot associated with the standard deviations of the distributions.