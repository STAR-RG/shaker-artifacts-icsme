from sys import argv
import random
import subprocess
from glob import glob
import os
import re
import copy
import time

RERUNS = 4
REAL_DIR = glob(os.getcwd())[0]
OUT_DIR = REAL_DIR + '/outputs/'
shouldprint = False
showln = False
testsFound = {}
timeLine = []
lastTime = 0.00
lastCount = 0


def parserTests(path, cont):
    testsFails = {}
    allTests = {}
    # change to dir
    files = glob(path + f'/out.{cont}.txt')  # all log files
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
def parserData(output, path, cont=1):
    global testsFound
    global timeLine
    global lastTime
    global lastCount
    path = OUT_DIR + path + '/' + f'{output}'
    os.chdir(path)
    if shouldprint:
        print(path)

    # time here
    time = 0.00
    c = 1
    with open('time.txt') as fp:
        for line in fp:
            if c == cont:
                time += int(line.strip())
                break
            else:
                c += 1
    time = round(time / 60, 2)
    lastTime += time

    dictPass, dictFail = parserTests(path, cont)
    count = 0
    for test in dictFail.keys():
        if test not in testsFound.keys():
            #print('test add: %s' % test)
            count += 1
            testsFound[test] = 1
    lastCount += count
    line = {}
    line['time'] = lastTime
    line['tests'] = lastCount
    timeLine.append(line)
    print('add %d more tests' % count)
    print('------> total tests found is %d' % len(testsFound))

    return dictFail


def runTests(config, cont):
    os.chdir(REAL_DIR)
    test = f'./exec.sh {config[0]} {config[1]} {config[2]} {config[3]} {config[4]} {config[5]} {cont} {PID}'

    print("runing %s" % test)
    process = subprocess.Popen(test, stdout=subprocess.PIPE, shell=True)
    stdout = process.communicate()[0].decode("utf-8")
    if shouldprint:
        print(stdout)


def p():
    f = open(FILENAME, "w")
    for line in timeLine:
        print('%d, %.2f' % (line['tests'], line['time']))
        f.write('%d, %.2f\n' % (line['tests'], line['time']))
    f.close()


def main():  # MHS
    for i in range(NUMBER_REPEAT):
        print('-------------> MHS in loop %s <-------------------' % i)
        configs = [[i, 2, 2, 1, 21, 2], [i, 1, 58, 1, 33, 2],
                   [i, 1, 61, 1, 73, 4], [i, 1, 34, 1, 37, 1]]
        cont = 0  # out.{cont}.txt
        for config in configs:
            cont += 1
            histo = []
            if config[0] in histo:
                continue
                # config.remove(config[0]) #remove the output path
            parserData(i, 'shaker', cont)
            p()


def normal():
    for i in range(1, 500):
        try:
            parserData(i, 'normal')
            p()
        except Exception as _:
            return


if __name__ == "__main__":
    if len(argv) == 3:
        NUMBER_REPEAT = int(argv[1])
        PID = int(argv[2])
        print('number repeat is %d\nPID emulator is %d' %
              (NUMBER_REPEAT, PID))
        FILENAME = 'shaker_RQ4.csv'
        main()

    elif len(argv) == 2:
        print('getting results from ReRun')
        FILENAME = 'rerun_RQ4.csv'
        normal()

    else:
        print("Error: please read the README.md")
        exit(1)

    # main()
