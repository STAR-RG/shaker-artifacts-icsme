import random
import subprocess
from glob import glob
import os
import re
import copy
import time
from sys import argv

RERUNS = 1
REAL_DIR = glob(os.getcwd())[0]
OUT_DIR = REAL_DIR + '/outputs/'
shouldprint = False
showln = False
scores = []
score_config = []
PID = '111'

def parserTests(path, file_):
    testsFails = {}
    allTests = {}
    # change to dir
    files = glob(path + f'/out.{file_}.txt')  # all log files
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
def parserData(output, file):
    global scores
    global score_config
    path = OUT_DIR + f'{output}'
    os.chdir(path)
    if shouldprint:
        print(path)

    dictPass, dictFail = parserTests(path, file)
    #total = len(dictPass) + len(dictFail)
    #score = round( len(dictFail) / total, 2)
    score = round(len(dictFail) / len(dictPass), 2)

    print('the score is %.2f' % score)

    score_config.append(score)
    if len(score_config) == NUMBER_REPEAT:
        scores.append(score_config)
        score_config = []

    return score


def runTests(config, file):
    os.chdir(REAL_DIR)
    test = f'./exec_stress.sh {config[0]} {config[1]} {config[2]} {config[3]} {config[4]} {config[5]} {file} {PID}'
    print("running %s" % test)
    process = subprocess.Popen(test, stdout=subprocess.PIPE, shell=True)
    stdout = process.communicate()[0].decode("utf-8")
    if shouldprint:
        print(stdout)


def p2():
    os.chdir(REAL_DIR)
    f = open("results.txt", "w")
    f.write('%s' % ', '.join(map(str, scores)))
    f.close()
    print('[%s]' % ', '.join(map(str, scores)))


def generateConfigs():
    random.seed(15)
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
        for a in range(NUMBER_REPEAT):
            runTests(config, a)
            parserData(config[0], a)

        p2()


if __name__ == "__main__":
    if len(argv) > 2:
        NUMBER_RANGE = int(argv[1])
        NUMBER_REPEAT = int(argv[2])
        PID = int(argv[3])
        print('number of ranges is %d\nnumber repeat is %d\nPID emulator is %d' %
              (NUMBER_RANGE, NUMBER_REPEAT, PID))
        main()
    else:
        print("Error: please read the README.md")
        exit(1)
