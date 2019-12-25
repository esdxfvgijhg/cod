#!/usr/bin/env Rscript

source("script/read.r")

library("CINNA")
library("igraph")
library("GGally", quietly = TRUE)
source("script/setup.r")

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

#############################################################"" Igraph  ####################################################""""

# mails.g <- graph_from_data_frame(mails, directed=F)
# mails.g <- graph_from_adjacency_matrix(as_adjacency_matrix(mails.g), mode = "undirected", weighted = TRUE)
# mails.g <- simplify(mails.g, remove.multiple = TRUE, remove.loops = TRUE, edge.attr.comb = igraph_opt("edge.attr.comb"))
# 
# plot_aghiles(mails.g)


mails.important.g <- graph_from_data_frame(mails.important, directed=F)
mails.important.g <- graph_from_adjacency_matrix(as_adjacency_matrix(mails.important.g), mode = "undirected", weighted = TRUE)
mails.important.g <- simplify(mails.important.g, remove.multiple = TRUE, remove.loops = TRUE, edge.attr.comb = igraph_opt("edge.attr.comb"))

#####################################################################" Centrality #########################################"""
# c(16,19,28,30,31,34,40)
# centrality
centrality <- proper_centralities(as.directed(mails.important.g))
include <- c(1,2,3,4,5,8,9,10,11,12,13,14,15,17,18,20,21,22,23,24,25,26,27,29,32,35,36,37,41,42,43,45)
calc_cent <- sapply(include, function(x) { 
  print(x) 
  calculate_centralities(as.directed(mails.important.g), include = centrality[x])
})
# ego_size
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
# Distance Measures
distances <- distances(mails.important.g, V(mails.important.g))
calc_cent$Distances <- signif(distances[1,], 1)

summary(calc_cent)

length(calc_cent)

#####################################################################  PCA   ################################################"

pdf("bin/centralities_pca.pdf")
pca_centralities(calc_cent[2:length(calc_cent)])
dev.off()

################################################################### Correlations  ############################################"

pdf("bin/centralities_corr1.pdf")
ggcorr(
  as.data.frame(calc_cent),name = expression(rho),geom = "circle",
  hjust=1,nbreaks=6,angle=-45,palette = "PuOr"
)
dev.off()

pdf("bin/centralities_corr2.pdf", width=33, height=18)
ggpairs(as.data.frame(calc_cent))
dev.off()

# Association
# visualize_association(calc_cent$`Alpha Centrality`, calc_cent$`Burt's Constraint`)

#########################################################  Plot centrality #####################################################""
pdf("bin/centralities_graph2.pdf")
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
plot_edge(mails.important.g, ,unlist(E(mails.important.g)$ssl),"","", "Trust path (arbitrary)")


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
# Distance Measures
# radius(mails.important.g, mode = c("in"))
# diameter(mails.important.g, directed = TRUE)
distances <- distances(mails.important.g, V(mails.important.g))
lapply(c(1), function(i) {
  plot_aghiles(mails.important.g,
               node_data = signif(distances[i,], 1),
               main = "Local distances", 
               index = i)
})

