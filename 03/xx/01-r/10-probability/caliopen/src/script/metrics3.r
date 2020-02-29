# Density
edge_density(g, loops=F)

# Reciprocity
reciprocity(g)
dyad_census(g)

# Transitivity
transitivity(g, type="global") # g is treated as an undirected network
transitivity(as.undirected(g, mode="collapse")) # same as above
tra <- transitivity(g, type="local")

triad_census(g) # for directed networks

# Diameter
diameter(g, directed=F, weights=NA)
diam <- get_diameter(g, directed=T)
diam
as.vector(diam)

# Node degree
deg <- degree(g, mode="all")
plot(g, vertex.size=deg, edge.size=deg*90, edge.label=NA, vertex.label=NA)

# Degree distribution
deg.dist <- degree_distribution(g, cumulative=T, mode="all")

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
hs
as <- authority_score(g, weights=NA)$vector
as
par(mfrow=c(1,2))
plot(g, vertex.size=hs*50, main="Hubs", edge.label=NA, vertex.label=NA)
plot(g, vertex.size=as*30, main="Authorities", edge.label=NA, vertex.label=NA)

# Distances and paths
mean_distance(g, directed=F)
mean_distance(g, directed=T)

distances(g) # with edge weights
distances(g, weights=NA) # ignore weights

dist.from.NYT <- distances(g, v=V(g), to=V(g), weights=NA)
dist.from.NYT

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
sapply(largest_cliques(g), length) # clique sizes


vcol <- rep("grey80", vcount(g))
vcol[unlist(largest_cliques(g))] <- "gold"
plot(as.undirected(g), vertex.color=vcol, edge.label=NA, vertex.label=NA)

# 8.2 Community detection

ceb <- cluster_edge_betweenness(g)
ceb
dendPlot(ceb, mode="hclust")

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

