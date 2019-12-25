#!/usr/bin/env Rscript

source("script/read.r")

important.people <- c("louise.kitchen", "mike.grigsby", "greg.whalley", "scott.neal", "kenneth.lay", "harry.arora", "bill.williams")
mails.important <- subset(mails, From %in% important.people | To %in% important.people)

attr1 <- as.matrix(read.table("data/s100-attr1.dat"))
attr2 <- as.matrix(read.table("data/s100-attr2.dat"))
attr3 <- as.matrix(read.table("data/s100-attr3.dat"))
attr4 <- as.matrix(read.table("data/s100-attr4.dat"))

## Igraph
library(igraph)
source("script/setup.r")

mails.important.g <- graph_from_data_frame(mails.important, directed=F)
mails.important.g <- graph_from_adjacency_matrix(as_adjacency_matrix(mails.important.g), mode = "undirected", weighted = TRUE)
mails.important.g <- simplify(mails.important.g, remove.multiple = TRUE, remove.loops = TRUE, edge.attr.comb = igraph_opt("edge.attr.comb"))

mails.important.g <- set_vertex_attr(mails.important.g, "attr1",       value = attr1[,1])
mails.important.g <- set_vertex_attr(mails.important.g, "attr2",       value = attr2[,1])
mails.important.g <- set_vertex_attr(mails.important.g, "attr3",       value = attr3[,1])
mails.important.g <- set_vertex_attr(mails.important.g, "attr4",       value = attr4[,1])

mails.important.g <- set_edge_attr  (mails.important.g, "date",        value = as.character.Date(mails.important$Date))
mails.important.g <- set_edge_attr  (mails.important.g, "content",     value = as.character(mails.important$Content))
mails.important.g <- set_edge_attr  (mails.important.g, "cc",          value = as.character(mails.important$Cc))

domain   <- sub("#","extern", sub("[^#].*","intern", sub(".*@.*","#", V(mails.important.g)$name)))
content <- lapply(V(mails.important.g), function(x) { E(mails.important.g)[from(x)][1]$content })
cc <- lapply(V(mails.important.g), function(x) { E(mails.important.g)[to(x)][1]$cc })

mails.important.g <- set_vertex_attr(mails.important.g, "domain",      value = domain)
mails.important.g <- set_vertex_attr(mails.important.g, "content",      value = content)
mails.important.g <- set_vertex_attr(mails.important.g, "cc",      value = cc)

# d <- E(mails.important.g)[from(V(mails.important.g)["greg.whalley"])]$content
# d
length(c(rep(NA, vcount(mails.important.g))))
# mails.important.g <- delete.vertices   (mails.important.g, which (degree(mails.important.g, mode="all") < 3))
# mails.important.g <- delete.edges(mails.important.g, which(E(mails.important.g)$weight < 10))
# mails.important.g <- delete.vertices(mails.important.g, which(ego_size(mails.important.g) %in% sort(ego_size(mails.important.g), decreasing=T)[c(1:10)]))
# vertex_attr(mails.important.g, "attr1")
# vertex_attr(mails.important.g, "attr2")
# vertex_attr(mails.important.g, "attr3")
# vertex_attr(mails.important.g, "attr4")
# vertex_attr(mails.important.g, "domain")
# edge_attr  (mails.important.g, "date", index = E(mails.important.g))
# edge_attr  (mails.important.g, "date", index = which (E(mails.important.g)$date < as.Date("2001-01-01")))
# edge_attr  (mails.important.g, "content_type", index = which (E(mails.important.g)$content_type == E(mails.important.g)$content_type))
# edge_attr  (mails.important.g, "fromDomain", index = which (E(mails.important.g)$fromDomain == E(mails.important.g)$fromDomain))

# plot_aghiles(mails.important.g, index = which (V(mails.important.g)$name %in% important.people))

