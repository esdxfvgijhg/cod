#!/usr/bin/env Rscript

# setwd("enron")
# set.seed(1)
# source("script/read.r")
# write.csv(mails, "mails.csv", row.names=FALSE)
mails <- read.csv(file="../res/mails_enron.csv", header=TRUE, sep=",")
set.seed(2016)

library("CINNA")
library("igraph")
library("GGally", quietly = TRUE)
source("script/setup.r")
library("fitdistrplus")
library("mc2d")  ## needed for dtriang
library("formattable")
library("ggplot2")

important.people <- c("louise.kitchen", "mike.grigsby", "greg.whalley", "scott.neal", "kenneth.lay", "harry.arora", "bill.williams")
mails.important <- subset(mails, From %in% important.people | To %in% important.people)

# attr1 <- as.matrix(read.table("data/s100-attr1.dat"))
# attr2 <- as.matrix(read.table("data/s100-attr2.dat"))
# attr3 <- as.matrix(read.table("data/s100-attr3.dat"))
# attr4 <- as.matrix(read.table("data/s100-attr4.dat"))

# mails.important.g <- set_vertex_attr(mails.important.g, "attr1",       value = attr1[,1])
# mails.important.g <- set_vertex_attr(mails.important.g, "attr2",       value = attr2[,1])
# mails.important.g <- set_vertex_attr(mails.important.g, "attr3",       value = attr3[,1])
# mails.important.g <- set_vertex_attr(mails.important.g, "attr4",       value = attr4[,1])

############################################################# Igraph  ####################################################

# mails.g <- graph_from_data_frame(mails, directed=F)
# mails.g <- graph_from_adjacency_matrix(as_adjacency_matrix(mails.g), mode = "undirected", weighted = TRUE)
# mails.g <- simplify(mails.g, remove.multiple = TRUE, remove.loops = TRUE, edge.attr.comb = igraph_opt("edge.attr.comb"))
# 
# plot_aghiles(mails.g)

mails.important.g <- graph_from_data_frame(mails.important, directed=F)
mails.important.g <- graph_from_adjacency_matrix(as_adjacency_matrix(mails.important.g), mode = "undirected", weighted = TRUE)
mails.important.g <- simplify(mails.important.g, remove.multiple = TRUE, remove.loops = TRUE, edge.attr.comb = igraph_opt("edge.attr.comb"))
g <- mails.important.g

######################################################################################################################""

update_diffuser <- function (diffusers, p){
  nearest_neighbors <- setdiff(unlist(ego(g,1,diffusers)), diffusers)
  is.infected <- sample(c(1,0), length(nearest_neighbors), replace=T, prob=c(p,1-p))
  new.infected <- nearest_neighbors[which(is.infected==1)]
  diffusers <- unique (c(diffusers, new.infected))
  return(diffusers)
}

propagation2 <- function(p,t){
  infected <- list(sample(1:vcount(g), 1))
  for(i in 1:t){
    infected[[i+1]] = update_diffuser(infected[[i]], p) %>% sort()
    print(paste("Trick:",i,"Infected;",length(infected[[i]])))
    i <- i+1
  }
  num_cum <- lapply(1:i, function(x) length(infected[[x]])) %>% unlist()
  p_cum <- num_cum/max(num_cum)
  return(p_cum)
}

wgtmat <- apply(get.adjacency(g) %>% as.matrix, 1, function(x) x/sum(x))

propagation <- function(wmat,trust, op,t) {
  # a trust level # wmat weight matrix # op opinion # t iteration
  Y <- list(op)
  for(i in 1:t){ Y[[i+1]] <- (1-trust) * Y[[i]] + trust * (wgtmat %*% Y[[i]])}
  return(Y)
}

