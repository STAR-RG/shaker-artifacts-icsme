#!/usr/bin/env Rscript

library(MESS)

####################### data
#read.delim("rerun_RQ4.csv", comment.char = '#')
data1 = read.csv("rerun_RQ4.csv", header=FALSE, sep=",")
x1 <- data1$V2
y1 <- data1$V1
AUC_RERUN <- auc(x1, y1)

#read.delim("shaker_RQ4.csv", comment.char = '#')
data2 = read.csv("shaker_RQ4.csv", header=FALSE, sep=",")
x2 <- data2$V2
y2 <- data2$V1
AUC_SHAKER <- auc(x2, y2)

print(AUC_RERUN)
print(AUC_SHAKER)
print(paste("AUC_SHAKER/AUC_RERUN", AUC_SHAKER/AUC_RERUN))
#######################

# png scaling
png(file="auc.png", width=400, height=300)

# define borders and stuff...
plot(1:max(x1,x2), ylim=c(1,40), type="n", main="", xlab="Time (m)", ylab="Number of flaky tests detected")

## plot 1
lines(x1, y1, type="l", lty=2, pch=19, col="red")

## plot 2
lines(x2, y2, type="l", pch=17, col="blue")

## vertical line at 10%
print(paste("\n","abline at", max(x2)/10))
abline(v=c(max(x2)/10), col=c("magenta"), lty=c(2), lwd=c(3))

# legends
legend(175, 35, legend=c("ReRun", "Shaker"), col=c("red", "blue"), lty=c(2,1), cex=1.4)