# library("VBLPCM")
# library(intergraph)
# # library("rgl")
# # plot3d(data)
# 
# l <- fruchterman_reingold(asNetwork(mails.important.g), D=2, steps=1e3)
# plot(mails.important.g, edge.arrow.mode=0, layout=l, vertex.label=NA, edge.label=NA, main=16, vertex.size=2)
# 
# library(igraph) 
# net <- asNetwork(mails.important.g)
# # network.vertex.names(net)<-igraph::get.vertex.attribute(g,"id")   ### Add in the names
# detach("package:igraph")
# 
# v.start <- vblpcmstart(net,G=5,d=2)
# plot(v.start)
# v.fit<-vblpcmfit(v.start)                        ### Fit the model to the network, choosing G and d
# plot(v.fit)                                                       ### Plot it
# vblpcmgroups(v.fit)                                               ### Show the point estimates of the groups
# v.fit


##############
centralities <- list()
# degIn
degIn <-degree(mails.important.g, mode = c("in"), loops = F, normalized = T)
centralities$DegreeIn <- degIn
# degOut
degOut <-degree(mails.important.g, mode = c("out"), loops = F, normalized = T)
centralities$DegreeOut <- degOut
# betweenness
betweenness <- abs(betweenness(mails.important.g, directed=T, weights=NA))
centralities$Betweenness <- betweenness
# pageRank
pageRank <- abs(page_rank(mails.important.g)$vector)
centralities$PageRank <- pageRank
# hub_score
hs <- abs(hub_score(mails.important.g, weights=NA)$vector)
centralities$Hub <- hs
# authority_score
as <- abs(authority_score(mails.important.g, weights=NA)$vector)
centralities$Authority <- as
# closeness
closeness <- abs(closeness(mails.important.g, mode="all", weights=NA))
centralities$Closeness <- closeness
# eigen
eigen <- abs(eigen_centrality(mails.important.g)$vector)
centralities$Eigen <- eigen
# power_centrality
power_centrality <- abs(power_centrality(mails.important.g))
centralities$Power <- power_centrality
# eccentricity
eccentricity <- eccentricity(mails.important.g)
centralities$Eccentricity <- eccentricity
# radiality
library("Matrix")
library("centiserve")
radiality <- radiality(mails.important.g)
centralities$Radiality <- radiality
# Katz Centrality
katz <- alpha_centrality(mails.important.g)
centralities$Katz <- katz
# constraint
constraint <- constraint(mails.important.g)
centralities$Constraint <- constraint
# strength
strength <- strength(mails.important.g)
centralities$Strength <- strength
# subgraph
subgraph <- abs(subgraph_centrality(mails.important.g))
centralities$Subgraph <- subgraph
# K-core decomposition
coreness <- coreness(mails.important.g, mode="all")
centralities$Coreness <- coreness
# ego
ego_size <- abs(ego_size(mails.important.g))
centralities$Ego <- ego_size
# diversity
diversity <- abs(as.numeric(sub(NaN,0,sub(Inf,0,sub(-Inf,0,diversity(mails.important.g))))))
centralities$Diversity <- diversity

# Homophily, Assortative Mixing, and Similarity
# assortativity
assortativity(mails.important.g, as.numeric(degIn), as.numeric(degIn), directed = TRUE)
# Connectivity
# cohesion
vertex_connectivity(mails.important.g, checks = TRUE)
# adhesion
edge_connectivity(mails.important.g, checks = TRUE)
# Reciprocity and Transitivity
# reciprocity
reciprocity(mails.important.g, ignore.loops = TRUE, mode = c("default", "ratio"))
# transitivity
transitivity(mails.important.g, type = c("undirected"), vids = V(mails.important.g))
# component
class(subcomponent(mails.important.g, 1))

compare(membership(ceb), membership(cfg))

### Comparision of algorithms
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

###############################################################################################################"
                                                        #PLOT
###############################################################################################################"

### Plot everything
layout(rbind(1:3, 4:6))
lapply(seq_along(centralities), function(x) {
  par(mar=c(1,1,3,1))
  plot_aghiles(mails.important.g, signif(centralities[[x]], 1), , "", "", names(centralities)[x])
})

##########
w <- lapply(seq_along(centralities), function(x) {
  sort(centralities[[x]], decreasing = TRUE)[c(1:10)]
})
w

