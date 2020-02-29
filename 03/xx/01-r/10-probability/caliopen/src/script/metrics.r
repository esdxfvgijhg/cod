
g <- simplify(g, remove.multiple = F, remove.loops = T)

layouts <- grep("^layout_", ls("package:igraph"), value=TRUE)[-1]
# Remove layouts that do not apply to our graph.
layouts <- layouts[!grepl("bipartite|merge|norm|sugiyama|tree", layouts)]
par(mfrow=c(3,3), mar=c(1,1,1,1))
for (layout in layouts) {
  print(layout)
  l <- do.call(layout, list(g))
  plot(g, edge.arrow.mode=0, layout=l, main=layout, edge.label=NA, vertex.label=NA)
}

plot(g, vertex.shape="none", vertex.label=V(g),
     vertex.label.font=2, vertex.label.color="gray40",
     vertex.label.cex=.7, edge.color="gray85")

hist(E(g)$weight)
mean(E(g)$weight)
sd(E(g)$weight)

cut.off <- mean(E(g)$weight)
g <- delete_edges(g, E(g)[weight<cut.off])
plot(g, edge.label=NA, vertex.label=NA)

# Density
edge_density(g, loops=F)

# Reciprocity
reciprocity(g)
dyad_census(g)

# Transitivity
transitivity(g, type="global") # g is treated as an undirected network
transitivity(as.undirected(g, mode="collapse")) # same as above
tra <- transitivity(g, type="local")
plot(g, edge.label=NA, vertex.label=tra)
plot_legend_color(g,tra,"")

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
# E(g, path=diam) finds edges along a path, here 'diam'
plot(g, vertex.color=vcol, edge.color=ecol, edge.arrow.mode=0, edge.label=NA, vertex.label=NA)

# Node degree
deg <- degree(g, mode="all")
plot(g, vertex.size=deg, edge.size=deg*90, edge.label=NA, vertex.label=NA)

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

V(g)

dist.from.NYT <- distances(g, v=V(g), to=V(g), weights=NA)
dist.from.NYT
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
sapply(largest_cliques(g), length) # clique sizes


vcol <- rep("grey80", vcount(g))
vcol[unlist(largest_cliques(g))] <- "gold"
plot(as.undirected(g), vertex.color=vcol, edge.label=NA, vertex.label=NA)

# 8.2 Community detection

ceb <- cluster_edge_betweenness(g)
ceb
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


%%%%%%%%%%%%%%%%%%%%%%%%
  
  
  
  attr1 <- as.matrix(read.table("data/s100-attr1.dat"))
attr2 <- as.matrix(read.table("data/s100-attr2.dat"))
attr3 <- as.matrix(read.table("data/s100-attr3.dat"))
attr4 <- as.matrix(read.table("data/s100-attr4.dat"))

mails.important <- mails.important

mails.important.g <- graph_from_data_frame(mails.important, directed=F)
mails.important.g <- graph_from_adjacency_matrix(as_adjacency_matrix(mails.important.g), mode = "undirected", weighted = TRUE)

mails.important.g <- set_vertex_attr(mails.important.g, "attr1", value = attr1[,1])
mails.important.g <- set_vertex_attr(mails.important.g, "attr2", value = attr2[,1])
mails.important.g <- set_vertex_attr(mails.important.g, "attr3", value = attr3[,1])
mails.important.g <- set_vertex_attr(mails.important.g, "attr4", value = attr4[,1])
mails.important.g <- set_edge_attr(mails.important.g,"date", value = as.character.Date(mails.important[,3]))
mails.important.g <- set_edge_attr(mails.important.g,"content_type", value = as.character.Date(mails.important[,4]))

# test1 <- delete.edges   (mails.important.g, which (E(mails.important.g)$date > as.Date("2000-01-01")))
# test1 <- delete.vertices(test1, which(degree(test1) < 1))

vertex_attr(mails.important.g, "attr1")
vertex_attr(mails.important.g, "attr2")
vertex_attr(mails.important.g, "attr3")
vertex_attr(mails.important.g, "attr4")
edge_attr  (mails.important.g, "date", index = E(mails.important.g))
edge_attr  (mails.important.g, "date", index = which (E(mails.important.g)$date < as.Date("2001-01-01")))

plot(mails.important.g, edge.label=NA, vertex.label=NA, vertex.size=6)

