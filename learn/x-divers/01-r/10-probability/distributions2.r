#!/usr/bin/Rscript
# setwd("enron")

library(getopt)
spec <- matrix(c(
  'file' ,'x',1,"character","input file", "calc_cent.csv",
  'help' ,'h',0,"logical"   ,"this help" , TRUE
),ncol=6,byrow=T)
opt = getopt(spec);
if (!is.null(opt$help)) {cat(paste(getopt(spec, usage=T),"\n"));q();}
j=1;for (i in spec[,1]){if(is.null(opt[[i]])) opt[[i]]=spec[j,6];j <- j+1;}


library("fitdistrplus")
library("formattable")
library("GGally")
#source("script/setup.r")
library("mc2d")  ## needed for dtriang
library("ggplot2")


calc.distribution <- function(calc_cent){
  dist_name <- c("norm", "exp", "weibull", "lnorm", "gamma", "logis", "cauchy", "gumbel", "triang", "binom")
  # cdist
  dgumbel <- function(x, a, b) 1/b*exp((a-x)/b)*exp(-exp((a-x)/b))
  pgumbel <- function(q, a, b) exp(-exp((a-q)/b))
  qgumbel <- function(p, a, b) a-b*log(-log(p))
  # Computation
  cdist <- list()
  for (i in names(calc_cent)[c(-1,-7)]) {
    print(i)
    dat <- abs(calc_cent[[i]])
    fit <- list()
    tryCatch({fit$norm    <- fitdist(dat,dist_name[1])} ,error = function(error_condition)                            {})
    tryCatch({fit$exp     <- fitdist(dat,dist_name[2])} ,error = function(error_condition)                            {})
    tryCatch({fit$weibull <- fitdist(dat,dist_name[3])} ,error = function(error_condition)                            {})
    tryCatch({fit$lnorm   <- fitdist(dat,dist_name[4])} ,error = function(error_condition)                            {})
    tryCatch({fit$gamma   <- fitdist(dat,dist_name[5])} ,error = function(error_condition)                            {})
    tryCatch({fit$logis   <- fitdist(dat,dist_name[6])} ,error = function(error_condition)                            {})
    tryCatch({fit$cauchy  <- fitdist(dat,dist_name[7])} ,error = function(error_condition)                            {})
    tryCatch({fit$gumbel  <- fitdist(dat,dist_name[8], start=list(a=10,b=5))} ,error = function(error_condition)      {})
    tryCatch({fit$triang  <- fitdist(dat,dist_name[9])} ,error = function(error_condition)                            {})
    tryCatch({fit$binom   <- fitdist(dat,dist_name[10] ,start=list(size=8, prob=mean(dat)/8))} ,error = function(error_condition)                            {})
    cdist[[i]] <- fit
  }
  return(cdist)
}

calc.probability <- function(calc_cent){
  # cdist
  dgumbel <- function(x, a, b) 1/b*exp((a-x)/b)*exp(-exp((a-x)/b))
  pgumbel <- function(q, a, b) exp(-exp((a-q)/b))
  qgumbel <- function(p, a, b) a-b*log(-log(p))
  # Computation
  cprob <- list()
  for (i in names(calc_cent)[c(-1,-7)]){
    prob <- list()
    prob$norm <- pnorm(calc_cent[[i]])
    prob$exp <- pexp(calc_cent[[i]])
    prob$weibull <- pweibull(calc_cent[[i]],shape = 1)
    prob$lnorm <- plnorm(calc_cent[[i]])
    prob$gamma <- pgamma(calc_cent[[i]], shape = 1)
    prob$logis <- plogis(calc_cent[[i]])
    prob$cauchy <- pcauchy(calc_cent[[i]])
    prob$gumbel <- pgumbel(calc_cent[[i]], a = 1, b=1)
    prob$binom <- pbinom(calc_cent[[i]], size=2, prob = 0.5)
    prob$triang <- ptriang(calc_cent[[i]])
    prob$empirical <- ecdf(calc_cent[[i]])(calc_cent[[i]])
    cprob[[i]] <- prob
  }
  return(cprob)
}


