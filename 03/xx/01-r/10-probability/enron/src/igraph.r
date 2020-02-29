#!/usr/bin/env Rscript

# setwd("enron")
# set.seed(1)
# source("script/read.r")
# write.csv(mails, "mails.csv", row.names=FALSE)
mails <- read.csv(file="../res/mails_enron.csv", header=TRUE, sep=",")

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
######################################################################################################################""

set.seed(2016)
g <- mails.important.g

diameter(mails.important.g)
edge_density(mails.important.g)
modularity(mails.important.g)
wtc <- cluster_walktrap(mails.important.g)
modularity(wtc)
mean(degree(mails.important.g))
mean_distance(mails.important.g)

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
# ##################################################
library("EpiModel")
library("ndtv")

mails.important.net <- network(mails.important, matrix.type ="edgelist", weighted = TRUE , directed=FALSE)
# Centrality
for (i in 1:length_cent){
  mails.important.net %v% names(calc_cent)[i] <- calc_cent[[i]]
}

###################################################"
p_cum1 <- propagation2(0.8,25); p_cum2 <- propagation2(0.6,25); p_cum3 <- propagation2(0.4,25); p_cum4 <- propagation2(0.2,25);
results2.df <- rbind(cbind(0.8, p_cum1), cbind(0.6, p_cum2), cbind(0.4, p_cum3), cbind(0.2, p_cum4)) %>% as.data.frame
results2.df$`Time` <- c(1:length(p_cum1),1:length(p_cum2),1:length(p_cum3),1:length(p_cum4))
p <- ggplot(results2.df, aes(x=`Time`, y=p_cum1, colour=factor(V1))) + geom_line()+ geom_point() + ylab("CDF of infected users") +labs(colour="Reputation level")

p + theme(
  plot.title = element_text(color="red", size=14, face="bold.italic"),
  axis.title.x = element_text(color="blue", size=14, face="bold"),
  axis.title.y = element_text(color="#993333", size=14, face="bold")
)

p + theme(
      plot.title = element_text(color="red", size=14, face="bold.italic"),
      axis.text.x = element_text(color = "grey20", size = 20, angle = 90, hjust = .5, vjust = .5, face = "plain"),
      axis.text.y = element_text(color = "grey20", size = 12, angle = 0, hjust = 1, vjust = 0, face = "plain"),  
      axis.title.x = element_text(color = "grey20", size = 12, angle = 0, hjust = .5, vjust = 0, face = "plain"),
      axis.title.y = element_text(color = "grey20", size = 12, angle = 90, hjust = .5, vjust = .5, face = "plain"))

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

####################################################################" Centrality #########################################"""
# c(1,16,19,28,30,31,34,40)
# centrality
centrality <- proper_centralities(as.directed(mails.important.g))
cent_name <- c(2,3,4,5,8,9,10,11,12,13,14,15,17,18,20,21,22,23,24,25,26,27,29,32,35,36,37,41,42,43,45)
calc_cent <- sapply(cent_name, function(x) { 
  print(x) 
  calculate_centralities(as.directed(mails.important.g), include = centrality[x])
})

ego_size
ego_size <- ego_size(mails.important.g)
calc_cent$Ego <- ego_size
# diversity
diversity <- as.numeric(sub(NaN,0,sub(Inf,0,sub(-Inf,0,diversity(mails.important.g)))))
calc_cent$Diversity <- diversity
# strength
strength <- strength(mails.important.g)
calc_cent$Strength <- strength
# subgraph
subgraph <- abs(subgraph_centrality(mails.important.g))
calc_cent$Subgraph <- subgraph
# radiality
library("Matrix")
library("centiserve")
radiality <- radiality(mails.important.g)
calc_cent$Radiality <- radiality
# power_centrality
power_centrality <- abs(power_centrality(mails.important.g))
calc_cent$Power <- power_centrality

