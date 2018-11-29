
library(psych)

# library
library(ggplot2)

myData <- read.csv("./Data/AA2_data.csv", sep = ";")

testData <- myData[1:100, ]
head(myData)
describe(myData)


# Basic histogram
ggplot(myData, aes(x=ch1)) + geom_histogram()
ggplot(myData, aes(x=Ch2)) + geom_histogram()

# Custom Binning. I can just give the size of the bin
ggplot(myData, aes(x=Ch2)) + geom_histogram(binwidth = 0.05)

# basic scatterplot
ggplot(testData, aes(x=Ch2, y=Ch3)) + 
  geom_point()
