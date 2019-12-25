#!/usr/bin/env Rscript
# setwd("enron")

a1s_0 <- read.csv(file="1s_0.csv", header=T, sep=",")*1000
a1s_1 <- read.csv(file="1s_1.csv", header=T, sep=",")*1000
a5s_0 <- read.csv(file="5s_0.csv", header=T, sep=",")*1000
a5s_1 <- read.csv(file="5s_1.csv", header=T, sep=",")*1000
a10s_0 <- read.csv(file="10s_0.csv", header=T, sep=",")*1000
a10s_1 <- read.csv(file="10s_1.csv", header=T, sep=",")*1000
data <- c(a1s_0,a1s_1,a5s_0,a5s_1,a10s_0,a10s_1)
data


mails <- read.csv(file="../res/mails_enron.csv", header=TRUE, sep=",")
important.people <- c("louise.kitchen", "mike.grigsby", "greg.whalley", "scott.neal", "kenneth.lay", "harry.arora", "bill.williams")
mails.important <- subset(mails, From %in% important.people | To %in% important.people)

# attr1 <- as.matrix(read.table("data/s100-attr1.dat"))
# attr2 <- as.matrix(read.table("data/s100-attr2.dat"))
# attr3 <- as.matrix(read.table("data/s100-attr3.dat"))
# attr4 <- as.matrix(read.table("data/s100-attr4.dat"))

# mails.important.g <- set_vertex_attr(mails.important.g, "attr1",       value = attr1[,1])
# mails.important.g <- set_vertex_attr(mails.important.g, "attr2",       value = attr2[,1])
# mails.important.g <- set_vertex_attr(mails.important.g, "attr3",       value = attr3[,1])
# mails.important.g <- set_vertex_attr(mails.important.g, "attr4",       value = attr4[,1])

############################################################# Igraph  ####################################################








