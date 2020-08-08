# load packages
import pandas as pd
import scipy.stats as stats
import statsmodels.api as sm
from statsmodels.formula.api import ols
from statsmodels.stats.multicomp import pairwise_tukeyhsd

# load data file
d = pd.read_csv("results.csv", sep=",")
# # generate a boxplot to see the data distribution by treatments. Using boxplot, we can easily detect the differences 
# # between different treatments
# d.boxplot(column=['MHS', 'Greedy', 'Random'], grid=False)

mhs = d['MHS']
greedy = d['Greedy']
random = d['Random']

print('--------- Shapiro-Wilk test ---------------')
shap1=stats.shapiro(mhs)
print("shapiro mhs W={0:.2f}, p-value={1:.1e} ".format(round(shap1[0],2), shap1[1]))
shap2=stats.shapiro(greedy)
print("shapiro greedy W={0:.2f}, p-value={1:.1e} ".format(round(shap2[0],2), shap2[1]))
shap3=stats.shapiro(random)
print("shapiro random W={0:.2f}, p-value={1:.1e} ".format(round(shap3[0],2), shap3[1]))
print()

if (shap1[1] < 0.05) and (shap2[1] < 0.05) and (shap3[1] < 0.05):
  print("Your data is NOT normally distributed. Use a non-parametric test")
else:
  print("Your data is normally distributed. Use a parametric test")
print('-------------------------------------------')

print()

print('---------- Apply Bartlett\'s test to Check Homogeneity of Variances ----------------')
bartlett = stats.bartlett(mhs,greedy,random)
print("statistic={0:.2f}, p-value={1:.1e} ".format(round(bartlett[0],2), bartlett[1]))
print()
if bartlett[1]<0.05:
  print("Your samples come from populations with different variance. Use a non-parametric test")
else:
  print("Your samples come from populations with the same variance. Use a parametric test")
print('------------------------------------------------------------------------------------')

print()

print("--------- parametric test of hypothesis ------------")
# stats f_oneway functions takes the groups as input and returns F and P-value
fvalue, pvalue=stats.f_oneway(mhs, greedy, random)
print('F statistic = {0:.2f} and probability p = {1:.1e}'.format(fvalue, pvalue)) 
print()
if pvalue < 0.05:
  print("we have a main interaction effect, creating ANOVA table and applying Tukey HSD test")
  print()
  # reshape the d dataframe suitable for statsmodels package 
  d_melt = pd.melt(d.reset_index(), id_vars=['index'], value_vars=['MHS', 'Greedy', 'Random'])
  # replace column names
  d_melt.columns = ['index', 'treatments', 'value']
  # Ordinary Least Squares (OLS) model
  model = ols('value ~ C(treatments)', data=d_melt).fit()
  anova_table = sm.stats.anova_lm(model, typ=2)
  print(anova_table)

  print()
  # From ANOVA analysis, we know that treatment differences are statistically significant, but ANOVA does not tell which treatments are significantly different from each other. To know the pairs of significant different treatments, we will perform multiple pairwise comparison (Post-hoc comparison) analysis using Tukey HSD test.
  # perform multiple pairwise comparison (Tukey HSD)
  m_comp = pairwise_tukeyhsd(endog=d_melt['value'], groups=d_melt['treatments'], alpha=0.05)
  print(m_comp)

else: 
  print("we reject the null hypothesis, and observe no interaction effect amongst the samples")
print()
print('----------------------------------------------------')
