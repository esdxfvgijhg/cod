source("script/read.r")

library(igraph)
source("script/setup.r")

library(RSiena)
library(RSienaTest)

# Siena
t1 <- as.matrix(as_adjacency_matrix(mails.important.g))
sizesiena <- length(t1[,1])
t2 <- as.matrix(as_adjacency_matrix(mails.important.g))
t3 <- as.matrix(as_adjacency_matrix(mails.important.g))
friend.t123 <- array(c(t1, t2, t3), dim=c(sizesiena, sizesiena, 3))

# Network variables (DV)
friend.net <- sienaNet(friend.t123, type="oneMode")
# Behavior variables (DV)
attr1.beh <- sienaNet(attr1[1:sizesiena,], type = "behavior")
attr2.beh <- sienaNet(attr2[1:sizesiena,], type = "behavior")
attr3.beh <- sienaNet(attr3[1:sizesiena,], type = "behavior")
attr4.beh <- sienaNet(attr4[1:sizesiena,], type = "behavior")
# Constant covariates (IV)
attr2.cc <- coCovar(attr2[1:sizesiena,1])
attr1.cc <- coCovar(attr1[1:sizesiena,1])
attr3.cc <- coCovar(attr3[1:sizesiena,1])
attr4.cc <- coCovar(attr4[1:sizesiena,1])
# Varying covariates (IV)
attr2.vc <- varCovar(attr2[1:sizesiena,])
attr1.vc <- varCovar(attr1[1:sizesiena,])
attr3.vc <- varCovar(attr3[1:sizesiena,])  
attr4.vc <- varCovar(attr4[1:sizesiena,])

# 2) DATA SPECIFICATION: combine dependent & independent variables   !!!!!!!
dat.1 <- sienaDataCreate(friend.net, attr1.vc, attr2.cc)
dat.2 <- sienaDataCreate(friend.net, attr1.beh, attr2.vc)
# dat.2 <- sienaDataCreate(friend.net, attr1.beh, attr1.vc)
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

# Behavioral effects
# avSim  - average similiarity in behavior between the actor & friends
# totSim - total (summed) similarity in behavior between the actor & friends
# avAlt  - average alter behavior scores (alters are the nodes an actor is tied to)
# indeg  - the effect of indegree on the behavior (e.g. does being popular make you attr1?)
# outdeg - the effect of outdegree on behavior    (e.g. does being friendly make you attr2?)

eff.1 <- getEffects(dat.2)
# network effect
eff.1 <- includeEffects    (eff.1,transTrip, cycle3, recip)
# covariance effect
eff.1 <- includeEffects    (eff.1,egoX            ,altX   ,simX , samX   ,interaction1 = "attr1.beh")
# behavioral effect
eff.1 <- includeEffects    (eff.1,name="attr1.beh",avAlt ,indeg , outdeg ,interaction1 = "friend.net")
# interaction effect
eff.1 <- includeInteraction(eff.1,egoX            ,recip                 ,interaction1 = c("attr2.vc" ,""))
eff.1 <- includeInteraction(eff.1,egoX            ,egoX                  ,interaction1 = c("attr2.vc" ,"attr1.beh"))
eff.1

# 3) MODEL SPECIFICATION: Effects included in the Siena model
eff.1 <- getEffects(dat.2)
# Add, remove effect
eff.1 <- includeEffects(eff.1, transTrip, include=TRUE)
# Do people who attr2 more tend to form more friendship ties?
eff.1 <- includeEffects(eff.1, egoX, interaction1 = "attr2.cc")
# Do people who attr2 more tend to be more popular?
eff.1 <- includeEffects(eff.1, altX, interaction1 = "attr2.cc")
# Are people more likely to form ties with others who have similar smoking level?
eff.1 <- includeEffects(eff.1, simX, interaction1 = "attr2.cc")
# Are people more likely to form ties with others who have the same smoking level?
eff.1 <- includeEffects(eff.1, sameX, interaction1 = "attr2.cc")
# Do attr2rs have a greater tendency to reciprocate friendship ties than non-attr2rs?
eff.1 <- includeInteraction(eff.1, egoX, recip, interaction1 = c("attr2.cc",""))
# How about an interaction between smoking and attr1ing? Do people who do both form more ties?
eff.1 <- includeInteraction(eff.1, egoX, egoX, interaction1 =  c("attr2.cc","attr1.vc"))
eff.1

# Behavior-related effects
# Let's get the effects for the variables in dat.2:
eff.2 <- getEffects(dat.2)
# we can examine sender, receiver, and homophily effects of the behavioral var on the network structure:
eff.2 <- includeEffects(eff.2, egoX, altX, simX, interaction1 = "attr1.beh")
# Do people become more similar to their friends over time?
eff.2 <- includeEffects(eff.2, name = "attr1.beh", avAlt, indeg, outdeg, interaction1 = "friend.net")
eff.2

# MODEL PARAMETER ESTIMATION in RSiena
# First we'll specify effects as we did above, using the data in dat.2:
eff.3 <- getEffects(dat.2)
# Let's include some structural effects:
eff.3 <- includeEffects(eff.3, transTrip, cycle3)
# A homophily effect for the smoking constant covariate:
eff.3 <- includeEffects(eff.3, simX, interaction1 = "attr2.vc")
# And an influence effect for the attr1ing behavior.
# We'll assume a student's attr1ing behavior is influenced  by the average attr1ing level of their friends:
eff.3 <- includeEffects(eff.3, name="attr1.beh", avAlt, interaction1 = "friend.net")
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
geo.gof <- sienaGOF(result.2, BehaviorDistribution, varName = "attr1.beh")
geo.gof
plot(geo.gof)

# In this model, we have significant parameters for all rates, density, reciprocity, and transitivity. 
# Our hypotheses about network influence on attr1ing and homophily in smoking were not supported.
# The model convergence is good, with all t-ratios < 0.1

?effectsDocumentation

library(parallel)
detectCores()


# create a network object from each matrix
t0<-as.network(matrix(c(0,1,0,
                        0,0,0,
                        1,0,0),ncol=3,byrow=TRUE))

t1<-as.network(matrix(c(0,1,0,
                        0,1,0,
                        0,0,0),ncol=3,byrow=TRUE))

t2<-as.network(matrix(c(0,0,0,
                        0,1,0,
                        0,1,0),ncol=3,byrow=TRUE))
# convert a list of networks into networkDynamic object
tnet<-networkDynamic(network.list=list(t0,t1,t2))
