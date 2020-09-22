# You need to install these libraries
# pip3 install python-sat
# pip3 install numpy==1.16.1

from pysat.examples.hitman import Hitman
import csv
import sys


h = Hitman(solver='m22', htype='lbx')
with open('abstract.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    row_count = 1
    for row in csv_reader:
        list = []
        for col in range(0, len(row)):
            if row[col].strip() == "1":
                list.append(f'c{col+1}')  # we add the configuration instead
        #print("adding row -> {}".format(list))
        if len(list) == 0:
            print(".")
            #print('line empty -> %d' % row_count)
        else:
            h.hit(list)
        row_count += 1
print(h.get())
