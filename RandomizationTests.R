#Randomization tests
# April 11 2017

# 1 define univariate metric X <- a single nuber that characterses a pattern
# 2 calcuate x for the observed dataset, Xobs
# 3 compare it by randomizing data, subject to some constraints
# 4 calculate X for randomized data, Xsim[ulated]
# repeat #4 many tmes (n=1000). Generate a distribution of Xsim which can be 
# visualized as a histogram
# 6 compared Xobs to Xsim, or probability of observed or null hypothesis
# 7 draw biological inference or conclusion



# compae ant species richness among different New England ecotypes
data <- read.table(file = "antcountydata.csv", header=TRUE, sep = ",", stringsAsFactors = FALSE)
data$ecoregion <- as.factor(data$ecoregion)
boxplot(data$n.species~data$ecoregion,col="indianred")
myModel <- aov(n.species~ecoregion,data=data)
summary(myModel)

# define respone metric
# use variance among treatment means as X

#############################################
# FUNCTION: VarMeans
# Calcualte variance among group of treatment means
# input: vector of groups, vector of group means
# output: among group variance of means
#--------------------------------------------
VarMeans <- function(fac=NULL, res=runif(25)) {
  if(is.null(fac)) {
    fac <- as.factor(rep(LETTERS[1:5], each = 5))
}
temp <- aggregate(x=res, by=list(fac), FUN = mean)
return(var(temp$x))
}
###########################################
VarMeans()

# specify treatment randomization

#############################################
# FUNCTION: TreatRan
# randomize treatent (factor) labels
# input: vector of observed treatment labels
# output: vwctor of randomized treatment labels
#--------------------------------------------
TreatRan <- function(fac=NULL) {
if(is.null(fac)){
  fac <- as.factor(rep(LETTERS[1:5], each=5))
}
  fac <- sample(fac,replace=FALSE)

  return(fac)
}
###########################################
TreatRan()  

# Now write a function for summary and plots
#############################################
# FUNCTION: randomizeSummary
# give summary stats boxplots and histogram plot
# input: vector of simulated vlues, observed value
# output: list of null model statistics, graphs
#--------------------------------------------
randomizeSummary <- function(obsX=runif(1), 
                             simX=runif(1000), 
                             fac=NULL, 
                             res=runif(25)) {
  if(is.null(fac)){
    fac <- as.factor(rep(LETTERS[1:5], each=5))
  }
  pLow <- mean(simX <= obsX)
  pHigh <-mean(simX >= obsX)
  meanSimX <- mean(simX)
  varSimX <- var(simX)
  SES <- (obsX - mean(simX))/sd(simX)
  
  outList <- list(stats=list(obsX=obsX,
                             meanSimX=meanSimX,
                             varSimX=varSimX,
                             pLow=pLow,
                             pHigh=pHigh,
                             SES=SES,
                             reps=length(simX)),
                             raw=simX)
  
  par(mfrow=c(1,3))
  
  # show boxplot of real data
  boxplot(res~fac, col="indianred")
  mtext("Observed Data", side=3,font=2,cex=0.75)
  
  # show boxplot of similated data
  boxplot(res~sample(fac), col="goldenrod")
  mtext("Simulated Data", side=3,font=2,cex=0.75)
  
  # show histogram of simulated and observed values
  hist(simX, breaks=25, 
       col="goldenrod", main = "Null Distribution", xlab="Simulated Response",
       xlim = c(0, max(c(simX,obsX))))
  
  Interval95 <- quantile(x=simX,probs = c(0.05,0.95))
  Interval975 <- quantile(x=simX,probs = c(0.025,0.975))
  abline(v=obsX,col="indianred", lwd=2)
  abline(v=Interval95, col="black", lwd=2, lty="dotted")
  abline(v=Interval975, col="black", lwd=2, lty="dashed")
  par(mfrow=c(1,1))
  return(outList)
}

###########################################

z <- randomizeSummary()


#---------------------------------------
# global variables
filename <- "antcountydata.csv"
data <- read.table(file = filename,
                   header = TRUE,
                   sep=",",
                   stringsAsFactors = FALSE)
data$ecoregion <- as.factor(data$ecoregion)
grps <- data$ecoregion
richness <- data$n.species
nreps <- 1000
outVec <- vector(mode="numeric", length = nreps)
obsX <- VarMeans(fac=grps, res=richness)
                   
# for (i in 1:nreps) {
#  outVec[i] <- VarMeans(fac=TreatRan(grps),res=richness)
#}

# runif(1)
# runif(5)
# replicate(5, runif(1)) # creates a vector just like abut
# replicate(5,runif(3)) # creates a matrixs, 5 columns 3 rows

outVec <- replicate(nreps, VarMeans(fac=TreatRan(grps), res=richness))
head(outVec)
z <- randomizeSummary(obsX=obsX, simX = outVec,fac=grps, res=richness)
