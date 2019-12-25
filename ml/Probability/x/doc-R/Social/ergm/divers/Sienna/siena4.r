source("script/setup.r")

library(RSiena)
library(igraph)
library(RSienaTest)

# 1) Create data
friend.t1 <- as.matrix(read.table("data/s50-network1.dat"))
friend.t2 <- as.matrix(read.table("data/s50-network2.dat"))
friend.t3 <- as.matrix(read.table("data/s50-network3.dat"))
friend.t123 <- array(c(friend.t1, friend.t2, friend.t3), dim=c(100, 100, 3))

drink <- as.matrix(read.table("data/s50-alcohol.dat"))
smoke <- as.matrix(read.table("data/s50-smoke.dat")) 
drugs <- as.matrix(read.table("data/s50-drugs.dat")) 
sport <- as.matrix(read.table("data/s50-sport.dat")) 

friend.g <- graph_from_adjacency_matrix(cbind(friend.t1, friend.t2), weighted = TRUE, mode="undirected")
friend.g <- set_vertex_attr(friend.g, "drink", value = drink[,1])
friend.g <- set_vertex_attr(friend.g, "smoke", value = smoke[,1])
friend.g <- set_vertex_attr(friend.g, "drugs", value = drugs[,1])
friend.g <- set_vertex_attr(friend.g, "sport", value = sport[,1])
vertex_attr(friend.g, "drink")
vertex_attr(friend.g, "smoke")
vertex_attr(friend.g, "drugs")
vertex_attr(friend.g, "sport")

plot(friend.g, edge.label=NA, vertex.label=c(1:100), vertex.size=6)
plot_legend_color(friend.g,V(friend.g)$drink,"dronk")
plot_legend_color(friend.g,V(friend.g)$smoke,"smoke")
plot_legend_color(friend.g,V(friend.g)$drugs,"drugs")
plot_legend_color(friend.g,V(friend.g)$sport,"sport")

# Network variables (DV)
friend.net <- sienaNet(friend.t123, type="oneMode")
# Behavior variables (DV)
drink.beh <- sienaNet(drink, type = "behavior")
smoke.beh <- sienaNet(smoke, type = "behavior")
drugs.beh <- sienaNet(drugs, type = "behavior")
sport.beh <- sienaNet(sport, type = "behavior")
# Constant covariates (IV)
smoke.cc <- coCovar(smoke[,1])
drink.cc <- coCovar(drink[,1])
drugs.cc <- coCovar(drugs[,1])
sport.cc <- coCovar(sport[,1])
# Varying covariates (IV)
smoke.vc <- varCovar(smoke)  
drink.vc <- varCovar(drink)
drugs.vc <- varCovar(drugs)  
sport.vc <- varCovar(sport)

# 2) DATA SPECIFICATION: combine dependent & independent variables
dat.1 <- sienaDataCreate(friend.net, drink.vc, smoke.cc)
dat.2 <- sienaDataCreate(friend.net, drink.beh, smoke.vc)
# dat.2 <- sienaDataCreate(friend.net, drink.beh, drink.vc)
dat.1
dat.2

# Structural effects
# recip     - reciprocity
# cycle3    - 3-cycles (i->j, j->h, h->i)
# transTrip - transitive triplets (i->j, j->h, i->h)
# nbrDist2  - number of actors at distance 2 (i->j, j->h)
# inPop     - in-degree related popularity effect
#             nodes with high in-degree will get more incoming links.
#             (think preferential attachment, etc.)
# outPop    - out-degree related popularity effect
#             nodes with high out-degree will get more incoming links.
# inAct     - in-degree related activity effect
#             nodes with high in-degree will send more outgoing links.
# outAct    - out-degree related activity effect
#             nodes with high out-degree will send more outgoing links.

# Covariate-related effects
# egoX     - actors with high scores will have more outgoing links
# altX     - actors with high scores will have more incoming links
# sameX    - actors with the same levels on the covariate will be more
#            likely to be connected (typically for categorical vars)
# simX     - actors with similar scores on the covariate will be more
#            likely to be connected (typically for continuous vars)

# Some possible effects to add here include:
# avSim  - average similiarity in behavior between the actor & friends
# totSim - total (summed) similarity in behavior between the actor & friends
# avAlt  - average alter behavior scores (alters are the nodes an actor is tied to)
# indeg  - the effect of indegree on the behavior (e.g. does being popular make you drink?)
# outdeg - the effect of outdegree on behavior    (e.g. does being friendly make you smoke?)

