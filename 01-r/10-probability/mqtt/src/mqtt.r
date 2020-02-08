setwd("../res/")
a1s_0 <- read.csv(file="1s_0.csv", header=T, sep=",")*1000
a1s_1 <- read.csv(file="1s_1.csv", header=T, sep=",")*1000
a5s_0 <- read.csv(file="5s_0.csv", header=T, sep=",")*1000
a5s_1 <- read.csv(file="5s_1.csv", header=T, sep=",")*1000
a10s_0 <- read.csv(file="10s_0.csv", header=T, sep=",")*1000
a10s_1 <- read.csv(file="10s_1.csv", header=T, sep=",")*1000
data <- c(a1s_0,a1s_1,a5s_0,a5s_1,a10s_0,a10s_1)
data

# Histogram
pdf("../bin/delay.pdf")
layout(rbind(1:2, 3:4, 5:6))
for (i in c(1,3,5,7,9,11)) {
  # par(mar=c(1,1,3,1))
  hist(data[[i]], xlab = "Delay (ms)", main=names(data)[i])
}
for (i in c(2,4,6,8,10,12)) {
  # par(mar=c(1,1,3,1))
  hist(data[[i]], xlab = "Delay (ms)", main=names(data)[i])
}
dev.off()

#######################################################################################

library("CINNA")
library("igraph")
library("GGally", quietly = TRUE)
source("script/setup.r")
library("fitdistrplus")
library("mc2d")  ## needed for dtriang
library("formattable")
library("ggplot2")
library('extraDistr')

calc_cent <- data

# calc_dist
dgumbel <- function(x, a, b) 1/b*exp((a-x)/b)*exp(-exp((a-x)/b))
pgumbel <- function(q, a, b) exp(-exp((a-q)/b))
qgumbel <- function(p, a, b) a-b*log(-log(p))

calc_dist <- list()
dist_name <- c("norm", "exp", "weibull", "lnorm", "gamma", "logis", "cauchy", "gumbel", "triang", "binom")
length_cent <- length(calc_cent)
length_dist <- length(dist_name)

for (i in names(calc_cent)) {
  dat <- abs(calc_cent[[i]])
  fit <- list()
  tryCatch({fit$norm    <- fitdist(dat,dist_name[1])} ,error = function(error_condition)                            {})
  # tryCatch({fit$exp     <- fitdist(dat,dist_name[2])} ,error = function(error_condition)                            {})
  # tryCatch({fit$weibull <- fitdist(dat,dist_name[3])} ,error = function(error_condition)                            {})
  # tryCatch({fit$lnorm   <- fitdist(dat,dist_name[4])} ,error = function(error_condition)                            {})
  tryCatch({fit$gamma   <- fitdist(dat,dist_name[5])} ,error = function(error_condition)                            {})
  tryCatch({fit$logis   <- fitdist(dat,dist_name[6])} ,error = function(error_condition)                            {})
  # tryCatch({fit$cauchy  <- fitdist(dat,dist_name[7])} ,error = function(error_condition)                            {})
  # tryCatch({fit$gumbel  <- fitdist(dat,dist_name[8], start=list(a=10,b=5))} ,error = function(error_condition)      {})
  # tryCatch({fit$triang  <- fitdist(dat,dist_name[9])} ,error = function(error_condition)                            {})
  # tryCatch({fit$binom   <- fitdist(dat,dist_name[10] ,start=list(size=8, prob=mean(dat)/8))} ,error = function(error_condition)                            {})
  calc_dist[[i]] <- fit
}

calc_prob <- list()
for (i in names(calc_cent)){
  prob <- list()
  prob$norm <- pnorm(calc_cent[[i]])
  # prob$exp <- pexp(calc_cent[[i]])
  # prob$weibull <- pweibull(calc_cent[[i]],shape = 1)
  # prob$lnorm <- plnorm(calc_cent[[i]])
  prob$gamma <- pgamma(calc_cent[[i]], shape = 1)
  prob$logis <- plogis(calc_cent[[i]])
  # prob$cauchy <- pcauchy(calc_cent[[i]])
  # prob$gumbel <- pgumbel(calc_cent[[i]], a = 1, b=1)
  # prob$binom <- pbinom(calc_cent[[i]], size=2, prob = 0.5)
  # prob$triang <- ptriang(calc_cent[[i]])
  # prob$empirical <- ecdf(calc_cent[[i]])(calc_cent[[i]])
  calc_prob[[i]] <- prob
}

# plot AIC
loglik <-  matrix(nrow=length_cent, ncol=length_dist)
for (i in 1:length_cent){
  for (j in 1:length_dist)
    tryCatch({loglik[i,j] <- calc_dist[[i]][[j]]$loglik}   ,error = function(error_condition) {loglik[i,j] <- NA})
}

loglik <- as.data.frame(loglik)
colnames(loglik)<- dist_name
rownames(loglik)<- paste(c(1:length_cent),names(calc_cent))
formattable(loglik, row.names=TRUE, list(norm = format, exp = format,weibull = format,lnorm = format,gamma = format,gamm = format,logis = format,cauchy = format))

pdf("../bin/centralities_graph_empirical_cdf.pdf")
layout(rbind(1:2, 3:4, 5:6))
for (i in 1:length_cent){
  print(i)
  tryCatch({plot_aghiles(mails.important.g, calc_prob[[i]]$empirical, , "", "", names(calc_cent)[i])}   ,error = function(error_condition) {})
}
dev.off()