test1 <- delete.edges   (mails.important.g, which (E(mails.important.g)$date > as.Date("2000-01-01")))
test1 <- delete.vertices(test1, which(degree(test1) < 1))
plot(test1, edge.label=NA, vertex.label=NA, vertex.size=6)

test1 <- delete.edges   (mails.important.g, which (E(mails.important.g)$date > as.Date("2001-01-01")))
test1 <- delete.vertices(test1, which(degree(test1) < 1))
plot(test1, edge.label=NA, vertex.label=NA, vertex.size=6)

test1 <- delete.edges   (mails.important.g, which (E(mails.important.g)$date > as.Date("2002-01-01")))
test1 <- delete.vertices(test1, which(degree(test1) < 1))
plot(test1, edge.label=NA, vertex.label=NA, vertex.size=6)

test1 <- delete.edges   (mails.important.g, which (E(mails.important.g)$date > as.Date("2003-01-01")))
test1 <- delete.vertices(test1, which(degree(test1) < 1))
plot(test1, edge.label=NA, vertex.label=NA, vertex.size=6)

# Technical metrics edgess
trust_level <- V(mails.important.g)$attr2
plot_edge_legend_color(mails.important.g,V(mails.important.g)$attr2,"Trust level")

plot_node_legend_color(mails.important.g,V(mails.important.g)$attr4,"Attr4")

# Technical metrics vertex
mails.important.g <- mails_caliopen.important.g
# Network Metrics vertex
deg <- degree(mails.important.g, mode="all")
plot_legend_size(mails.important.g,deg,"Degree")

centrality <- centr_degree(mails.important.g, mode="in", normalized=T)
plot_legend_size(mails.important.g, centrality$res,"Centrality degree")

centr_clo <- centr_clo(mails.important.g, mode="all", normalized=T)
plot_legend_size(mails.important.g, centr_clo$res,"Centrality closeness")

centr_betw <- centr_betw(mails.important.g, directed=T, normalized=T)
plot_legend_size(mails.important.g, centr_betw$res,"Centrality betweeness")

closeness <- closeness(mails.important.g, mode="all", weights=NA)
plot_legend_size(mails.important.g, closeness,"Closeness")

betweenness <- betweenness(mails.important.g, directed=T, weights=NA)
plot_legend_size(mails.important.g, betweenness,"Betweenness")

edge_betweenness <- edge_betweenness(mails.important.g, directed=T, weights=NA)
plot_legend_size(mails.important.g, edge_betweenness,"Edge betweenness")

cliques <- sapply(cliques(mails.important.g), length)
plot_node_legend_color(mails.important.g, cliques,"Cliques")

# Behavioral metrics vertex
plot_edge_legend_color(mails.important.g, E(mails.important.g)$weight,"Communication level")

plot_legend_color(mails.important.g, V(mails.important.g)$attr4, trust_level, "attr4", "Trust level")

# Behavioral metrics edges






# Hubs and authorities
hs <- hub_score(mails.important.g, weights=NA)$vector
plot_aghiles(mails.important.g, hs,"Hub score")
as <- authority_score(mails.important.g, weights=NA)$vector
plot_legend_size(mails.important.g, centr_betw$res,"Authority score")


# Community detection
ceb <- cluster_edge_betweenness(mails.important.g)
plot(ceb, mails.important.g, edge.label=NA, vertex.label=NA, main= algorithm(ceb))
membership_ceb <- membership(ceb) # community membership for each node
plot_legend_size(mails.important.g, membership_ceb, paste("Membership ", algorithm(ceb)))

# Community detection based on propagating labels
clp <- cluster_label_prop(mails.important.g)
plot(clp, mails.important.g, edge.label=NA, vertex.label=NA, main= algorithm(clp))
membership_clp <- membership(ceb) # community membership for each node
plot_legend_size(mails.important.g, membership_clp, paste("Membership ", algorithm(clp)))

# Community detection based on greedy optimization of modularity
cfg <- cluster_fast_greedy(as.undirected(mails.important.g))
plot(cfg, as.undirected(mails.important.g), edge.label=NA, vertex.label=NA)
plot_legend_size(mails.important.g, cfg$membership, paste("Membership ", algorithm(cfg)))

# K-core decomposition
coreness <- coreness(mails.important.g, mode="all")
plot_node_legend_color(mails.important.g, coreness,"K-core decomposition")


