#!/usr/bin/env Rscript
setwd("caliopen")

# sed -i "1s/.*/From;To;Content;Date;x/" mails_caliopen.csv
# source("script/read.r")
# write.csv(mails_caliopen, "mails_caliopen.csv", row.names=FALSE)
mails_caliopen <- read.csv(file="../res/mails_caliopen.csv", header=TRUE, sep=";")

library("CINNA")
library("igraph")
library("GGally", quietly = TRUE)
library(plyr)
library("fitdistrplus")
library(mc2d)  ## needed for dtriang
library(formattable)
source("script/setup.r")

mails_caliopen.counted <- ddply(mails_caliopen, .(From, To, Content, Date, x), summarise, weight = length(To))
mails_caliopen.sender <- unique(mails_caliopen.counted$From)
mails_caliopen.connected <- subset(mails_caliopen.counted, To %in% mails_caliopen.sender)
mails_caliopen.receiver <- unique(mails_caliopen.connected$To)
mails_caliopen.connected <- subset(mails_caliopen.connected, From %in% mails_caliopen.receiver)
mails_caliopen.important <- subset(mails_caliopen.connected, weight > 0)

# attr1 <- as.matrix(read.table("data/s100-attr1.dat"))
# attr2 <- as.matrix(read.table("data/s100-attr2.dat"))
# attr3 <- as.matrix(read.table("data/s100-attr3.dat"))
# attr4 <- as.matrix(read.table("data/s100-attr4.dat"))

# mails_caliopen.important.g <- set_vertex_attr(mails_caliopen.important.g, "attr1",       value = attr1[,1])
# mails_caliopen.important.g <- set_vertex_attr(mails_caliopen.important.g, "attr2",       value = attr2[,1])
# mails_caliopen.important.g <- set_vertex_attr(mails_caliopen.important.g, "attr3",       value = attr3[,1])
# mails_caliopen.important.g <- set_vertex_attr(mails_caliopen.important.g, "attr4",       value = attr4[,1])

#############################################################"" Igraph  ####################################################""""

mails_caliopen.important.g <- graph_from_data_frame(mails_caliopen.important, directed=F)
mails_caliopen.important.g <- graph_from_adjacency_matrix(as_adjacency_matrix(mails_caliopen.important.g), mode = "undirected", weighted = TRUE)
mails_caliopen.important.g <- simplify(mails_caliopen.important.g, remove.multiple = TRUE, remove.loops = TRUE, edge.attr.comb = igraph_opt("edge.attr.comb"))
mails_caliopen.important.g <- delete.vertices(mails_caliopen.important.g, which(degree(mails_caliopen.important.g) < 1))

clique <- largest.cliques(mails_caliopen.important.g)
lk <- unlist(adjacent_vertices(mails_caliopen.important.g, clique[[1]], mode = "all"))
lk2 <- unlist(adjacent_vertices(mails_caliopen.important.g, lk, mode = "all"))
lk3 <- unlist(adjacent_vertices(mails_caliopen.important.g, lk2, mode = "all"))
mails_caliopen.important.g <- induced.subgraph(graph=mails_caliopen.important.g,vids=lk2)

# pdf("../bin/graph.pdf")
# plot_aghiles(mails_caliopen.important.g)
# dev.off()

length(V(mails_caliopen.important.g))
length(E(mails_caliopen.important.g))

diameter(mails_caliopen.important.g)
edge_density(mails_caliopen.important.g)
modularity(mails_caliopen.important.g)
wtc <- cluster_walktrap(mails_caliopen.important.g)
modularity(wtc)
mean(degree(mails_caliopen.important.g))
mean_distance(mails_caliopen.important.g)

########################################################################################################################"

set.seed(2016)
g <- mails_caliopen.important.g

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

###########################

library(network)
mails_caliopen.important.net <- network(mails_caliopen.important, matrix.type ="edgelist", weighted = TRUE , directed=FALSE)
# Centrality
for (i in 1:length_cent){
  mails_caliopen.important.net %v% names(calc_cent)[i] <- calc_cent[[i]]
}

##################