# similarity
similarity <- similarity(mails.important.g)
calc_cent$Similarity <- signif(similarity[1,], 1)
# Mutual friends
cocitation <- cocitation(mails.important.g, V(mails.important.g))
calc_cent$`Mutual friends` <- signif(cocitation[1,], 1)
# dist_nameance Measures
dist_nameances <- dist_nameances(mails.important.g, V(mails.important.g))
calc_cent$dist_nameances <- signif(dist_nameances[1,], 1)
# random_walk
# random_walk <- random_walk(mails.important.g, start = 1, steps = 15000)
# calc_cent$random_walk <- table(random_walk)

summary(calc_cent)
length(calc_cent)
write.csv(calc_cent, file = "calc_cent.csv")

################################################################"# Models  ###################################################

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
  tryCatch({fit$exp     <- fitdist(dat,dist_name[2])} ,error = function(error_condition)                            {})
  tryCatch({fit$weibull <- fitdist(dat,dist_name[3])} ,error = function(error_condition)                            {})
  tryCatch({fit$lnorm   <- fitdist(dat,dist_name[4])} ,error = function(error_condition)                            {})
  tryCatch({fit$gamma   <- fitdist(dat,dist_name[5])} ,error = function(error_condition)                            {})
  tryCatch({fit$logis   <- fitdist(dat,dist_name[6])} ,error = function(error_condition)                            {})
  tryCatch({fit$cauchy  <- fitdist(dat,dist_name[7])} ,error = function(error_condition)                            {})
  tryCatch({fit$gumbel  <- fitdist(dat,dist_name[8], start=list(a=10,b=5))} ,error = function(error_condition)      {})
  tryCatch({fit$triang  <- fitdist(dat,dist_name[9])} ,error = function(error_condition)                            {})
  tryCatch({fit$binom   <- fitdist(dat,dist_name[10] ,start=list(size=8, prob=mean(dat)/8))} ,error = function(error_condition)                            {})
  calc_dist[[i]] <- fit
}

