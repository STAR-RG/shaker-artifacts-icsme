#!/usr/bin/env Rscript

mydata = read.csv("results.txt", header=FALSE, sep=",")  # read csv file

# create a vector to store std. deviations (initiallized with dummy values)
sds <- seq(1, nrow(mydata), by=1)
avgs <- seq(1, nrow(mydata), by=1)

for (rown in 1:nrow(mydata)) {
    row <- as.numeric(mydata[rown,])
    # use -1 to remove first column, if needed
    sdev <- sd(row)
    mean <- mean(row)
    cat(paste("config",rown,"-> sd:", sdev, "mean:", mean, "\n"))
    ## storing results
    sds[rown] <- as.numeric(sdev)
    # avgs[rown] <- as.numeric(mean)
}

## show average standard deviation
cat(paste("mean std. deviation ->", mean(sds), "\n"))

## boxplot of standard deviation
png(file="sd-random.png",width=400,height=150)
par(mar=c(3,1,1,1) + 0.01)
boxplot(sds, col = "orange", border = "brown", horizontal = TRUE, boxwex=.7)
