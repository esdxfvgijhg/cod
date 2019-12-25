plot_legend_color <- function(gnet,data){
  drink_text = brewer.pal(length(levels(as.factor(data))), "Set1")
  plot(gnet, vertex.color=drink_text[data], edge.label=NA, vertex.label=NA, vertex.size=6)
  legend("bottomleft", legend=levels(as.factor(data)), text.col=drink_text, col=drink_text, bty="n", pch=20 , pt.cex=2, cex=1)
}

plot_legend_size <- function(gnet,data){
  plot(gnet, vertex.size=data, edge.size=data, edge.label=NA, vertex.label=NA)
  data_plot <- c(min(data), median(data), max(data))
  legend("topleft",legend=data_plot, bty="n" , pt.cex=data_plot, cex=1)
  a <- legend('topleft', legend=data_plot, pt.cex=data_plot, col='white', pch=1, pt.bg='white', cex=1, bty="n")
  x <- (a$text$x + a$rect$left) / 2
  y <-  a$text$y
  symbols(x, y, circles=data_plot/200,inches=FALSE, add=TRUE, bg='orange')
}

plot(g, edge.label=NA, vertex.label=NA, vertex.size=6)
plot_legend_color(g,V(g)$drink)
plot_legend_color(g,V(g)$smoke)
plot_legend_color(g,V(g)$drugs)
plot_legend_color(g,V(g)$sport)

# Density
edge_density(g, loops=F)

# Reciprocity
reciprocity(g)
dyad_census(g)

# Transitivity
transitivity(g, type="global") # g is treated as an undirected network
transitivity(as.undirected(g, mode="collapse")) # same as above
transitivity(g, type="local")
triad_census(g) # for directed networks

# Diameter
diameter(g, directed=F, weights=NA)
diam <- get_diameter(g, directed=T)
diam
as.vector(diam)

vcol <- rep("gray40", vcount(g))
vcol[diam] <- "gold"
ecol <- rep("gray80", ecount(g))
ecol[E(g, path=diam)] <- "orange"
E(g, path=diam) #finds edges along a path, here 'diam'
plot(g, vertex.color=vcol, edge.color=ecol, edge.arrow.mode=0, edge.label=NA, vertex.label=NA)

# Node degree
deg <- degree(g, mode="all")
plot_legend_size(g,deg)

# Histogram of node degree
hist(deg, breaks=1:vcount(g)-1, main="Histogram of node degree")

# Degree distribution
deg.dist <- degree_distribution(g, cumulative=T, mode="all")
plot( x=0:max(deg), y=1-deg.dist, pch=19, cex=1.2, col="orange",
      xlab="Degree", ylab="Cumulative Frequency")

# Centrality & centralization
# Degree (centrality based on gegree)
degree(g, mode="in")
centr_degree(g, mode="in", normalized=T)
# Closeness (centrality based on distance to others in the graph)
# Inverse of the node’s average geodesic distance to others in the network.
closeness(g, mode="all", weights=NA)
centr_clo(g, mode="all", normalized=T)

# Eigenvector (centrality proportional to the sum of connection centralities)
# Values of the first eigenvector of the graph matrix.
eigen_centrality(g, directed=T, weights=NA)
centr_eigen(g, directed=T, normalized=T)
# Betweenness (centrality based on a broker position connecting others)
# Number of geodesics that pass through the node or the edge.
betweenness(g, directed=T, weights=NA)
edge_betweenness(g, directed=T, weights=NA)
centr_betw(g, directed=T, normalized=T)

# Hubs and authorities
hs <- hub_score(g, weights=NA)$vector
as <- authority_score(g, weights=NA)$vector
par(mfrow=c(1,2))
plot(g, vertex.size=hs*50, main="Hubs", edge.label=NA, vertex.label=NA)
plot(g, vertex.size=as*30, main="Authorities", edge.label=NA, vertex.label=NA)

# Distances and paths
mean_distance(g, directed=F)
mean_distance(g, directed=T)

distances(g) # with edge weights
distances(g, weights=NA) # ignore weights

V(g)

dist.from.NYT <- distances(g, v=V(g), to=V(g), weights=NA)
# Set colors to plot the distances:
oranges <- colorRampPalette(c("dark red", "gold"))
col <- oranges(max(dist.from.NYT)+1)
col <- col[dist.from.NYT+1]
plot(g, vertex.color=col, vertex.label=dist.from.NYT, edge.arrow.size=.6,
     vertex.label.color="white")


news.path <- shortest_paths(g,
                            from = V(g),
                            to = V(g),
                            output = "both") # both path nodes and edges
# Generate edge color variable to plot the path:
ecol <- rep("gray80", ecount(g))
ecol[unlist(news.path$epath)] <- "orange"
# Generate edge width variable to plot the path:
ew <- rep(2, ecount(g))
ew[unlist(news.path$epath)] <- 4
# Generate node color variable to plot the path:
vcol <- rep("gray40", vcount(g))
vcol[unlist(news.path$vpath)] <- "gold"
plot(g, vertex.color=vcol, edge.color=ecol,
     edge.width=ew, edge.arrow.mode=0, edge.label=NA, vertex.label=NA)


inc.edges <- incident(g,
                      V(g), mode="all")
# Set colors to plot the selected edges.
ecol <- rep("gray80", ecount(g))
ecol[inc.edges] <- "orange"
vcol <- rep("grey40", vcount(g))
vcol[V(g)$media=="Wall Street Journal"] <- "gold"
plot(g, vertex.color=vcol, edge.color=ecol, edge.label=NA, vertex.label=NA)


neigh.nodes <- neighbors(g, V(g), mode="out")
# Set colors to plot the neighbors:
vcol[neigh.nodes] <- "#ff9d00"
plot(g, vertex.color=vcol, edge.label=NA, vertex.label=NA)

cocitation(g)

# 8.1 Cliques

cliques(g) # list of cliques
sapply(cliques(g), length) # clique sizes
largest_cliques(g) # cliques with max number of nodes

vcol <- rep("grey80", vcount(g))
vcol[unlist(largest_cliques(g))] <- "gold"
plot(as.undirected(g), vertex.color=vcol, edge.label=NA, vertex.label=NA)


# 8.2 Community detection

ceb <- cluster_edge_betweenness(g)
dendPlot(ceb, mode="hclust")

plot(ceb, g, edge.label=NA, vertex.label=NA)

class(ceb)
length(ceb) # number of communities
membership(ceb) # community membership for each node
modularity(ceb) # how modular the graph partitioning is
crossing(ceb, g) # boolean vector: TRUE for edges across communities

# Community detection based on based on propagating labels
clp <- cluster_label_prop(g)
plot(clp, g, edge.label=NA, vertex.label=NA)

# Community detection based on greedy optimization of modularity
cfg <- cluster_fast_greedy(as.undirected(g))
plot(cfg, as.undirected(g), edge.label=NA, vertex.label=NA)

V(g)$community <- cfg$membership
colrs <- adjustcolor( c("gray50", "tomato", "gold", "yellowgreen"), alpha=.6)
plot(g, vertex.color=colrs[V(g)$community], edge.label=NA, vertex.label=NA)

# 8.3 K-core decomposition
kc <- coreness(g, mode="all")
plot(g, vertex.size=kc*6, vertex.color=colrs[kc], edge.label=NA, vertex.label=NA)

# 9. Assortativity and Homophily
assortativity_nominal(g, V(g), directed=F)

# Matching of attributes across connected nodes more than expected by chance
assortativity(g, V(g), directed=F)

# Correlation of attributes across connected nodes
assortativity_degree(g, directed=F)


