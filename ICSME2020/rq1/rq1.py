# Wilcoxon signed-rank test
from scipy import stats
import numpy
import math

with open('./results_normal.txt') as f:
    data1 = f.read()
    data1 = data1.split('\n')

shap = stats.shapiro(data1)
print(
    "shapiro file1 W={0:.2f}, p-value={1:.1e} ".format(round(shap[0], 2), shap[1]))

with open('./results_shaker.txt') as f:
    data2 = f.read()
    data2 = data1.split('\n')

shap = stats.shapiro(data2)
print(
    "shapiro file2 W={0:.2f}, p-value={1:.1e} ".format(round(shap[0], 2), shap[1]))
if shap[1] < 0.05:
    print("\t Your data is NOT normally distributed. Use a non-parametric test")
else:
    print("\t Your data is normally distributed. Use a parametric test")

print("--------- non-parametric test of hypothesis ------------")
print("for kruskal, HO is that there are no difference in treatments (distributions); H1 is that there is difference.")
kruskal = stats.kruskal(data1, data2)
print("reject null hypothesis if Xi-squared value pvalue is GREATER than 3.8414\n", kruskal)
if kruskal[0] > 3.8414:
    print("\tH0 rejected ---> distributions different")
    print("median of file1 {}".format(numpy.median(data1)))
    print("median of file2 {}".format(numpy.median(data2)))

    # to compute effect size:
    # r = Z / sqrt(N), where N is the number of samples and Z is the wilcoxon rank sum statistic
    # abs(r)=0.1 (small), abs(r)=0.3 (medium), and abs(r)=0.5 (large)
    wilcoxon = stats.ranksums(data1, data2)
    print(wilcoxon)
    print(wilcoxon[0]/math.sqrt(len(data1)))
else:
    print("\tH0 not rejected ---> distributions same")
print("--------------------------------------------------------")

# # compare samples
# stat, p = stats.wilcoxon(data1, data2)
# print('Statistics=%.3f, p=%.3f' % (stat, p))
# # interpret
# alpha = 0.05
# if p > alpha:
# 	print('Same distribution (fail to reject H0)')
# else:
# 	print('Different distribution (reject H0)')