nn <- vcount(mails_caliopen.important.g)
p_cum1 <- propagation2(0.8,25); p_cum2 <- propagation2(0.6,25); p_cum3 <- propagation2(0.4,25); p_cum4 <- propagation2(0.2,25);
results2.df <- rbind(cbind(0.8, p_cum1), cbind(0.6, p_cum2), cbind(0.4, p_cum3), cbind(0.2, p_cum4)) %>% as.data.frame
results2.df$`Time` <- c(1:length(p_cum1),1:length(p_cum2),1:length(p_cum3),1:length(p_cum4))
# 
# fil <- tempfile("data")
# # the file data contains x, two rows, five cols
# # 1 3 5 7 9 will form the first row
# write(t(results2.df), fil)
# if(interactive()) file.show(fil)
# unlink(fil) # tidy up
# write(results2.df, file = "results",
#       ncolumns = if(is.character(results2.df)) 1 else 5,
#       append = FALSE, sep = " ")

p <- ggplot(results2.df, aes(x=`Time`, y=p_cum1, colour=factor(V1))) + geom_line()+ geom_point() + ylab("CDF of infected users") +labs(colour="Trust level")
write.csv(p$data, file = "MyData.csv")
############################### Trust and diffusion metrics

# How trust changes deffusion process
pmal = ecdf(calc_cent$`Diffusion Degree`)(calc_cent$`Diffusion Degree`)
r1 <- rnorm(nn*2); r2 <- rexp(nn*2); r3 <- rweibull(nn*2,shape = 1); r4 <- rlnorm(nn*2); r5 <- rgamma(nn*2, shape = 1); r6 <- rlogis(nn*2); r7 <- rcauchy(nn*2); r8 <- rbinom(nn*2, size=2, prob = 0.5); r9 <- rtriang(nn*2)
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
p2 <- ggplot(results.df, aes(x=`Time`, y=V2, colour=factor(V1))) + geom_line()+ geom_point() + ylab("Contagion process convergence") +labs(colour="Trust level")
write.csv(p2$data, file = "MyData2.csv")
p2

library(Hmisc)
layout(rbind(1:2))
dr1 <- ecdf(unlist(propagation(wgtmat, 0.8, op, 25)[1 ]))(unlist(propagation(wgtmat, 0.8, op, 25)[1 ]))
plot_aghiles(mails_caliopen.important.g, dr1, , "", "", "")
dr2 <- ecdf(unlist(propagation(wgtmat, 0.8, op, 25)[20]))(unlist(propagation(wgtmat, 0.8, op, 25)[20]))
plot_aghiles(mails_caliopen.important.g, dr2, , "", "", "")

propag <- propagation(wgtmat, 0.8, op, 25)
for (i in c(1:2)) {
  png(cbind(i,".png"), width = 1888, height = 1391)
  dr1 <- ecdf(unlist(propag[i]))(unlist(propag[i]))
  plot_aghiles(mails_caliopen.important.g, dr1)
  dev.off()
}

i <- 1
png(cbind(i,".png"), width = 1888, height = 1391)
dr1 <- ecdf(unlist(propag[i]))(unlist(propag[i]))
plot_aghiles(mails_caliopen.important.g, dr1)
dev.off()

i <- 25
png(cbind(i,".png"), width = 1888, height = 1391)
dr1 <- ecdf(unlist(propag[i]))(unlist(propag[i]))
plot_aghiles(mails_caliopen.important.g, dr1)
dev.off()

ggplot(results2.df, aes(x=`Time`, y=p_cum1, colour=factor(V1))) + geom_line()+ geom_point() + ylab("CDF of infected users") +labs(colour="Trust level")
ggplot(results.df, aes(x=`Time`, y=V2, colour=factor(V1))) + geom_line()+ geom_point() + ylab("Contagion process convergence") +labs(colour="Trust level")

library(gridExtra)
library(grid)
d <- cbind("Technical index", "Social index")
d1 <- cbind(op[1:3], dr1[1:3])
d2 <- rbind(d, d1)
grid.table(d2)

##################################################################### Centrality #########################################
# c(11,6,19,25,28,30,31,34,40,45) 15,14,4,13,20,26,35,5
# centrality
centrality <- proper_centralities(as.directed(mails_caliopen.important.g))
cent_name <- c(2,3,8,9,10,11,12,17,18,21,22,23,24,27,29,36,37,41,42,43)
calc_cent <- sapply(cent_name, function(x) {
  print(x)
  calculate_centralities(as.directed(mails_caliopen.important.g), include = centrality[x])
})
# ego_size 
calc_cent$Ego <- ego_size(mails_caliopen.important.g)
# diversity
calc_cent$Diversity <- as.numeric(sub(NaN,0,sub(Inf,0,sub(-Inf,0,diversity(mails_caliopen.important.g)))))
# strength
calc_cent$Strength <- strength(mails_caliopen.important.g)
# subgraph
# calc_cent$Subgraph <- abs(subgraph_centrality(mails_caliopen.important.g))
# # power_centrality
# calc_cent$Power <- abs(power_centrality(mails_caliopen.important.g))

