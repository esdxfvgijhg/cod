library(ergm)
library(sna) 
library(statnet)
library(network)

# 1) Create data
friend.t1 <- as.matrix(read.table("../../../res/s50-network1.dat"))
friend.t2 <- as.matrix(read.table("../../../res/s50-network2.dat"))
friend.t3 <- as.matrix(read.table("../../../res/s50-network3.dat"))
friend.t123 <- array(c(friend.t1, friend.t2, friend.t3), dim=c(100, 100, 3))

drink <- as.matrix(read.table("../../../res/s50-alcohol.dat"))
smoke <- as.matrix(read.table("../../../res/s50-smoke.dat")) 
drugs <- as.matrix(read.table("../../../res/s50-drugs.dat")) 
sport <- as.matrix(read.table("../../../res/s50-sport.dat"))

fmh.net <- network(cbind(friend.t1, friend.t2), matrix.type ="adjacency", weighted = TRUE , directed=FALSE)

# detach("package:igraph")
set.vertex.attribute(fmh.net, "drink", drink[,1])
get.vertex.attribute(fmh.net, "drink")
set.vertex.attribute(fmh.net, "smoke", smoke[,1])
get.vertex.attribute(fmh.net, "smoke")
set.vertex.attribute(fmh.net, "drugs", drugs[,1])
get.vertex.attribute(fmh.net, "drugs")
set.vertex.attribute(fmh.net, "sport", sport[,1])
get.vertex.attribute(fmh.net, "sport")

# plot(net, edge.label=NA, vertex.label=c(1:100), vertex.size=6)
plot(fmh.net)
plot(fmh.net, vertex.col='drink')
plot(fmh.net, vertex.col='smoke')
plot(fmh.net, vertex.col='drugs')
plot(fmh.net, vertex.col='sport')

# A simple model that includes just the edge (density) parameter:
fmh.mod.1 <- ergm(fmh.net ~ edges)
summary(fmh.mod.1)
fmh.mod.2 <- ergm(fmh.net ~ edges + nodematch("drink"))
summary(fmh.mod.2)
fmh.mod.3 <- ergm(fmh.net ~ edges + nodematch("drink", diff=T))
summary(fmh.mod.3)
fmh.mod.4 <- ergm(fmh.net ~ edges + nodematch("drink") + nodematch("smoke") + nodematch("drugs"))
summary(fmh.mod.4)
fmh.mod.5 <- ergm(fmh.net ~ edges + nodemix("smoke"))
summary(fmh.mod.5)
fmh.mod.6 <- ergm(fmh.net ~ edges + nodematch("drink", diff = T) + nodefactor("sport"))
summary(fmh.mod.6)
fmh.mod.7 <- ergm(fmh.net ~ edges + nodecov("drink") + nodematch("drugs"))
summary(fmh.mod.7)
fmh.mod.8 <- ergm(fmh.net ~ edges + absdiff("drink") + nodematch("drugs"))
summary(fmh.mod.8)

table(fmh.net %v% "drugs")  			# Check out race frequencies
mixingmatrix(fmh.net, "drugs")   # Check out # of links between/within groups

# Simulating networks based on a model
fmh.mod.8.sim <- simulate(fmh.mod.8, nsim=15)
summary(fmh.mod.8.sim)
fmh.mod.8.sim[[15]]

# Goodnes of Fit and MCMC diagnostics
fmh.mod.8.gof <- gof(fmh.mod.8 ~ degree) # goodness of fit for degree distribution
fmh.mod.8.gof # Take a look at the observed & simulated values
plot(fmh.mod.8.gof) # plot the observed & simulated values

mcmc.diagnostics(fmh.mod.3)

###################################################################################  Data 2

data(florentine)
flobusiness
flomarriage

# ergm(YourNetwork ~ Signature1 + Signature2 + ...) 
flo.mar.1 <- ergm(flomarriage ~ edges)
summary(flo.mar.1)
flo.mar.2 <- ergm(flomarriage ~ edges + triangles)
summary(flo.mar.2)
flo.mar.3 <- ergm(flobusiness ~ edges + edgecov(flomarriage))
summary(flo.mar.3)
flo.mar.4 <- ergm(flomarriage ~ edges + nodecov("wealth"))
summary(flo.mar.4) # Take a look at the model

# Simulating networks based on a model
flo.mar.1.sim <- simulate(flo.mar.1, nsim=15)
summary(flo.mar.1.sim)
# We can access any of them and take a look at it:
flo.mar.1.sim[[15]]

# Goodnes of Fit and MCMC diagnostics
flo.mar.4.gof <- gof(flo.mar.4 ~ degree) # goodness of fit for degree distribution
flo.mar.4.gof # Take a look at the observed & simulated values
plot(flo.mar.4.gof) # plot the observed & simulated values

flo.mar.4.gof2 <- gof(flo.mar.4 ~ distance) # gof based on 20 simulated nets
summary(flo.mar.4.gof2)
plot(flo.mar.4.gof2)

mcmc.diagnostics(flo.mar.2)

