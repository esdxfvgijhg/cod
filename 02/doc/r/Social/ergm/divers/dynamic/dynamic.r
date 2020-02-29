###################

library(igraph)

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


library(ndtv)
library(network)
library(intergraph)
detach("package:arcdiagram")
detach("package:igraph")

mails.important <- mails.important
net3 <- network(mails.important, matrix.type ="edgelist", weighted = TRUE , directed=FALSE)

set.vertex.attribute(net3, "attr1", attr1[,1])
get.vertex.attribute(net3, "attr1")
set.vertex.attribute(net3, "attr2", attr2[,1])
get.vertex.attribute(net3, "attr2")
set.vertex.attribute(net3, "attr3", attr3[,1])
get.vertex.attribute(net3, "attr3")
set.vertex.attribute(net3, "attr4", attr4[,1])
get.vertex.attribute(net3, "attr4")
set.vertex.attribute(net3, "domain", domain)
get.vertex.attribute(net3, "domain")

all_p <- as.numeric(as.Date(mails.important[,5]))
all   <- match(all_p, unique(all_p))

vs <- data.frame(onset=1, terminus=max(all), vertex.id=1:14)
es <- data.frame(onset=all, terminus=max(all),
                 head=as.matrix(net3, matrix.type="edgelist")[,1],
                 tail=as.matrix(net3, matrix.type="edgelist")[,2])

net3.dyn <- networkDynamic(base.net=net3, edge.spells=es, vertex.spells=vs)
plot(network.extract(net3.dyn, at=15), vertex.col="domain")

slice.par <- list(start = 1, end = max(all), interval = 10, aggregate.dur = 10, rule = "any")
render.par <- list(tween.frames = 10, show.time = TRUE)
plot.par <- list(mar = c(0, 0, 0, 0))

##
# compute.animation(net3.dyn, animation.mode = "kamadakawai", slice.par=slice.par)
# filmstrip(net3.dyn, displaylabels=F, mfrow=c(2, 3), slice.par=slice.par)

##
library(RColorBrewer)
colors = brewer.pal(length(levels(as.factor(domain))), "Set1")
animation <- render.d3movie(net3.dyn,
                            usearrows = T, 
                            displaylabels = F, 
                            label = net3 %v% "domain",
                            bg = "#ffffff",
                            output.mode = "htmlWidget",
                            render.par = render.par,
                            
                            vertex.col = colors[match(domain, unique(domain))],
                            vertex.cex = 0.5, #function(slice){ degree(slice)/2.5},
                            vertex.tooltip = paste("<b>Name:</b>", (net3.dyn %v% "vertex.names") , "<br>",
                                                   "<b>Type:</b>", (net3.dyn %v% "type.label")),
                            
                            edge.cex = 17,
                            edge.lwd = (net3.dyn %e% "weight")/3, 
                            edge.col = 'lightgrey',
                            edge.tooltip = paste("<b>Edge type:</b>", (net3.dyn %e% "type"), "<br>", 
                                                 "<b>Edge weight:</b>", (net3.dyn %e% "weight" )))
#              vertex.tooltip = function(slice) {paste('name:',slice%v%'vertex.names','<br>','status:', slice%v%'testatus')})
animation

library("scatterplot3d")
timePrism(net3.dyn, at = c(1:500), displaylabels = FALSE, planes = TRUE)

library(tsna)
plot(tErgmStats(net3.dyn,'edges', start = 0, end = max(all), time.interval = 10))
plot(hist(edgeDuration(net3.dyn)))
plot(tEdgeFormation(net3.dyn))

plot(tSnaStats(net3.dyn,'gtrans'))

path <- tPath(net3.dyn,v = 13, graph.step.time=1)
plot(path, edge.lwd = 2)
plotPaths(net3.dyn, path, label.cex=NA)

