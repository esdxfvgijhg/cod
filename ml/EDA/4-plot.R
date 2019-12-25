#!/usr/bin/env Rscript
DATAPATH <- Sys.getenv("DATAPATH")

## Read data.
m <- matrix(scan(paste(DATAPATH,"jahanmi2.dat",sep="/"),skip=50),ncol=16,byrow=T)
head(m)
y = m[,5]

x1 = m[,6]
x2 = m[,7]
x3 = m[,8]
x4 = m[,9]
lab = m[,2]
batch = m[,14]

## Compute summary statistics.
ybar = round(mean(y),5)
std = round(sd(y),5)
n = round(length(y),0)
stderr = round(std/sqrt(n),5)
v = round(var(y),5)

# Compute the five number summary.
# min, lower hinge, Median, upper hinge, max
z = fivenum(y)
lhinge = round(z[2],5)
uhinge = round(z[4],5)
rany = round((max(y)-min(y)),5)

## Compute the inter-quartile range.
iqry = round(IQR(y),5)

## Compute the lag 1 autocorrelation.
z = acf(y)
ac = round(z$acf[2],5)

## Format results for printing.
Statistics = c(n,ybar,std,stderr,v,rany,lhinge,uhinge,iqry,ac)
names(Statistics)= c("Number of Observations ", "Mean", "Std. Dev.", 
                     "Std. Dev. of Mean", "Variance", "Range",
                     "Lower Hinge", "Upper Hinge", "Inter-Quartile Range",
                     "Autocorrelation")
data.frame(Statistics)

#>                         Statistics
#> Number of Observations   480.00000
#> Mean                     650.07731
#> Std. Dev.                 74.63826
#> Std. Dev. of Mean          3.40675
#> Variance                5570.86967
#> Range                    476.36000
#> Lower Hinge              595.97400
#> Upper Hinge              708.42200
#> Inter-Quartile Range     112.29000
#> Autocorrelation           -0.22905

summary(y)

#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>   345.3   596.1   646.6   650.1   708.3   821.7 


## Generate a 4-plot of the data.
library(Hmisc)
par(mfrow = c(2, 2),
    oma = c(0, 0, 2, 0),
    mar = c(5.1, 4.1, 2.1, 2.1)) 
plot(y,ylab="Y",xlab="Run Sequence")
plot(y,Lag(y),xlab="Y[i-1]",ylab="Y[i]")
hist(y,main="",xlab="Y")
qqnorm(y,main="")
mtext("Strength of Ceramic Material: 4-Plot", line = 0.5, outer = TRUE)
