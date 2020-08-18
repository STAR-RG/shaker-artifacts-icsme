from sys import argv
import random
import subprocess
from glob import glob
import os
import re
import copy
import time

RERUNS = 1
REAL_DIR = glob(os.getcwd())[0]
OUT_DIR = REAL_DIR + '/outputs/'
shouldprint = True
showln = False
scores = []
NUMBER_RANGE = 30

if len(argv) > 3:
    NUMBER_RANGE = int(argv[2])
    PID = int(argv[3])
    print('Number of ranges is %d\nPID emulator is %d' % (NUMBER_RANGE, PID))


def parserTests(path):
    testsFails = {}
    allTests = {}
    # change to dir
    files = glob(path + f'/out.*.txt')  # all log files
    for file in files:
        with open(file, "r") as reader:
            ln = 0
            for line in reader:
                lastName = ''
                ln = ln + 1
                stripped_line = line.strip()
                if stripped_line == 'INSTRUMENTATION_RESULT: stream=':  # if is log for tests fails
                    count = 1
                    for line in reader:
                        ln = ln + 1
                        stripped_line = line.strip()
                        if stripped_line.startswith('INS'):
                            break  # leaves the inner loop
                        failLine = f'{count}) '
                        if stripped_line.startswith(failLine):
                            count += 1
                            if showln:
                                print('line %d -> fail: %s' %
                                      (ln, stripped_line))
                            test = line[3:]  # retire the '1) '
                            test = test.strip()  # for cases '10) '
                            position = test.index('(')
                            # remove the package for test name
                            test = test[:position]
                            try:
                                testsFails[test] += 1
                            except KeyError as _:
                                testsFails[test] = 1

                # if is the name of test
                if stripped_line.startswith('INSTRUMENTATION_STATUS: test='):
                    name = stripped_line[29:]  # get only name
                    if name is not lastName:  # for some logs followed in the same test name
                        lastName = name
                        allTests[name] = RERUNS

    return allTests, testsFails  # now, de allTests is de passTests


# cont is the name of outuput file-> out.{count}.txt
def parserData(output, path):
    global scores
    path = OUT_DIR + path + '/' + f'{output}'
    os.chdir(path)
    if shouldprint:
        print(path)

    dictPass, dictFail = parserTests(path)
    #total = len(dictPass) + len(dictFail)
    #score = round( len(dictFail) / total, 2)
    score = round(len(dictFail) / len(dictPass), 2)

    print('the score is %.2f' % score)

    scores.append(score)
    return score


def runTests(config):
    os.chdir(REAL_DIR)
    if len(config) > 1:
        test = f'./exec_stress.sh {config[0]} {config[1]} {config[2]} {config[3]} {config[4]} {config[5]} {PID}'
    else:
        test = f'./exec.sh {config[0]}'
    print("Running %s" % test)
    process = subprocess.Popen(test, stdout=subprocess.PIPE, shell=True)
    stdout = process.communicate()[0].decode("utf-8")
    if shouldprint:
        print(stdout)


def p():
    os.chdir(REAL_DIR)
    f = open("results_normal.txt", "w")
    for s in scores:
        s = s*100
        f.write('%.2f\n' % s)
    f.close()
    print('[%s]' % ', '.join(map(str, scores)))


def p2():
    os.chdir(REAL_DIR)
    f = open("results_shaker.txt", "w")
    for s in scores:
        s = s*100
        f.write('%.2f\n' % s)
    f.close()
    print('[%s]' % ', '.join(map(str, scores)))


def generateConfigs():
    random.seed(16)
    configs = []
    for a in range(NUMBER_RANGE):
        configs.append([a, random.randint(1, 4), random.randint(
            1, 100), random.randint(1, 4), random.randint(1, 100), random.randint(1, 4)])
    return configs


def main():
    global scores
    scores = []
    configs = generateConfigs()
    for config in configs:
        runTests(config)
        parserData(config[0], 'shaker')
        p2()


def normal():
    global scores
    scores = []
    for i in range(NUMBER_RANGE):
        runTests([i])
        parserData(i, 'normal')
        p()


if __name__ == "__main__":
    if len(argv) < 2:
        print("Error: see the README.md inside RQ1 folder for the correct usage of this script")
        exit(1)
    cmd = argv[1]
    if cmd == 'normal':
        print('running normal')
        normal()
    elif cmd == 'shaker':
        print('running shaker')
        main()
    else:
        print("Error: see the README.md inside RQ1 folder for the correct usage of this script")