plot.aic <- function(cdist, calc_cent){
  dist_name <- c("norm", "exp", "weibull", "lnorm", "gamma", "logis", "cauchy", "gumbel", "triang", "binom")
  length_dist <- length(dist_name)

	pdf("bin/AIC.pdf")
  # plot AIC
  loglik <-  matrix(nrow=length(calc_cent), ncol=length_dist)
  for (i in 1:length(calc_cent)){
    for (j in 1:length_dist)
      tryCatch({loglik[i,j] <- cdist[[i]][[j]]$loglik}   ,error = function(error_condition) {loglik[i,j] <- NA})
  }

  loglik <- as.data.frame(loglik)
  colnames(loglik)<- dist_name
  rownames(loglik)<- paste(c(1:length(calc_cent)),names(calc_cent))
  formattable(loglik, row.names=TRUE, list(norm = format, exp = format,weibull = format,lnorm = format,gamma = format,gamm = format,logis = format,cauchy = format))
	dev.off()
}


plot.pdf <- function(cdist, calc_cent){
	pdf("bin/PDF.pdf")
	layout(rbind(1:2, 3:4))
	lapply(seq_along(cdist), function(i) {
		tryCatch({denscomp(cdist[[i]], xlab=names(calc_cent)[i])}   ,error = function(error_condition) {})
	})
	dev.off()
}

plot.cdf2 <- function(cdist, calc_cent){
	pdf("bin/CDF.pdf")
	layout(rbind(1:2, 3:4))
	lapply(seq_along(cdist), function(i) {
		tryCatch({cdfcomp(cdist[[i]],ylab= "CDF (%)", xlab="Delay (ms)", xlim = c(200,500), main=names(calc_cent)[i])}   ,error = function(error_condition) {})
	})
	dev.off()
}


plot.cdf <- function(cdist, calc_cent){
	library(RColorBrewer)
	colors <- sort(brewer.pal(6, "Set1"), decreasing = F)
	pdf("cdf.eps", width=6, height=6)
	j=1
	plot(NA,xlim = c(200,500), ylim = c(0,1),xlab=NA,ylab=NA,main=NA) # Empty plot
	for (i in c(1,3,10,12)) {
		x <- calc_cent[[i]]
		curve(plogis(x, cdist[[i]]$logis$estimate[1], cdist[[i]]$logis$estimate[2]), 200, 450, col = colors[j], xlab='Delay (ms)', ylab='CDF (%)', cex.lab=1.5, lwd = 2, add = TRUE)
		j<-j+1
	}
	legend('bottomright', names(calc_cent)[c(1,3,10,12)] , lty=1, col=colors, bty='n', cex=1.2, lw=2)
	dev.off()
}


plot.hst <- function(data){
	pdf("bin/delay.pdf")
	layout(rbind(1:2, 3:4, 5:6))
	for (i in c(1,3,5,7,9,11)) {
		# par(mar=c(1,1,3,1))
		hist(data[[i]], xlab = "Delay (ms)", main=names(data)[i])
	}
	dev.off()
}



tmp=read.csv(file = opt$file)
calc_cent=as.list(tmp)

cdist <- calc.distribution(calc_cent)
cprob <- calc.probability(calc_cent)

cprob2 <- lapply(seq_along(cprob), function(i) {
  lapply(seq_along(cprob[[i]]), function(j) {
    round(cprob[[i]][[j]],4)
  }) 
})

write.csv(cprob2,"bin/cprob", row.names = FALSE)

plot.aic(cdist, calc_cent)
plot.pdf(cdist, calc_cent)
plot.cdf(cdist, calc_cent)

# plot QQ
pdf("bin/QQ.pdf")
layout(rbind(1:2, 3:4))
lapply(seq_along(cdist), function(i) {
  tryCatch({qqcomp(cdist[[i]], xlab=names(calc_cent)[i])}   ,error = function(error_condition) {})
})
dev.off()

# plot PP
pdf("bin/PP.pdf")
layout(rbind(1:2, 3:4))
lapply(seq_along(cdist), function(i) {
  tryCatch({ppcomp(cdist[[i]], 	xlab=names(calc_cent)[i])}   ,error = function(error_condition) {})
})
dev.off()

## PCA 
#pdf("bin/PCA.pdf")
#pca_centralities(calc_cent[2:13])
#dev.off()

## Correlations 
#pdf("bin/Corr1.pdf")
#ggcorr(
#  as.data.frame(calc_cent),name = expression(rho),geom = "circle",
#  hjust=1,nbreaks=6,angle=-45,palette = "PuOr"
#)
#dev.off()

#pdf("bin/Corr2.pdf", width=33, height=18)
#ggpairs(as.data.frame(calc_cent[c(-1,-7)]))
#dev.off()

# Association
# visualize_association(calc_cent$`Alpha Centrality`, calc_cent$`Burt's Constraint`)


