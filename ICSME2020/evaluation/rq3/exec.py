from sys import argv
import random
import subprocess
from glob import glob
import os
import re
import copy
import time
P = 0.3  # PESO
RERUNS = 5
NUM_EXEC = 50
REAL_DIR = glob(os.getcwd())[0]
OUT_DIR = REAL_DIR + '/outputsTest/'
shouldprint = False
headersOk = False
matrix = {}
showln = False


def parserTests(path):
    testsFails = {}
    allTests = {}
    # change to dir
    files = glob(path + '/out.*.txt')  # all log files
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

    return allTests, testsFails  # now, the allTests is the passTests

# ------------------


def printMatrix(matrix):
    print('-----------')
    print('%s, %s' % ('config', ', '.join(map(str, matrix['config_']))))

    for key in matrix.keys():
        if key in ['config_', 'score_', 'time_']:
            continue
        print('%s, %s' % (key, ', '.join(map(str, matrix[key]))))

    print('%s, %s' % ('score', ', '.join(map(str, matrix['score_']))))
    print('%s, %s' % ('time', ', '.join(map(str, matrix['time_']))))


def generateCsvFile(matrix, name):
    f = open("./" + name + ".csv", "w")
    f.write('%s, %s\n' % ('config', ', '.join(map(str, matrix['config_']))))

    for key in matrix.keys():
        if key in ['config_', 'score_', 'time_']:
            continue
        f.write('%s, %s\n' % (key, ', '.join(map(str, matrix[key]))))

    f.write('%s, %s\n' % ('score', ', '.join(map(str, matrix['score_']))))
    f.write('%s, %s\n' % ('time', ', '.join(map(str, matrix['time_']))))
    f.close()


def createHeaders(keys):
    global headersOk
    global matrix
    headersOk = True
    # colocar testes em cada linha
    for key in keys:
        matrix[str(key)] = []

    matrix['config_'] = []
    matrix['score_'] = []
    matrix['time_'] = []

    if shouldprint:
        print(matrix)


def genereteMatrix(results):
    global matrix
    for key in matrix.keys():
        if(key in results.keys()):
            matrix[key].append(results[key])
        else:
            matrix[key].append(0)
    if shouldprint:
        print(matrix)


def parserData(output):
    path = OUT_DIR + f'{output}'
    os.chdir(path)
    if shouldprint:
        print(path)

    # time here
    with open('time.txt') as fp:
        line1 = fp.readline().split(" ")[1]
        line2 = fp.readline().split(" ")[1]
        ftr = [3600, 60, 1]
        xs = sum([a*b for a, b in zip(ftr, map(int, line1.split(':')))])
        ys = sum([a*b for a, b in zip(ftr, map(int, line2.split(':')))])

    totalTime = ys-xs
    if(totalTime < 0):
        # adjustment buggy: calculates startTime until midnight then sum with FinalTime
        totalTime = ((24*60*60) - xs) + ys
    if shouldprint:
        print("total time: %d %s" %
              (totalTime, "<---this is buggy" if totalTime < 0 else ""))

    dictPass, dictFail = parserTests(path)
    score = float(len(dictFail) / len(dictPass))
    if shouldprint:
        print("totalTests: %d" % len(dictPass))
    dictFail["score_"] = round(score, 2)
    dictFail["time_"] = totalTime

    print('The score is %f', round(score, 2))
    if not headersOk:
        createHeaders(dictPass)

    return dictFail


def runTests(config, cont):
    os.chdir(REAL_DIR)
    if(len(config) > 1):
        test = f'./exec.sh {config[0]} {config[1]} {config[2]} {config[3]} {config[4]} {config[5]} {cont} {PID}'
    else:
        test = f'./exec.sh {config[0]}'
    print("runing %s" % test)
    process = subprocess.Popen(test, stdout=subprocess.PIPE, shell=True)
    stdout = process.communicate()[0].decode("utf-8")
    if shouldprint:
        print(stdout)


def main():  # MHS
    global matrix
    global headersOk
    result_mhs = []
    for i in range(300000, 300000+NUMBER_REPEAT):
        print('----> MHS in loop %s' % i)
        configs = [[i, 2, 2, 1, 21, 2], [i, 1, 58, 1, 33, 2],
                   [i, 1, 61, 1, 73, 4], [i, 1, 34, 1, 37, 1]]
        cont = 0  # out.{cont}.txt
        for config in configs:
            cont += 1
            runTests(config, cont)
            results = parserData(i)
            result_mhs.append(results['score_'])
            results['config_'] = config
            genereteMatrix(results)
            #generateCsvFile(matrix, "abstract")
            matrix = {}
            headersOk = False

    print('------------> result_mhs = [%s]' % ', '.join(map(str, result_mhs)))


def greed():  # greed
    global matrix
    global headersOk
    result_mhs = []
    for i in range(20000, 20000 + NUMBER_REPEAT):
        print('----> GREEDY in loop %s' % i)
        configs = [[i, 1, 58, 1, 33, 2], [i, 1, 61, 1, 73, 4],
                   [i, 1, 79, 1, 8, 3], [i, 1, 51, 1, 13, 2]]
        cont = 0  # out.{cont}.txt
        for config in configs:
            cont += 1
            histo = []
            if config[0] in histo:
                continue
                # config.remove(config[0]) #remove the output path
            runTests(config, cont)
            results = parserData(i)
            result_mhs.append(results['score_'])
            results['config_'] = config
            genereteMatrix(results)
            #generateCsvFile(matrix, "abstract")
            matrix = {}
            headersOk = False

    print('------------> GREEDY = [%s]' % ', '.join(map(str, result_mhs)))


def randomC():  # ramdom
    global matrix
    global headersOk
    result_mhs = []
    random.seed(7)
    for i in range(NUMBER_REPEAT):
        print('----> ramdon in loop %s' % i)
        configs = [[i, 1, 51, 1, 13, 2], [i, 2, 15, 3, 60, 3], [i, 1, 19, 3, 32, 4], [
            i, 4, 84, 2, 5, 1]]  # [[i, 3, 54, 2, 54, 2], [i, 1, 10, 1, 15, 4]
        # config = []
        # for c in range(4):
        #    a = configsTotal[r.randint(0,len(configsTotal) - 1)]
        #    config.append(a)
        cont = 0  # out.{cont}.txt
        for config in configs:
            cont += 1
            runTests(config, cont)
            results = parserData(i)
            result_mhs.append(results['score_'])
            results['config_'] = config
            genereteMatrix(results)
            #generateCsvFile(matrix, "abstract")
            matrix = {}
            headersOk = False

    print('------------> RADOM = [%s]' % ', '.join(map(str, result_mhs)))


if __name__ == "__main__":
    if len(argv) == 4:
        TYPE = argv[1]
        NUMBER_REPEAT = int(argv[2])
        PID = int(argv[3])
        print('exec %s\nnumber repetat is %d\nPID emulator is %d' %
              (TYPE, NUMBER_REPEAT, PID))
        if TYPE == 'greedy':
            greed()
        elif TYPE == 'MHS':
            main()
        elif TYPE == 'random':
            randomC()
        else:
            print("Error: please read the README.md")
            exit(1)
    else:
        print("Error: please read the README.md")
        exit(1)
