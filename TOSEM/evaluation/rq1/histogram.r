# library
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(extrafont)

noise = read.csv("../../raw_results/rq1/RQ1_noise.csv", header=FALSE, sep=",")  # read csv file
nonoise = read.csv("../../raw_results/rq1/RQ1_rerun.csv", header=FALSE, sep=",")  # read csv file


# Build dataset with different distributions
data <- data.frame(
  type = c(rep("nonoise", nrow(nonoise)), rep("noise", nrow(noise))),
  value = c(nonoise$V1, noise$V1)
)

extrafont::font_import()
extrafont::loadfonts()
p <- data %>%
  ggplot( aes(x=value, fill=type)) +
    geom_histogram(color="#e9ecef", alpha=0.6, position='identity') +
    scale_fill_manual(values=c("#69b3a2", "#404080")) +
    theme_ipsum() +
    labs(fill="")  +
    xlab("failure rate")

ggsave("histogram.png", plot=p, device="png", width=4, height=3)