# pdf("../bin/centralities_graph_cdf.pdf")
# layout(rbind(1:3, 4:6))
# for (i in 1:length_cent){
#   for (j in 1:length_dist){
#     print(i)
#     par(mar=c(1,1,3,1))
#     tryCatch({plot_aghiles(mails.important.g, calc_prob[[i]][[j]], , "", "", c(names(calc_cent)[i], dist_name[j]))}   ,error = function(error_condition) {})
#   }
# }
# dev.off()

names(calc_cent)[1]  <- "Pkt sent each 1s & QoS level 0"
names(calc_cent)[3]  <- "Pkt sent each 1s & QoS level 1"
names(calc_cent)[10] <- "Pkt sent each 10s & QoS level 0"
names(calc_cent)[12] <- "Pkt sent each 10s & QoS level 1"
# plot CDF
setEPS()
postscript("whatever.eps", width=6, height=6)
layout(rbind(1:2, 3:4))
for (i in c(1,3,10,12)) {
  tryCatch({cdfcomp(calc_dist[[i]],ylab= "CDF (%)", xlab="Delay (ms)", xlim = c(200,500), main=names(calc_cent)[i])}   ,error = function(error_condition) {})
}
for (i in c(2,4,6,8,10,12)) {
  tryCatch({cdfcomp(calc_dist[[i]], xlab=names(calc_cent)[i], main=round(calc_dist[[i]]$gumbel$estimate,3),xlim = c(200,500))}   ,error = function(error_condition) {})
}
dev.off()

# plot cdf
library(RColorBrewer)
colors <- sort(brewer.pal(6, "Set1"), decreasing = F)

pdf("cdf.eps", width=6, height=6)
j=1
plot(NA,xlim = c(200,500), ylim = c(0,1),xlab=NA,ylab=NA,main=NA) # Empty plot
for (i in c(1,3,10,12)) {
  x <- calc_cent[[i]]
  curve(plogis(x, calc_dist[[i]]$logis$estimate[1], calc_dist[[i]]$logis$estimate[2]), 200, 450, col = colors[j], xlab='Delay (ms)', ylab='CDF (%)', cex.lab=1.5, lwd = 2, add = TRUE)
  j<-j+1
}
legend('bottomright', names(calc_cent)[c(1,3,10,12)] , lty=1, col=colors, bty='n', cex=1.2, lw=2)
dev.off()


j=1
for (i in c(2,4,6,8,10,12)) {
  x <- calc_cent[[i]]
  curve(pgumbel(x, calc_dist[[i]]$gumbel$estimate[1], calc_dist[[i]]$gumbel$estimate[2]), .2, .45, main="Tentative 2", col = colors[j], xlab='delay', ylab='CDF', lwd = 2, add = TRUE)
  j<-j+1
}
legend('bottomright', names(calc_cent)[c(2,4,6,8,10,12)] , lty=1, col=colors, bty='n', cex=1, lw=2)


names(calc_cent)[c(1,3,5,7,9,11)]
# plot P
pdf("../bin/centralities_pdf.pdf")
layout(rbind(1:2, 3:4, 5:6))
for (i in c(1,3,5,7,9,11)) {
  tryCatch({denscomp(calc_dist[[i]], xlab=names(calc_cent)[i], xlim = c(200,500))}   ,error = function(error_condition) {})
}
for (i in c(2,4,6,8,10,12)) {
  tryCatch({denscomp(calc_dist[[i]], xlab=names(calc_cent)[i], xlim = c(200,500))}   ,error = function(error_condition) {})
}
dev.off()

tmp <- calc_dist[[1]]$norm

# plot QQ
pdf("../bin/centralities_qq.pdf")
layout(rbind(1:2, 3:4, 5:6))
lapply(seq_along(calc_dist), function(i) {
  tryCatch({qqcomp(calc_dist[[i]], xlab=names(calc_cent)[i])}   ,error = function(error_condition) {})
})
dev.off()

# plot QQ
pdf("../bin/centralities_pp.pdf")
layout(rbind(1:2, 3:4, 5:6))
lapply(seq_along(calc_dist), function(i) {
  tryCatch({ppcomp(calc_dist[[i]], 	xlab=names(calc_cent)[i])}   ,error = function(error_condition) {})
})
dev.off()

###########################################################################################


norm <- list()
for (i in c(1,3,5,7,9,11)) {
  norm[[i]] <- fitdist(data[[i]],"norm")
}

plot(ecdf(data[[1]])(data[[1]]))

pdf("cdf_delay.pdf")
layout(rbind(1:2, 3:4, 5:6))
for (i in c(1,3,5,7,9,11)) {
  # norm <- pnorm(data[[i]])
  ecdf(data[[i]])(data[[i]])
  cdfcomp(list(norm[[i]]), xlab=names(norm)[i])
}
dev.off()

norm

?hist

data$X1sl0t1

for (i in c(1:12)) {
  mins[i] <- min(data[[i]])
  maxs[i] <-max(data[[i]])
  means[i] <-mean(data[[i]])
}

hist(as.numeric(mins))
hist(as.numeric(maxs))
hist(as.numeric(means))

maxs[1]
means[1]

f <- lapply(seq_along(data), function(i) {
  min(data[[i]])
  max(data[[i]])
  mean(data[[i]])
  # names(data)[i]
})

f

min(data[[1]])
data[[1]]

hist(data[[1]])
hist(mails$X0.234487)

min(mails$X0.234487)
max(mails$X0.234487)
mean(mails$X0.234487)