# # similarity
# similarity <- similarity(mails_caliopen.important.g)
# calc_cent$`Local Similarity` <- signif(similarity[1,], 1)
# # Mutual friends
# cocitation <- cocitation(mails_caliopen.important.g, V(mails_caliopen.important.g))
# calc_cent$`Local Mutual friends` <- signif(cocitation[1,], 1)
# # Distance Measures
# distances <- distances(mails_caliopen.important.g, V(mails_caliopen.important.g))
# calc_cent$`Local Distances` <- signif(distances[1,], 1)

summary(calc_cent)
length(calc_cent)

#####################################################################" Proba ###################################################"
library('Hmisc')

pmal = calc_prob[[8]]$empirical * ptechnique
pv = 1 - (1-pmal)^calc_cent[[7]]
psocial = pv * calc_prob[[12]]$empirical
psocial

hist(psocial)

calc_prob[[12]]$empirical

plot_aghiles(mails_caliopen.important.g, psocial, , "", "", names(calc_cent)[i])

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
  tryCatch({fit$binom  <- fitcdist(dat,dist_name[10], size=2, prob = 0.5)} ,error = function(error_condition)                            {})
  calc_dist[[i]] <- fit
}

calc_prob <- list()
for (i in 1:length_cent){
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
  tryCatch({plot_aghiles(mails_caliopen.important.g, calc_prob[[i]]$empirical, , "", "", names(calc_cent)[i])}   ,error = function(error_condition) {})
}
dev.off()

# pdf("../bin/centralities_graph_cdf.pdf")
# layout(rbind(1:3, 4:6))
# for (i in 1:length_cent){
#   for (j in 1:length_dist){
#     print(i)
#     par(mar=c(1,1,3,1))
#     tryCatch({plot_aghiles(mails_caliopen.important.g, calc_prob[[i]][[j]], , "", "", c(names(calc_cent)[i], dist_name[j]))}   ,error = function(error_condition) {})
#   }
# }
# dev.off()

# plot CDF
pdf("../bin/centralities_cdf.pdf")
layout(rbind(1:2, 3:4))
lapply(seq_along(calc_dist), function(i) {
  tryCatch({cdfcomp(calc_dist[[i]], yscale=TRUE, xlab=names(calc_cent)[i])}   ,error = function(error_condition) {})
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
  if (x==1 || x==35)
    print(x)
  else{
    par(mar=c(1,1,3,1))
    plot_aghiles(mails_caliopen.important.g, calc_cent[[x]], , "", "", c(x,names(calc_cent)[x]))
  }
})
dev.off()

########################################################### Community ###########################################################"

communities <- list()
### cluster_edge_betweenness
ceb <- cluster_edge_betweenness(mails_caliopen.important.g,weights = NULL)
communities$Edge_betweenness <- ceb
### cluster_fast_greedy
cfg <- cluster_fast_greedy(mails_caliopen.important.g)
communities$Fast_greedy <- cfg
### cluster_leading_eigen
cle <- cluster_leading_eigen(mails_caliopen.important.g)
communities$Leading_eigenvector <- cle
### cluster_spinglass
cs <- cluster_spinglass(mails_caliopen.important.g, spins=10)
communities$Spinglass <- cs
### cluster_walktrap
cw <- cluster_walktrap(mails_caliopen.important.g)
communities$Walktrap <- cw
### cluster_label_prop
clp <- cluster_label_prop(mails_caliopen.important.g)
communities$Label_propagation <- clp
# cluster_louvain
cl <- cluster_louvain(mails_caliopen.important.g)
communities$Louvain <- cl

membership <- lapply(lapply(communities, membership), as.numeric)

#####################################################################""  PCA   ################################################"

pdf("bin/communities_pca.pdf")
pca_centralities(membership)
dev.off()

################################################################### Correlations  ############################################"

pdf("bin/communities_corr1.pdf")
ggcorr(
  as.data.frame(membership),name = expression(rho),geom = "circle",
  max_size=10,min_size=2,size=3,hjust=0.9,nbreaks=6,angle=-45,palette = "PuOr"
)
dev.off()

pdf("bin/communities_corr2.pdf")
ggpairs(as.data.frame(membership))
dev.off()

# Association
# visualize_association(membership[[1]], membership[[5]])

