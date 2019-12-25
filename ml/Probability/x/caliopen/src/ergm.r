## Network
library(network)
library(intergraph)
detach("package:arcdiagram")
detach("package:igraph")

mails.important.net <- network(mails.important, matrix.type ="edgelist", weighted = TRUE, directed=FALSE)

# plot(mails.important.net)
set.vertex.attribute(mails.important.net, "attr1", attr1[,1])
get.vertex.attribute(mails.important.net, "attr1")
set.vertex.attribute(mails.important.net, "attr2", attr2[,1])
get.vertex.attribute(mails.important.net, "attr2")
set.vertex.attribute(mails.important.net, "attr3", attr3[,1])
get.vertex.attribute(mails.important.net, "attr3")
set.vertex.attribute(mails.important.net, "attr4", attr4[,1])
get.vertex.attribute(mails.important.net, "attr4")

# Centrality
set.vertex.attribute(mails.important.net, "deg", deg)
get.vertex.attribute(mails.important.net, "deg")
set.vertex.attribute(mails.important.net, "closeness", closeness)
get.vertex.attribute(mails.important.net, "closeness")
set.vertex.attribute(mails.important.net, "betweenness", betweenness)
get.vertex.attribute(mails.important.net, "betweenness")
set.vertex.attribute(mails.important.net, "hs", hs)
get.vertex.attribute(mails.important.net, "hs")
set.vertex.attribute(mails.important.net, "as", as)
get.vertex.attribute(mails.important.net, "as")
set.vertex.attribute(mails.important.net, "coreness", coreness)
get.vertex.attribute(mails.important.net, "coreness")

# Cluster
set.vertex.attribute(mails.important.net, "ceb", ceb$membership)
get.vertex.attribute(mails.important.net, "ceb")
set.vertex.attribute(mails.important.net, "clp", clp$membership)
get.vertex.attribute(mails.important.net, "clp")
set.vertex.attribute(mails.important.net, "cle", clp$membership)
get.vertex.attribute(mails.important.net, "cle")
set.vertex.attribute(mails.important.net, "cfg", cfg$membership)
get.vertex.attribute(mails.important.net, "cfg")
set.vertex.attribute(mails.important.net, "cs", cs$membership)
get.vertex.attribute(mails.important.net, "cs")
set.vertex.attribute(mails.important.net, "cw", cw$membership)
get.vertex.attribute(mails.important.net, "cw")
set.vertex.attribute(mails.important.net, "cl", cl$membership)
get.vertex.attribute(mails.important.net, "cl")

table(mails.important.net %v% 'deg')
mixingmatrix(mails.important.net, "deg")

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

# A simple model that includes just the edge (density) parameter:    !!!!! which model
mails.mod.1 <- ergm(mails.important.net ~ edges)
summary(mails.mod.1)

mails.mod.4 <- ergm(mails.important.net ~ edges + 
                      gwesp(0.25, fixed=T) +
                      
                      # Centrality
                      nodematch("deg", diff=F) + 
                      nodematch("closeness", diff=F) + 
                      nodematch("betweenness", diff=F) +
                      nodematch("hs", diff=F) + 
                      nodematch("as", diff=F) + 
                      nodematch("coreness", diff=F) 
                      # 
                      # # Cluster
                      # nodematch("ceb", diff=F) + 
                      # nodematch("clp", diff=F) + 
                      # nodematch("cle", diff=F) + 
                      # nodematch("cfg", diff=F) + 
                      # nodematch("cs", diff=F) +
                      # nodematch("cw", diff=F) +
                      # nodematch("cl", diff=F) +
                      # 
                      # # Centrality
                      # nodecov("deg") + 
                      # nodecov("closeness") + 
                      # nodecov("betweenness") +
                      # nodecov("hs") + 
                      # nodecov("as") + 
                      # nodecov("coreness") + 
                      # 
                      # # Cluster                      
                      # nodecov("ceb") + 
                      # nodecov("clp") + 
                      # nodecov("cfg") + 
                      # nodecov("cs") +
                      # 
                      # # Centrality
                      # nodefactor("deg") + 
                      # nodefactor("closeness") + 
                      # nodefactor("betweenness") +
                      # nodefactor("hs") + 
                      # nodefactor("as") + 
                      # nodefactor("coreness") + 
                      # 
                      # # Cluster
                      # nodefactor("ceb") + 
                      # nodefactor("clp") + 
                      # nodefactor("cfg") + 
                      # nodefactor("cs") +
                      # 
                      # # Centrality
                      # absdiff("deg") +
                      # absdiff("closeness") + 
                      # absdiff("betweenness") +
                      # absdiff("hs") + 
                      # absdiff("as") + 
                      # absdiff("coreness") + 
                      # 
                      # # Cluster
                      # absdiff("ceb") + 
                      # absdiff("clp") + 
                      # absdiff("cfg") + 
                      # absdiff("cs") +
                      # 
                      # # Centrality
                      # nodemix("deg") +
                      # nodemix("closeness") + 
                      # nodemix("betweenness") +
                      # nodemix("hs") + 
                      # nodemix("as") + 
                      # nodemix("coreness") + 
                      # 
                      # # Cluster
                      # nodemix("ceb") + 
                      # nodemix("clp") + 
                      # nodemix("cfg") + 
                      # nodemix("cs"), verbose=T,
                      # control = control.ergm(MCMC.samplesize=5000, MCMC.interval=1000)
                    )

