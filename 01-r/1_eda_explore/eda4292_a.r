#!/usr/bin/env Rscript
DATAPATH <- Sys.getenv("DATAPATH")

#R commands and output:

## Input data.
x = c( 370, 1016, 1235, 1419, 1567, 1820,
       706, 1018, 1238, 1420, 1578, 1868,
       716, 1020, 1252, 1420, 1594, 1881,
       746, 1055, 1258, 1450, 1602, 1890,
       785, 1085, 1262, 1452, 1604, 1893,
       797, 1102, 1269, 1475, 1608, 1895,
       844, 1102, 1270, 1478, 1630, 1910,
       855, 1108, 1290, 1481, 1642, 1923,
       858, 1115, 1293, 1485, 1674, 1940,
       886, 1120, 1300, 1502, 1730, 1945,
       886, 1134, 1310, 1505, 1750, 2023,
       930, 1140, 1313, 1513, 1750, 2100,
       960, 1199, 1315, 1522, 1763, 2130,
       988, 1200, 1330, 1522, 1768, 2215,
       990, 1200, 1355, 1530, 1781, 2268,
      1000, 1203, 1390, 1540, 1782, 2440,
      1010, 1222, 1416, 1560, 1792)

## Generate initial plots of the data.
par(mfrow=c(2,2),bg=rgb(1,1,0.8))
dotchart(x,xlab="Polished Window Strength (ksi)")
boxplot (x,ylab="Polished Window Strength (ksi)")
hist    (x,ylab="Counts",xlab="Polished Window Strength (ksi)",main="")
plot(density(x),xlab="Polished Window Strength (ksi)",main="")


## Generate QQ-plot of the data.
par(mfrow=c(1,1),bg=rgb(1,1,0.8))
qqnorm(x, pch=20, col="Red")


## Plot 99 samples from the data and compare QQ-plots to actual data.
x.ave = mean(x); x.sd = sd(x)
nx = length(x)
nb = 99
u = qnorm(ppoints(nx))
xb = array(dim=c(nx,nb))
for (jb in 1:nb) {
   xb[,jb] = sort(qqnorm(rnorm(nx, mean=x.ave, sd=x.sd),
   plot=FALSE)$y)}
par(mfrow=c(1,1),bg=rgb(1,1,0.8))
zz = qqnorm(x, pch=20, col="Red")
matplot(u, xb, type="p", pch=21, col="Blue", add=TRUE)
points(zz$x,zz$y, pch=20, col="Red")



## Compare QQ-plots of the data for various distributions 
## using maximum likelihood estimation.
require(stats4)
negloglik.gau = function (mu, sigma) {
    if (sigma < 0) {return(Inf)} else {
    -sum(dnorm(x, mean=mu, sd=sigma, log=TRUE))}}
x.gau = mle(negloglik.gau, method="Nelder-Mead",
           start=list(mu=mean(x), sigma=sd(x)))
x.gau@coef

#>        mu     sigma 
#> 1400.8145  389.3003

negloglik.gam = function (alpha, lambda) {
    if (any(c(alpha, lambda) < 0)) {return(Inf)} else {
    -sum(dgamma(x, shape=alpha, rate=lambda, log=TRUE))}}
x.gam = mle(negloglik.gam, method="Nelder-Mead",
           start=list(alpha=(mean(x)/sd(x))^2,
           lambda=mean(x)/var(x)))
x.gam@coef

#>        alpha       lambda 
#> 11.851717840  0.008459428 

negloglik.wei = function (xi, beta, eta) {
    -sum(dweibull(x-xi, shape=beta, scale=eta, log=TRUE)) }
x.wei = mle(negloglik.wei, method="L-BFGS-B",
            lower=c(-Inf, 0, 0),
            start=list(xi=100, beta=2, eta=15))
x.wei@coef

#>          xi        beta         eta 
#>  181.154738    3.428001 1356.441176


## Plot overlaid density for each distribution.
xl = mean(x)-3*sd(x); xu=mean(x)+3*sd(x)
plot(density(x, from=xl, to=xu), ylim=c(0, 0.0012),main="")
curve(dnorm(x, mean=x.gau@coef[1], sd=x.gau@coef[2]),
      from=xl, to=xu, col="LightBlue", add=TRUE, lwd=2)
curve(dgamma(x, shape=x.gam@coef[1], rate=x.gam@coef[2]),
      from=xl, to=xu, col="Brown", add=TRUE, lwd=2)
curve(dweibull(x-x.wei@coef[1], shape=x.wei@coef[2],
      scale=x.wei@coef[3]),
      from=xl, to=xu, col="Purple", add=TRUE, lwd=2)
legend(1700, 0.0012, bty="n",
       legend=c("Data", "Gaussian", "Gamma",
                "Birnbaum-Saunders", "Weibull"), 
       lty=c(1,1,1,1,1),
       col=c("Black","LightBlue", "Brown", "Red", "Purple"))



## Generate QQ-plots for each distribution and overlay.
xy.gau = list(x=sort(qnorm(ppoints(x),
              mean=x.gau@coef[1], sd=x.gau@coef[2])),
              y=sort(x))
xy.gam = list(x=sort(qgamma(ppoints(x),
              shape=x.gam@coef[1], rate=x.gam@coef[2])),
              y=sort(x))
xy.wei = list(x=sort(x.wei@coef[1] + qweibull(ppoints(x),
              shape=x.wei@coef[2], scale=x.wei@coef[3])),
              y=sort(x))
plot(xy.gau, pch=15, col="LightBlue",
     xlab="Theoretical Quantiles",
     ylab="Sample Quantiles")
points(xy.gam, pch=16, col="Brown")
points(xy.wei, pch=18, col="Purple")
legend(500, 2400, bty="n",
       legend=c("Gaussian", "Gamma",
       "Birnbaum-Saunders", "Weibull"), pch=c(15,16,17,18),
       col=c("LightBlue", "Brown", "Red", "Purple"))



## Compute AIC and BIC for each distribution.
aic = c(GAU=AIC(x.gau, k=2), GAM=AIC(x.gam, k=2), WEI=AIC(x.wei, k=2))
bic = c(GAU=AIC(x.gau, k=log(nx)), GAM=AIC(x.gam, k=log(nx)), WEI=AIC(x.wei, k=log(nx)))

signif(cbind(AIC=aic, BIC=bic), 4)

#>      AIC  BIC
#> GAU 1495 1501
#> GAM 1499 1504
#> BS  1507 1512
#> WEI 1498 1505

post = exp(-0.5*(bic-1500))/sum(exp(-0.5*(bic-1500)))
cbind(signif(post, 2))

#> GAU 0.7600
#> GAM 0.1600
#> BS  0.0027
#> WEI 0.0740