##############################################################" Plot Community ##################################################
pdf("bin/communities_graph.pdf")
layout(rbind(1:4, 5:8))
lapply(seq_along(communities), function(x) {
  name <- paste(names(communities)[x], "\n", "Modularity:", round(modularity(communities[[x]]), 4))
  par(mar=c(1,1,3,1))
  plot_djoudi(mails_caliopen.important.g, membership(communities[[x]]), main = name)
})
dev.off()

###############################################################" Technical Edge #####################################################"

mails_caliopen.important.g <- set_edge_attr  (mails_caliopen.important.g, "date",        value = as.character.Date(mails_caliopen.important$Date))
mails_caliopen.important.g <- set_edge_attr  (mails_caliopen.important.g, "content",     value = as.character(mails_caliopen.important$Content))
mails_caliopen.important.g <- set_edge_attr  (mails_caliopen.important.g, "cc",          value = as.character(mails_caliopen.important$Cc))
mails_caliopen.important.g <- set_edge_attr  (mails_caliopen.important.g, "ssl",         value = attr4[,1])

###############################################################" Technical Vertex #####################################################"

domain   <- sub("#","extern", sub("[^#].*","intern", sub(".*@.*","#", V(mails_caliopen.important.g)$name)))
content <- lapply(V(mails_caliopen.important.g), function(x) { E(mails_caliopen.important.g)[from(x)][1]$content })
cc <- lapply(V(mails_caliopen.important.g), function(x) { E(mails_caliopen.important.g)[to(x)][1]$cc })
ssl <- lapply(V(mails_caliopen.important.g), function(x) { E(mails_caliopen.important.g)[from(x)][1]$ssl })

mails_caliopen.important.g <- set_vertex_attr(mails_caliopen.important.g, "domain",      value = domain)
mails_caliopen.important.g <- set_vertex_attr(mails_caliopen.important.g, "content",      value = content)
mails_caliopen.important.g <- set_vertex_attr(mails_caliopen.important.g, "cc",      value = cc)
mails_caliopen.important.g <- set_vertex_attr(mails_caliopen.important.g, "ssl",      value = ssl)

####################################################################" Plot Edge #####################################################""

# # Content
# plot_aghiles(mails_caliopen.important.g, unlist(V(mails_caliopen.important.g)$content),E(mails_caliopen.important.g)$content,"","", "Content")
# # SSL
# plot_aghiles(mails_caliopen.important.g, unlist(V(mails_caliopen.important.g)$ssl),E(mails_caliopen.important.g)$ssl,"", "", "SSL")
# # Cc
# plot_aghiles(mails_caliopen.important.g, unlist(V(mails_caliopen.important.g)$cc),E(mails_caliopen.important.g)$cc,"","", "Cc")

####################################################################" Plot Vertex #####################################################""

# Domain
plot_djoudi(mails_caliopen.important.g, V(mails_caliopen.important.g)$domain,,"","", "Domain")
# Content
plot_djoudi(mails_caliopen.important.g, unlist(V(mails_caliopen.important.g)$content), ,"","", "Content")
# SSL
plot_djoudi(mails_caliopen.important.g,unlist(V(mails_caliopen.important.g)$ssl), ,"", "", "SSL(arbitrary)")
# Cc
plot_djoudi(mails_caliopen.important.g, unlist(V(mails_caliopen.important.g)$cc),,"","", "Cc")
# Trust path
plot_edge(mails_caliopen.important.g, ,unlist(E(mails_caliopen.important.g)$ssl),"","", "Trust path (arbitrary)")


# similarity
layout(rbind(1:3))
similarity <- similarity(mails_caliopen.important.g)
lapply(c(1), function(i) {
  plot_aghiles(mails_caliopen.important.g,
               node_data = signif(similarity[i,], 1),
               main = "local similarity", 
               index = i)
})
# Mutual friends
cocitation <- cocitation(mails_caliopen.important.g, V(mails_caliopen.important.g))
lapply(c(1), function(i) {
  plot_aghiles(mails_caliopen.important.g,
               node_data = signif(cocitation[i,], 1),
               main = "Local cocitation", 
               index = i)
})
# Distance Measures
# radius(mails_caliopen.important.g, mode = c("in"))
# diameter(mails_caliopen.important.g, directed = TRUE)
distances <- distances(mails_caliopen.important.g, V(mails_caliopen.important.g))
lapply(c(1), function(i) {
  plot_aghiles(mails_caliopen.important.g,
               node_data = signif(distances[i,], 1),
               main = "Local distances", 
               index = i)
})

