library(RSiena)

mynet <- sienaDependent(array(c(s501, s502), dim=c(50, 50, 2)))
mybeh <- sienaDependent(s50a[,1:2], type="behavior")
mydata <- sienaDataCreate(mynet, mybeh)

myeff <- getEffects(mydata)
myeff <- includeEffects(myeff, transTrip)
myeff <- setEffect     (myeff, cycle3   , fix=TRUE, test=TRUE)
myeff <- setEffect     (myeff, transTies, fix=TRUE, test=TRUE)
myalgorithm <- sienaAlgorithmCreate(nsub=1, n3=50)

# Shorter phases 2 and 3, just for example.
ans  <- siena07(myalgorithm, data=mydata, effects=myeff, batch=TRUE, returnDeps=TRUE)
gofi <- sienaGOF(ans, IndegreeDistribution, verbose=TRUE, join=TRUE, varName="mynet")
summary(gofi)
plot(gofi)

# Illustration just for showing a case with two dependent networks;
# running time backwards is not meaningful!
mynet1 <- sienaDependent(array(c(s501, s502), dim=c(50, 50, 2)))
mynet2 <- sienaDependent(array(c(s503, s501), dim=c(50, 50, 2)))
mybeh <- sienaDependent(s50a[,1:2], type="behavior")
mydata <- sienaDataCreate(mynet1, mynet2, mybeh)
myeff <- getEffects(mydata)
myeff <- includeEffects(myeff, transTrip)
myeff <- includeEffects(myeff, recip, name="mynet2")
myeff <- setEffect(myeff, cycle3, fix=TRUE, test=TRUE)
myeff <- setEffect(myeff, transTies, fix=TRUE, test=TRUE)
myalgorithm <- sienaAlgorithmCreate(nsub=1, n3=50)

# Shorter phases 2 and 3, just for example.
ans <- siena07(myalgorithm, data=mydata, effects=myeff, batch=TRUE, returnDeps=TRUE)
gofi <- sienaGOF(ans, IndegreeDistribution, verbose=TRUE, join=TRUE, varName="mynet1")
summary(gofi)
plot(gofi)

## Not run: 
(gofi.nc <- sienaGOF(ans, IndegreeDistribution, cumulative=FALSE, varName="mynet1"))
# cumulative is an example of "...".
plot(gofi.nc)
descriptives.sienaGOF(gofi.nc)

(gofi2 <- sienaGOF(ans, IndegreeDistribution, varName="mynet2"))
plot(gofi2)

(gofb <- sienaGOF(ans, BehaviorDistribution, varName = "mybeh"))
plot(gofb)

(gofo <- sienaGOF(ans, OutdegreeDistribution, varName="mynet1", levls=0:6, cumulative=FALSE))
# levls is another example of "...".
plot(gofo)

## End(Not run)

## A demonstration of using multiple processes
## Not run: 
library(parallel)
(n.clus <- detectCores() - 1) # subtract 1 to keep time for other processes
myalgorithm.c <- sienaAlgorithmCreate(nsub=4, n3=1000, seed=12345)
(ans.c <- siena07(myalgorithm.c, data=mydata, effects=myeff, batch=TRUE, returnDeps=TRUE, useCluster=TRUE, nbrNodes=n.clus))
gofi.1 <- sienaGOF(ans.c, IndegreeDistribution, verbose=TRUE, varName="mynet1")
cl <- makeCluster(n.clus)
gofi.cl <- sienaGOF(ans.c, IndegreeDistribution, varName="mynet1", cluster=cl)

# compare simulation times
attr(gofi.1,"simTime")
attr(gofi.cl,"simTime")

## End(Not run)

