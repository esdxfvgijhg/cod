#!/usr/bin/env Rscript
# setwd("enron")
set.seed(2016)

library("CINNA")
library("igraph")
library("GGally")
source("script/setup.r")
library("fitdistrplus")
library("mc2d")  ## needed for dtriang
library("formattable")
library("ggplot2")

mails <- read.csv(file="../res/mails_enron.csv", header=TRUE, sep=",")
important.people <- c("louise.kitchen", "mike.grigsby", "greg.whalley", "scott.neal", "kenneth.lay", "harry.arora", "bill.williams")
mails.important <- subset(mails, From %in% important.people | To %in% important.people)
mails.important.g <- graph_from_data_frame(mails.important, directed=F)
mails.important.g <- graph_from_adjacency_matrix(as_adjacency_matrix(mails.important.g), mode = "undirected", weighted = TRUE)
mails.important.g <- simplify(mails.important.g, remove.multiple = TRUE, remove.loops = TRUE, edge.attr.comb = igraph_opt("edge.attr.comb"))


####################################################################" Centrality #########################################"""

diameter(mails.important.g)
edge_density(mails.important.g)
modularity(mails.important.g)
wtc <- cluster_walktrap(mails.important.g)
modularity(wtc)
mean(degree(mails.important.g))
mean_distance(mails.important.g)

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

##############################################################" Plot Community ##################################################
pdf("../bin/communities_graphxx.pdf")
layout(rbind(1:4, 5:8))
lapply(seq_along(communities), function(x) {
  name <- paste(names(communities)[x], "\n", "Modularity:", round(modularity(communities[[x]]), 4))
  par(mar=c(1,1,3,1))
  plot_djoudi(mails.important.g, membership(communities[[x]]), main = name)
})
dev.off()

###############################################################" Set Edge attributes #####################################################"

mails.important.g <- set_edge_attr  (mails.important.g, "date",        value = as.character.Date(mails.important$Date))
mails.important.g <- set_edge_attr  (mails.important.g, "content",     value = as.character(mails.important$Content))
mails.important.g <- set_edge_attr  (mails.important.g, "cc",          value = as.character(mails.important$Cc))
mails.important.g <- set_edge_attr  (mails.important.g, "ssl",         value = attr4[,1])

###############################################################" Set Vertex attributes #####################################################"

domain   <- sub("#","extern", sub("[^#].*","intern", sub(".*@.*","#", V(mails.important.g)$name)))
content <- lapply(V(mails.important.g), function(x) { E(mails.important.g)[from(x)][1]$content })
cc <- lapply(V(mails.important.g), function(x) { E(mails.important.g)[to(x)][1]$cc })
ssl <- lapply(V(mails.important.g), function(x) { E(mails.important.g)[from(x)][1]$ssl })

mails.important.g <- set_vertex_attr(mails.important.g, "domain",      value = domain)
mails.important.g <- set_vertex_attr(mails.important.g, "content",      value = content)
mails.important.g <- set_vertex_attr(mails.important.g, "cc",      value = cc)
mails.important.g <- set_vertex_attr(mails.important.g, "ssl",      value = ssl)


####################################################################" Plot Edge #####################################################""

# Content
 plot_aghiles(mails.important.g, unlist(V(mails.important.g)$content),E(mails.important.g)$content,"","", "Content")
# SSL
 plot_aghiles(mails.important.g, unlist(V(mails.important.g)$ssl),E(mails.important.g)$ssl,"", "", "SSL")
# Cc
 plot_aghiles(mails.important.g, unlist(V(mails.important.g)$cc),E(mails.important.g)$cc,"","", "Cc")

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



####################################################################" Dependant cetrality #####################################################""

# similarity
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