summary(mails.mod.4)
mcmc.diagnostics(mails.mod.4)

mails.mod.4.gof <- gof(mails.mod.4 ~ degree)
# mails.mod.4.gof <- gof(mails.mod.4 ~ distance)
summary(mails.mod.4.gof)
plot(mails.mod.4.gof)

mails.mod.4.sim <- simulate(mails.mod.4, nsim=15, control=control.simulate.ergm(MCMC.interval=10000))
summary(mails.mod.4.sim)
sim.stats <- attr(mails.mod.4.sim,"stats")
summary(sim.stats)

library(igraph)
plot_aghiles(asIgraph(mails.mod.4.sim[[15]]), signif(closeness,1), ,"","","deg")

########################################################################################################################"

summary(calc_cent)

calc_cent$`Decay Centrality`

ptech <- 0.9
pmal = calc_prob$`Diffusion Degree`$empirical * ptech
pv = 1 - (1-pmal)^calc_cent$`Degree Centrality`
psocial = pv * calc_prob$`clustering coefficient`$empirical

psocial <- page.rank (mails.important.g, directed = FALSE, damping = 0.85, personalized= calc_cent$`Decay Centrality`, options = igraph.arpack.default) 
dat <- psocial
dat

dist_name <- c("norm", "exp", "weibull", "lnorm", "gamma", "logis", "cauchy", "gumbel", "triang", "binom")
fit <- list()
fit$norm    <- fitdist(dat,dist_name[1])
fit$exp     <- fitdist(dat,dist_name[2])
fit$weibull <- fitdist(dat,dist_name[3])
fit$lnorm   <- fitdist(dat,dist_name[4])
fit$gamma   <- fitdist(dat,dist_name[5])
fit$logis   <- fitdist(dat,dist_name[6])
fit$cauchy  <- fitdist(dat,dist_name[7])
fit$gumbel  <- fitdist(dat,dist_name[8], start=list(a=10,b=5))
# fit$triang  <- fitdist(dat,dist_name[9])
# fit$binom   <- fitdist(dat,dist_name[10], size=2, prob = 0.5)   
prob <- list()
prob$norm <- pnorm(dat)
prob$exp <- pexp(dat)
prob$weibull <- pweibull(dat,shape = 1)
prob$lnorm <- plnorm(dat)
prob$gamma <- pgamma(dat, shape = 1)
prob$logis <- plogis(dat)
prob$cauchy <- pcauchy(dat)
prob$gumbel <- pgumbel(dat, a = 1, b=1)
prob$binom <- pbinom(dat, size=2, prob = 0.5)
library(jmuOutlier)
prob$triang <- ptriang(dat)
prob$empirical <- ecdf(dat)(dat)

cdfcomp(fit)
denscomp(fit)
plot_aghiles(mails.important.g, prob$empirical, , "", "", "P social")