eff.1 <- getEffects(dat.2)
# network effect
eff.1 <- includeEffects    (eff.1,transTrip, cycle3, recip)
# covariance effect
eff.1 <- includeEffects    (eff.1,egoX            ,altX   ,simX , samX   ,interaction1 = "drink.beh")
# behavioral effect
eff.1 <- includeEffects    (eff.1,name="drink.beh",avAlt ,indeg , outdeg ,interaction1 = "friend.net")
# interaction effect
eff.1 <- includeInteraction(eff.1,egoX            ,recip                 ,interaction1 = c("smoke.vc" ,""))
eff.1 <- includeInteraction(eff.1,egoX            ,egoX                  ,interaction1 = c("smoke.vc" ,"drink.beh"))
eff.1

# 3) MODEL SPECIFICATION: Effects included in the Siena model
eff.1 <- getEffects(dat.1)
# Add, remove effect
eff.1 <- includeEffects(eff.1, transTrip, include=TRUE)
# Do people who smoke more tend to form more friendship ties?
eff.1 <- includeEffects(eff.1, egoX, interaction1 = "smoke.cc")
# Do people who smoke more tend to be more popular?
eff.1 <- includeEffects(eff.1, altX, interaction1 = "smoke.cc")
# Are people more likely to form ties with others who have similar smoking level?
eff.1 <- includeEffects(eff.1, simX, interaction1 = "smoke.cc")
# Are people more likely to form ties with others who have the same smoking level?
eff.1 <- includeEffects(eff.1, sameX, interaction1 = "smoke.cc")
# Do smokers have a greater tendency to reciprocate friendship ties than non-smokers?
eff.1 <- includeInteraction(eff.1, egoX, recip, interaction1 = c("smoke.cc","        "))
# How about an interaction between smoking and drinking? Do people who do both form more ties?
eff.1 <- includeInteraction(eff.1, egoX, egoX, interaction1 =  c("smoke.cc","drink.vc"))
eff.1

# Behavior-related effects
# Let's get the effects for the variables in dat.2:
eff.2 <- getEffects(dat.2)
# we can examine sender, receiver, and homophily effects of the behavioral var on the network structure:
eff.2 <- includeEffects(eff.2, egoX, altX, simX, interaction1 = "drink.beh")
# Do people become more similar to their friends over time?
eff.2 <- includeEffects(eff.2, name = "drink.beh", avAlt, indeg, outdeg, interaction1 = "friend.net")
eff.2

# MODEL PARAMETER ESTIMATION in RSiena
# First we'll specify effects as we did above, using the data in dat.2:
eff.3 <- getEffects(dat.2)
# Let's include some structural effects:
eff.3 <- includeEffects(eff.3, transTrip, cycle3)
# A homophily effect for the smoking constant covariate:
eff.3 <- includeEffects(eff.3, simX, interaction1 = "smoke.vc")
# And an influence effect for the drinking behavior.
# We'll assume a student's drinking behavior is influenced  by the average drinking level of their friends:
eff.3 <- includeEffects(eff.3, name="drink.beh", avAlt, interaction1 = "friend.net")
# Take a look at our effects:
eff.3

# 4) Test
# Create a siena project.
mod.1 <- sienaModelCreate(projname='Student_Behavior_Model')
# return the simulated networks
result.2 <- siena07( mod.1, data=dat.2, effects=eff.1, returnDeps=TRUE, batch=TRUE)
result.2
# How similar is the indegree distribution of the observed data to those of networks simulated based on our model?
ideg.gof <- sienaGOF(result.2, IndegreeDistribution, varName = "friend.net")
ideg.gof
plot(ideg.gof)
# Similarly, let's check out-degree: how similar our observed values to those for simulated nets?
odeg.gof <- sienaGOF(result.2, OutdegreeDistribution, varName = "friend.net")
odeg.gof
plot(odeg.gof)
# Similarly, let's check geodesic distances: how similar our observed values to those for simulated nets?
geo.gof <- sienaGOF(result.2, BehaviorDistribution, varName = "drink.beh")
geo.gof
plot(geo.gof)

# In this model, we have significant parameters for all rates, density, reciprocity, and transitivity. 
# Our hypotheses about network influence on drinking and homophily in smoking were not supported.
# The model convergence is good, with all t-ratios < 0.1

?effectsDocumentation

library(parallel)
detectCores()
