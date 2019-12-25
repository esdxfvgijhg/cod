## Network
library(network)
library(intergraph)
library('Hmisc')
library(igraph)


detach("package:arcdiagram")
detach("package:igraph")

mails.important.net <- network(mails.important, matrix.type ="edgelist", weighted = TRUE, directed=FALSE)

# Centrality
for (i in 1:length_cent){
  mails.important.net %v% names(calc_cent)[i] <- calc_cent[[i]]
}

table(mails.important.net %v% names(calc_cent)[2])
mixingmatrix(mails.important.net, names(calc_cent)[2])

# Structural signatures: edges (density), 2-stars: kstar(2), 3-stars: kstar(3) isolates: isolates, etc.
# Edge covariate parameter: 

# NODEMATCH: Are nodes with the same attribute levels more likely to be connected?

# NODEMIX: nodemix will add a parameter for each combination of levels for the categorical variable.

# NODEFACTOR
# Main effect of a categorical attribute.
# Are some types of nodes more likely to form ties than others?

# NODECOV
# Main effect of a continuous attribute (we'll treat atttr1 as continuous here).
# For directed networks, we have nodeicov (for incoming links) and nodeocov (for outgoing links).
# Are nodes with high levels on a continuous attribute more likely to form ties?

# ABSDIFF
# For continuous attributes: are people more likely to be connected to others
# who have similar values on an attribute? Absdiff = abs(ValueNode1-ValueNode2)
# Here, are students more likely to have friends close to their own grade?
# (that is, links i->j are more likely for smaller values of abs(grade of i - grade of j))

# Is there a statistically significant tendency for ties to be reciprocated?

library(ergm)
library(sna) 
library(statnet)
library(coda)
library(latentnet)

start.time <- Sys.time()
latent.fit <- ergmm(mails.important.net ~ euclidean(d = 2))
runtime=Sys.time()-start.time;
runtime;
summary(latent.fit)
plot(latent.fit)
mcmc.diagnostics(latent.fit)
plot(gof(latent.fit))

mails.mod.4 <- ergm(mails.important.net ~ edges +
                      # 
                      # nodematch(names(calc_cent)[i], diff=F) + 
                      # nodematch(names(calc_cent)[i], diff=F) + 
                      # nodematch(names(calc_cent)[i], diff=F) +
                      nodematch(names(calc_cent)[2], diff=F) +
                      # 
                      # nodecov(names(calc_cent)[i]) + 
                      # nodecov(names(calc_cent)[i]) + 
                      # nodecov(names(calc_cent)[i]) +
                      nodecov(names(calc_cent)[3]) +
                      # 
                      # nodefactor("ptech") + 
                      # nodefactor("psocial") + 
                      # nodefactor("diffusion")
                      # 
                      # absdiff(names(calc_cent)[i]) +
                      # absdiff(names(calc_cent)[i]) +
                      # absdiff(names(calc_cent)[i]) +
                      absdiff(names(calc_cent)[1])
                      # 
                      # nodemix("ptech") + 
                      # nodemix("psocial") + 
                      # nodemix("diffusion")

                      control = control.ergm(MCMC.samplesize=5000, MCMC.interval=1000)
                    )

summary(mails.mod.4)
mcmc.diagnostics(mails.mod.4)

mails.mod.4.gof.degree <- gof(mails.mod.4 ~ degree)
mails.mod.4.gof.distance <- gof(mails.mod.4 ~ distance)

summary(mails.mod.4.gof.distance)
plot(mails.mod.4.gof.distance)

mails.mod.4.sim <- simulate(mails.mod.4, nsim=15, control=control.simulate.ergm(MCMC.interval=10000))
summary(mails.mod.4.sim)
sim.stats <- attr(mails.mod.4.sim,"stats")
summary(sim.stats)

library(igraph)
plot_aghiles(asIgraph(mails.mod.4.sim[[15]]), signif(psocial,1), ,"","","deg")