###################################################"
p_cum1 <- propagation2(0.8,25); p_cum2 <- propagation2(0.6,25); p_cum3 <- propagation2(0.4,25); p_cum4 <- propagation2(0.2,25);
results2.df <- rbind(cbind(0.8, p_cum1), cbind(0.6, p_cum2), cbind(0.4, p_cum3), cbind(0.2, p_cum4)) %>% as.data.frame
results2.df$`Time` <- c(1:length(p_cum1),1:length(p_cum2),1:length(p_cum3),1:length(p_cum4))
p <- ggplot(results2.df, aes(x=`Time`, y=p_cum1, colour=factor(V1))) + geom_line()+ geom_point() + ylab("CDF of infected users") +labs(colour="Reputation level")

p + theme(
  plot.title   = element_text(color="red", size=14, face="bold.italic"),
  axis.title.x = element_text(color="blue", size=14, face="bold"),
  axis.title.y = element_text(color="#993333", size=14, face="bold")
)

p + theme(
      plot.title   = element_text(color="red", size=14, face="bold.italic"),
      axis.text.x  = element_text(color = "grey20", size = 20, angle = 90, hjust = .5, vjust = .5, face = "plain"),
      axis.text.y  = element_text(color = "grey20", size = 12, angle = 0, hjust = 1, vjust = 0, face = "plain"),  
      axis.title.x = element_text(color = "grey20", size = 12, angle = 0, hjust = .5, vjust = 0, face = "plain"),
      axis.title.y = element_text(color = "grey20", size = 12, angle = 90, hjust = .5, vjust = .5, face = "plain")
)

############################### Trust and diffusion metrics
# How trust changes deffusion process
pmal = ecdf(calc_cent$`Diffusion Degree`)(calc_cent$`Diffusion Degree`)
r1 <- rnorm(958*2); r2 <- rexp(958*2); r3 <- rweibull(958*2,shape = 1); r4 <- rlnorm(958*2); r5 <- rgamma(958*2, shape = 1); r6 <- rlogis(958*2); r7 <- rcauchy(958*2); r8 <- rbinom(958*2, size=2, prob = 0.5); r9 <- rtriang(958*2)
# r1,r6,r7,r9
op <- matrix(r1, vcount(g), 1)
results.df <- rbind(
  # cbind(1  , sapply(propagation(wgtmat, 1  , op, 25), function(x) mean(dist(x)))),
  cbind(0.8, sapply(propagation(wgtmat, 0.8, op, 25), function(x) mean(dist(x)))),
  cbind(0.6, sapply(propagation(wgtmat, 0.6, op, 25), function(x) mean(dist(x)))),
  cbind(0.4, sapply(propagation(wgtmat, 0.4, op, 25), function(x) mean(dist(x)))),
  cbind(0.2, sapply(propagation(wgtmat, 0.2, op, 25), function(x) mean(dist(x))))
  # cbind(0, sapply(propagation(wgtmat, 0, op, 20), function(x) mean(dist(x))))
) %>% as.data.frame
results.df$`Time` <- rep(1:26,4)
p <- ggplot(results.df, aes(x=`Time`, y=V2, colour=factor(V1))) + geom_line()+ geom_point() + ylab("Mean distance") +labs(colour="Reputation level")
write.csv(p$data, file = "MyData.csv")

library(Hmisc)
# layout(rbind(1:2))
dr <- ecdf(unlist(propagation(wgtmat, 0.8, op, 25)[1 ]))(unlist(propagation(wgtmat, 0.8, op, 25)[1 ]))
plot_aghiles(mails.important.g, dr, , "", "", "")
dr <- ecdf(unlist(propagation(wgtmat, 0.8, op, 25)[20]))(unlist(propagation(wgtmat, 0.8, op, 25)[20]))
plot_aghiles(mails.important.g, dr, , "", "", "")

propag <- propagation(wgtmat, 0.8, op, 25)
for (i in c(1:2)) {
  png(cbind(i,".png"), width = 1888, height = 1391)
  dr1 <- ecdf(unlist(propag[i]))(unlist(propag[i]))
  plot_aghiles(mails.important.g, dr1, , "", "", "")
  dev.off()
}

sm <- sir(mails.important.g, beta=5, gamma=1)
sm[[1]]$NR[1000]
plot(sm)