layout(rbind(1:3, 4:6))
sapply(w, function(x) {
  people <- names(x)
  mails.important <- subset(mails, From %in% people | To %in% people)
  tmp.g <- graph_from_data_frame(mails.important, directed=F)
  tmp.g <- graph_from_adjacency_matrix(as_adjacency_matrix(tmp.g), mode = "undirected", weighted = TRUE)
  tmp.g <- simplify(tmp.g, remove.multiple = TRUE, remove.loops = TRUE, edge.attr.comb = igraph_opt("edge.attr.comb"))
  data <- rep(0,vcount(tmp.g))
  data[which (V(tmp.g)$name %in% important.people)] <- 1
  plot_legend_size(tmp.g,data,"","")
})




### Plot everything
layout(rbind(1:4, 5:8))
lapply(seq_along(communities), function(x) {
  name <- paste(names(communities)[x], "\n", "Modularity:", round(modularity(communities[[x]]), 4))
  par(mar=c(1,1,3,1))
  plot_djoudi(mails.important.g, 
              node_data = membership(communities[[x]]), 
              node_titre = "", 
              main = name)
})

layout(rbind(1:4, 5:8))
# Domain
plot_djoudi(mails.important.g, V(mails.important.g)$domain,,"","", "Domain")
# SSL
plot_djoudi(mails.important.g,V(mails.important.g)$attr4, ,"", "", "SSL")
# Content
plot_djoudi(mails.important.g, , E(mails.important.g)$content,"","", "Content")
# Cc
plot_djoudi(mails.important.g, , E(mails.important.g)$cc,"","", "Cc")

# Behavioral metrics
communication_level <- V(mails.important.g)$attr1
plot_djoudi(mails.important.g, communication_level, ,"","", "Communication level")
#
trust_level <- V(mails.important.g)$attr2
plot_aghiles(mails.important.g, V(mails.important.g)$attr2, ,"", "", "Trust level")
#

# Technical metrics
# edge_betweenness <- edge_betweenness(mails.important.g, directed=F, weights=NA)
# plot_aghiles(mails.important.g, , floor(edge_betweenness), "A", "B", "edge_betweenness", which (V(mails.important.g)$name %in% important.people))

# similarity
layout(rbind(1:2))
similarity <- similarity(mails.important.g)
lapply(c(1), function(i) {
  plot_aghiles(mails.important.g,
               node_data = signif(similarity[i,], 1),
               main = "Similarity", 
               index = i)
})
# Mutual friends
cocitation <- cocitation(mails.important.g, V(mails.important.g))
lapply(c(1), function(i) {
  plot_djoudi(mails.important.g,
               node_data = signif(cocitation[i,], 1),
               main = "Cocitation", 
               index = i)
})
# Distance Measures
radius(mails.important.g, mode = c("in"))
diameter(mails.important.g, directed = TRUE)
distances <- distances(mails.important.g, V(mails.important.g))
lapply(c(1), function(i) {
  plot_aghiles(mails.important.g,
              node_data = signif(distances[i,], 1),
              main = "Distances", 
              index = i)
})

##########
library(GGally, quietly = TRUE)
ggpairs(as.data.frame(centralities))
ggpairs(as.data.frame(centralities), mapping = aes(color = as.character(centralities$Ego), alpha = .5))

##########
library(GGally, quietly = TRUE)
ggpairs(as.data.frame(membership), mapping = aes(color = as.character(membership$Edge_betweenness), alpha = .5))
ggpairs(as.data.frame(membership), mapping = aes(color = as.character(membership$Fast_greedy), alpha = .5))
ggpairs(as.data.frame(membership), mapping = aes(color = as.character(membership$Leading_eigenvector), alpha = .5))
ggpairs(as.data.frame(membership), mapping = aes(color = as.character(membership$Spinglass), alpha = .5))
ggpairs(as.data.frame(membership), mapping = aes(color = as.character(membership$Walktrap), alpha = .5))
ggpairs(as.data.frame(membership), mapping = aes(color = as.character(membership$Label_propagation), alpha = .5))
ggpairs(as.data.frame(membership), mapping = aes(color = as.character(membership$Louvain), alpha = .5))