calc_prob <- list()
for (i in names(calc_cent)){
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
layout(rbind(1:3, 4:6))
for (i in 1:length_cent){
  print(i)
  par(mar=c(1,1,3,1))
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

# plot CDF
pdf("../bin/centralities_cdf.pdf")
layout(rbind(1:2, 3:4))
lapply(seq_along(calc_dist), function(i) {
  tryCatch({cdfcomp(calc_dist[[i]], xlab=names(calc_cent)[i])}   ,error = function(error_condition) {})
})
dev.off()

# plot P
pdf("../bin/centralities_dens.pdf")
layout(rbind(1:2, 3:4))
lapply(seq_along(calc_dist), function(i) {
  tryCatch({denscomp(calc_dist[[i]], xlab=names(calc_cent)[i])}   ,error = function(error_condition) {})
})
dev.off()

# plot QQ
pdf("../bin/centralities_qq.pdf")
layout(rbind(1:2, 3:4))
lapply(seq_along(calc_dist), function(i) {
  tryCatch({qqcomp(calc_dist[[i]], xlab=names(calc_cent)[i])}   ,error = function(error_condition) {})
})
dev.off()

# plot QQ
pdf("../bin/centralities_pp.pdf")
layout(rbind(1:2, 3:4))
lapply(seq_along(calc_dist), function(i) {
  tryCatch({ppcomp(calc_dist[[i]], 	xlab=names(calc_cent)[i])}   ,error = function(error_condition) {})
})
dev.off()

#####################################################################  PCA   ################################################"

pdf("../bin/centralities_pca3.pdf")
pca_centralities(calc_cent[2:13])
dev.off()

################################################################### Correlations  ############################################"

pdf("../bin/centralities_corr1.pdf")
ggcorr(
  as.data.frame(calc_cent),name = expression(rho),geom = "circle",
  hjust=1,nbreaks=6,angle=-45,palette = "PuOr"
)
dev.off()

pdf("../bin/centralities_corr2.pdf", width=33, height=18)
ggpairs(as.data.frame(calc_cent))
dev.off()

# Association
# visualize_association(calc_cent$`Alpha Centrality`, calc_cent$`Burt's Constraint`)

#########################################################  Plot centrality #####################################################""
pdf("../bin/centralities_graph.pdf")
layout(rbind(1:3, 4:6))
lapply(seq_along(calc_cent), function(x) {
  print(x)
  par(mar=c(1,1,3,1))
  plot_aghiles(mails.important.g, calc_cent[[x]], , "", "", c(x,names(calc_cent)[x]))
})
dev.off()

########################################################### Community ###########################################################"

communities <- list()
### cluster_edge_betweenness
ceb <- cluster_edge_betweenness(mails.important.g,weights = NULL)
communities$Edge_betweenness <- ceb
### cluster_fast_greedy
cfg <- cluster_fast_greedy(mails.important.g)
communities$Fast_greedy <- cfg
### cluster_leading_eigen
cle <- cluster_leading_eigen(mails.important.g)
communities$Leading_eigenvector <- cle
### cluster_spinglass
cs <- cluster_spinglass(mails.important.g, spins=10)
communities$Spinglass <- cs
### cluster_walktrap
cw <- cluster_walktrap(mails.important.g)
communities$Walktrap <- cw
### cluster_label_prop
clp <- cluster_label_prop(mails.important.g)
communities$Label_propagation <- clp
# cluster_louvain
cl <- cluster_louvain(mails.important.g)
communities$Louvain <- cl

membership <- lapply(lapply(communities, membership), as.numeric)

#####################################################################""  PCA   ################################################"

pdf("../bin/communities_pca.pdf")
pca_centralities(membership)
dev.off()

################################################################### Correlations  ############################################"

pdf("../bin/communities_corr1.pdf")
ggcorr(
  as.data.frame(membership),name = expression(rho),geom = "circle",
  max_size=10,min_size=2,size=3,hjust=0.9,nbreaks=6,angle=-45,palette = "PuOr"
)
dev.off()

pdf("../bin/communities_corr2.pdf")
ggpairs(as.data.frame(membership))
dev.off()

# Association
# visualize_association(membership[[1]], membership[[5]])

##############################################################" Plot Community ##################################################
pdf("../bin/communities_graphxx.pdf")
layout(rbind(1:4, 5:8))
lapply(seq_along(communities), function(x) {
  name <- paste(names(communities)[x], "\n", "Modularity:", round(modularity(communities[[x]]), 4))
  par(mar=c(1,1,3,1))
  plot_djoudi(mails.important.g, membership(communities[[x]]), main = name)
})
dev.off()

###############################################################" Technical Edge #####################################################"

mails.important.g <- set_edge_attr  (mails.important.g, "date",        value = as.character.Date(mails.important$Date))
mails.important.g <- set_edge_attr  (mails.important.g, "content",     value = as.character(mails.important$Content))
mails.important.g <- set_edge_attr  (mails.important.g, "cc",          value = as.character(mails.important$Cc))
mails.important.g <- set_edge_attr  (mails.important.g, "ssl",         value = attr4[,1])

###############################################################" Technical Vertex #####################################################"

domain   <- sub("#","extern", sub("[^#].*","intern", sub(".*@.*","#", V(mails.important.g)$name)))
content <- lapply(V(mails.important.g), function(x) { E(mails.important.g)[from(x)][1]$content })
cc <- lapply(V(mails.important.g), function(x) { E(mails.important.g)[to(x)][1]$cc })
ssl <- lapply(V(mails.important.g), function(x) { E(mails.important.g)[from(x)][1]$ssl })

mails.important.g <- set_vertex_attr(mails.important.g, "domain",      value = domain)
mails.important.g <- set_vertex_attr(mails.important.g, "content",      value = content)
mails.important.g <- set_vertex_attr(mails.important.g, "cc",      value = cc)
mails.important.g <- set_vertex_attr(mails.important.g, "ssl",      value = ssl)

####################################################################" Plot Edge #####################################################""

# # Content
# plot_aghiles(mails.important.g, unlist(V(mails.important.g)$content),E(mails.important.g)$content,"","", "Content")
# # SSL
# plot_aghiles(mails.important.g, unlist(V(mails.important.g)$ssl),E(mails.important.g)$ssl,"", "", "SSL")
# # Cc
# plot_aghiles(mails.important.g, unlist(V(mails.important.g)$cc),E(mails.important.g)$cc,"","", "Cc")

####################################################################" Plot Vertex #####################################################""

# Domain
plot_djoudi(mails.important.g, V(mails.important.g)$domain,,"","", "Domain")
# Content
plot_djoudi(mails.important.g, unlist(V(mails.important.g)$content), ,"","", "Content")
# SSL
plot_djoudi(mails.important.g,unlist(V(mails.important.g)$ssl), ,"", "", "SSL(arbitrary)")
# Cc
plot_djoudi(mails.important.g, unlist(V(mails.important.g)$cc),,"","", "Cc")
# Trust path
plot_djoudi(mails.important.g, ,unlist(E(mails.important.g)$ssl),"","", "Trust path (arbitrary)")


# similarity
layout(rbind(1:3))
similarity <- similarity(mails.important.g)
lapply(c(1), function(i) {
  plot_aghiles(mails.important.g,
               node_data = signif(similarity[i,], 1),
               main = "local similarity", 
               index = i)
})
# Mutual friends
cocitation <- cocitation(mails.important.g, V(mails.important.g))
lapply(c(1), function(i) {
  plot_aghiles(mails.important.g,
              node_data = signif(cocitation[i,], 1),
              main = "Local cocitation", 
              index = i)
})
# dist_nameance Measures
# radius(mails.important.g, mode = c("in"))
# diameter(mails.important.g, directed = TRUE)
dist_nameances <- dist_nameances(mails.important.g, V(mails.important.g))
lapply(c(1), function(i) {
  plot_aghiles(mails.important.g,
               node_data = signif(dist_nameances[i,], 1),
               main = "Local dist_nameances", 
               index = i)
})

######"#############################################" P social ######################################################"
summary(calc_cent)

ptech <- ecdf(calc_cent$`DMNC - Density of Maximum Neighborhood Component`)(calc_cent$`DMNC - Density of Maximum Neighborhood Component`)
pmal = ecdf(calc_cent$`Diffusion Degree`)(calc_cent$`Diffusion Degree`) * ptech
pv = 1 - (1-pmal)^calc_cent$`Degree Centrality`
psocial1 = pv * ecdf(calc_cent$`clustering coefficient`)(calc_cent$`clustering coefficient`)

psocial2 <- page.rank (mails.important.g, damping = .2, personalized= calc_cent$`DMNC - Density of Maximum Neighborhood Component`)$vector

library(centiserve)
psocial3 <- diffusion.degree(mails.important.g, mode = c("all"),lambda = 0.7)

layout(rbind(1:3))
library(Hmisc)
Ecdf(psocial1)
Ecdf(psocial2)
Ecdf(psocial3)

layout(rbind(1:3))
hist(psocial1)
hist(psocial2)
hist(psocial3)


plot_aghiles(mails.important.g, ecdf(calc_cent$`DMNC - Density of Maximum Neighborhood Component`)(calc_cent$`DMNC - Density of Maximum Neighborhood Component`), , "", "", "P technical")

layout(rbind(1:3))
plot_aghiles(mails.important.g, ecdf(psocial1)(psocial1), , "", "", "P social")
plot_aghiles(mails.important.g, ecdf(psocial2)(psocial2), , "", "", "P social page rank")
plot_aghiles(mails.important.g, ecdf(psocial3)(psocial3), , "", "", "P social")



