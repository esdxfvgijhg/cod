library(Hmisc)

m <- matrix(scan("dataset.txt",skip=0),ncol=4,byrow=T)

cassette = as.factor(m[,1])
wafer = as.factor(m[,2])
site = as.factor(m[,3])
raw = m[,1]

## Generate a 4-plot of the data.
par(mfrow=c(2,2))
plot(raw,ylab="Raw Line Width",type="l")
plot(Lag(raw,1),raw,ylab="Raw Line Width",xlab="lag(Raw Line Width)")
hist(raw,main="",xlab="Raw Line Width")
qqnorm(raw,main="")
par(mfrow=c(1,1))
