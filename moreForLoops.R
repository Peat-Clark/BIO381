# using for loops to sweep model parameters
# 6 april 2017
# pwc

######################################################################
# FUNCTION: SpeciesAreaCurve
# power function for Species richness, S and A
# input: A is a vector of island areas  
#        c is the intercept constant
#        z is the slope constant
# output: S, a vector or predicted species richness
#---------------------------------------------------------------------

SpeciesAreaCurve<- function(A=1:5000, 
                            c=0.5,
                            z=0.26) {
  S <- c*(A^z)
  
  return(S)
}
################
head(SpeciesAreaCurve())

cPars <- c(100,150,170)
zPars <- c(0.10,0.16,0.26,0.30)
expand.grid(cPars,zPars) # expand.grid takes vectors and combines them into a dataframe


#############################################
# FUNCTION: myExpandGrid
# home grow expand grid functio for 2 variables
# input: 2 vectors
# output: data frame with parameters swept
#--------------------------------------------
myExpandGrid <- function(a=1:4,b=c(300,400,500)) {
  Factor1 <- rep(a,times=length(b)) # repeates a to the length of b
  Factor2 <- rep(b,each=length(a))
    return(list(varA=Factor1,varB=Factor2))
}

myExpandGrid()

###########################################



#extract output fro SpeciesArea
#############################################
# FUNCTION: SA_Output
# gras result from species vector
# input: vector of species rchness from SA function
# output: list of max-min, and coefficient of variation
#--------------------------------------------
SA_Output <- function(S=1:10) {
  sumStats <- list(SDelta=max(S)-min(S), SCV=sd(S)/mean(S))
  return(sumStats)
}
###########################################
# now build program body with a single loop through the paremeters in modelFrame

Area <- 1:5000
cPars <- c(100,150,170)
zPars <- c(0.10,0.16,0.26,0.30)

# now set up model frame
modelFrame <- expand.grid(c=cPars,z=zPars)
modelFrame$SDelta <- NA
modelFrame$SCV <- NA
print(modelFrame)

# now cycle through the model calcualtions
for (i in 1:nrow(modelFrame)) {
  #generate out S vector
  temp1 <- SpeciesAreaCurve(A=Area,c=modelFrame[i,1],z=modelFrame[i,2])
  
  # now calculate output stats
  temp2 <- SA_Output(temp1)
  
  # pass the results back to modelFrame
  modelFrame[i,c(3,4)] <- temp2

}
print(modelFrame)


# sweeping parameters for stochastic model
#####################################################################
#
# Function name: RanWlk
# stochastic random walk (form of an exponsential growht moel
# input: 
#         times = nmber of time steps
#         n1 = initial population size
#         lamdda = finite rate of increase
#         noiseSD = sd of normal distribution with mean=0
# output: vector n with population sizes > 0 until extinction NA
#-------------------------------------------------------------------

library(tcltk)
RanWalk <- function(times=100,
                    n1=50,
                    lambda=1.001,
                    noiseSD=10) {
  n <- rep(NA,times)
  n[1] <- n1
  noise <- rnorm(n=times,mean=0,sd=noiseSD)
  
  for (i in 1:(times-1)) {
    n[i + 1] <- lambda*n[i] + noise[i]
    if(n[i + 1] <=0){ # this compound statement tells the code to execute if =0
      n[i + 1] <- NA
#      cat("Population extinction at time",
#          i-1,"\n")
#      tkbell() # goofy code that "dings" if the code meets parametrs
      break}
  }
  return(n)
  
}
################################

#############################################
# FUNCTION: ranWalkOutput
# summarizes univariate metric to describe population trajectory
# input: vector of population sizes
# output: length of positive elements in vector
#--------------------------------------------
rWalkOutput <- function(v=c(1:10,c(NA,NA))) {
  lenPop <- length(v[is.na(v)==FALSE])
  
  return(lenPop)
}
###########################################

# global variables
SeriesLength <- 500 # length of each population run
lambda <- c(0.95, 0.99, 1.00, 1.01, 1.05)
noiseSD <- c(0,5,10,20) # noise
n1 <- 50 # initial population size  at time 1
reps <- 20 # number of replications for each parameter combination

# create output structure

ranOut <- expand.grid(n1=n1, reps=reps, SeriesLength=SeriesLength,
                      lambda=lambda, noiseSD=noiseSD)

# add summary response variables
ranOut$meanLength <- NA
ranOut$sdLength <- NA
ranOut # just added those to the grid. easy

SurvivalTime <- rep(NA,reps) # vector to hold survivival time

# begin program body
for (i in 1:nrow(ranOut)) { #start a parameter loop
  for (j in 1:reps) { # start of replicate loop
    temp <- RanWalk(times=ranOut$SeriesLength[i],
                    n1=ranOut$n1[i],
                    lambda=ranOut$lambda[i],
                    noiseSD=ranOut$noiseSD[i])
  SurvivalTime[j] <- rWalkOutput(temp)
    }
  ranOut$meanLength[i] <- mean(SurvivalTime)
  ranOut$sdLength[i] <- sd(SurvivalTime)
}
print(ranOut)
