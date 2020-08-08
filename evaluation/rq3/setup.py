import random
import subprocess
from glob import glob
import os
import re
import copy
import time
import random
from sys import argv

P = 0.66  # threshold
RERUNS = 1
NUM_EXEC = 1
REAL_DIR = glob(os.getcwd())[0]
OUT_DIR = REAL_DIR + '/outputs/'
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

    for key in testsFails.keys():  # remove failed tests from total tests
        allTests[key] -= testsFails[key]
        if allTests[key] == 0:
            del allTests[key]

    return allTests, testsFails  # now, de allTests is de passTests

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
    os.chdir(REAL_DIR)
    f = open("./" + name + ".csv", "w")
    f.write('%s, %s\n' % ('config', ', '.join(map(str, matrix['config_']))))

    for key in matrix.keys():
        if key in ['config_', 'score_', 'time_']:
            continue
        f.write('%s, %s\n' % (key, ', '.join(map(str, matrix[key]))))

    f.write('%s, %s\n' % ('score', ', '.join(map(str, matrix['score_']))))
    f.write('%s, %s\n' % ('time', ', '.join(map(str, matrix['time_']))))
    f.close()


def outerCsv(matrix, name):
    # f = open("./" + name+ "COL.csv", "w")
    # for ind in range(0, len(matrix['config_'])):
    #    line = []
    #    for key in matrix.keys():
    #        if key in ['config_', 'score_', 'time_'] : continue
    #        line.append(matrix[key][ind])
    #    f.write('%s\n'  % ( ', '.join(map(str, line))))
    # f.close()
    os.chdir(REAL_DIR)

    f = open("./" + name + ".csv", "w")

    for key in matrix.keys():
        if key in ['config_', 'score_', 'time_']:
            continue
        f.write('%s\n' % ', '.join(map(str, matrix[key])))
    f.close()


def generateAbristract(matrix):
    os.chdir(REAL_DIR)
    m = copy.deepcopy(matrix)

    for key in m.keys():
        if key in ['config_', 'score_', 'time_']:
            continue
        m[key] = [1 if x >= P else 0 for x in m[key]]
    # printMatrix(m)
    return m


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


def createRandomConfigs():
    random.seed(15)
    configs = []
    for a in range(NUM_EXEC):
        config = [a, random.randint(1, 4), random.randint(1, 100), random.randint(
            1, 4), random.randint(1, 100),  random.randint(1, 4)]
        configs.append(config)
    return configs


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

    # diligence: checking if the number of passes + number of fails is the same
    totals = copy.deepcopy(dictPass)
    for key in dictFail.keys():
        if key in totals.keys():
            totals[key] = totals[key] + dictFail[key]
        else:
            totals[key] = dictFail[key]
    if shouldprint:
        print(totals.values())
    if (len(set(list(totals.values()))) is not 1):
        raise Exception(
            "the sum of passes and fail should be the same for all tests. please check!")

    total = list(totals.values())[0]
    keyset = set(dictPass.keys()).union(dictFail.keys())
    score = 0
    #
    dictFailPercentage = {}
    for key in keyset:
        numPass = 0
        try:
            numPass = dictPass[key]
        except KeyError as _:
            pass
        num = float(total-numPass)/total
        num = 1 if num >= P else 0  # here
        score += num
        dictFailPercentage[key] = num
        if shouldprint:
            print("%s %.2f" % (key, num))

    score = score/len(keyset)
    if shouldprint:
        print("totalTests: %d" % len(keyset))
    dictFailPercentage["score_"] = round(score, 2)
    dictFailPercentage["time_"] = totalTime

    if not headersOk:
        createHeaders(keyset)

    return dictFailPercentage


def runTests(config):
    os.chdir(REAL_DIR)
    test = f'./testes.sh {config[0]} {config[1]} {config[2]} {config[3]} {config[4]} {config[5]} {NUMBER_REPEAT} {PID}'
    print("runing %s" % test)
    process = subprocess.Popen(test, stdout=subprocess.PIPE, shell=True)
    stdout = process.communicate()[0].decode("utf-8")
    if shouldprint:
        print(stdout)
    results = parserData(config[0])
    return results


def main():
    treinamento = True
    if treinamento:
        configs = createRandomConfigs()
        # configs = configs[17:]
        for config in configs:
            results = runTests(config)
            # config.remove(config[0]) #remove the output path
            results['config_'] = config
            genereteMatrix(results)

            #
            # printMatrix(matrix)
            m = generateAbristract(matrix)
            # generateCsvFile(m, "abstract")
            # generateCsvFile(matrix, "real")
            outerCsv(m, "abstract")
    else:
        print('use exec.py')


if __name__ == "__main__":
    if len(argv) == 5:
        NUMBER_CONFIGS = int(argv[1])
        NUM_EXEC = NUMBER_CONFIGS

        NUMBER_REPEAT = int(argv[2])

        THERESHOLD = float(argv[3])
        P = THERESHOLD
        PID = int(argv[4])
        print('number of configs is %d\nnumber repetat is %d\nTHERESHOLD is %.2f\nPID emulator is %d' %
              (NUMBER_CONFIGS, NUM_EXEC, THERESHOLD, PID))
        main()
    else:
        print("Error: please read the README.md")
        exit(1)
