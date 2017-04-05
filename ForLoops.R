# care a feeding of For Loops
# 30 March 2017
# pwc

# universioal is all languages. #not necissary in R, but useful

# for loops wrtien as: for (var in seq) { BODY OF LOOP }
# var is a "counter variaable"
# each time var increment is 1
# sequence represents the start and end value that var references
# var i,j,k <- this is how counter variables are used
# sequence variable could be something simple, such as 1:10
# however in coding we may not want hard values (1:10), so we may want a vector,
# such as x = 1:1000, wherein: for(i in seq_along(x)) <- this is the fastest way
# to set it up for larger variables
# example:
# for(i in seq_along(x)) {
#     BODY
#     }


# simple example
myDat <- round(runif(10), digits=2) # create a vector of random round numbers
for (i in seq_along(myDat)) {
  cat("loop number = ",i,"vector element = ",myDat[i], "\n")
}

# don't put unnecessary things in loops
myDat <- vector(mode="numeric",length=10)
for (i in seq_along(myDat)) {
  myDat[i] <- round(runif(1),digits=2) # this bit of code should elsewhere- bog
  cat("loop number = ",i,"vector element = ",myDat[i], "\n")
}

# do not change object dimensions in a loop
# (c,rbind,cbind,list)

myDat <- runif(1)
for (i in 2:10) {
  temp <- round(runif(1),digits = 2)
  myDat <- c(myDat,temp)
  cat("loop number = ",i,"vector element = ",myDat[i], "\n")
}

# do not use a loop if you don't need to

myDat <- 1:10
for (i in seq_along(myDat)) {
  myDat[i] <- myDat[i] + myDat[i]^2
  cat("loop number = ",i,"vector element = ",myDat[i], "\n")
}

# can just do this instead:
z<- 1:10
z<- z+z^2
z

# be aware of i versus z[i]
z<-c(10,2,4)

for (i in seq_along(z)) {
  cat("i=",i, "z[i]=",z[i],"\n")
}

# use next in the loop to skip certain elements
z <- 1:20
# can we operate on the odd-number elements?
for (i in seq_along(z)) {
  if (i %% 2==0) next
  print(i)
}

# a faster better way to do this
z <- 1:20
zsub <- z[z %% 2!=0] # a sub function that selects for those that are not=0 when /2
z %% 2!=0 # output is logicals
zsub # output is only odd numbers

for (i n seq_along(zsub)) {
  cat("i= ",i,"zsub[i] = ",zsub[i],"\n")
}


#using the break function

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
    cat("Population extinction at time",
        i-1,"\n")
    tkbell() # goofy code that "dings" if the code meets parametrs
    break}
  }
return(n)

}
################################

head(RanWalk())
plot(RanWalk(), type="o") #
plot(RanWalk(lambda = 1,noiseSD = 5), type="o") # can mess with parmenters


# Using double for loops
# loop over rows
m <- matrix(round(runif(20),digits=3),nrow = 5)
for (i in 1:nrow(m)) {
  m[i,] <- m[i,] +i # usig row i, not columns. Add "1" to row #,then to each random #
}
print(m) # see how each has 

# loop over columns
m <- matrix(round(runif(20),digits=3),nrow = 5)
for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + j
}
print(m)

# double loop over rows and columns

m <- matrix(round(runif(20),digits=3),nrow = 5)
for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    m[i,j] <- m[i,j] + i + j
  }
}
print(m)


# write function to sweep over model parementers
# will put together combinations of all parameters

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

#####################################################################
# FUNCTION NAME: SpeciesAreaPlot
#plot the species area curve
# input: A is a vector of island areas  
#        c is the intercept constant
#        z is the slope constant
# output: Smoothed graph with parameters showen
#---------------------------------------------------------------------
SpeciesAreaPlot <- function(A=1:5000, 
                             c=0.5,
                             z=0.26) {
  plot(x=A,y=SpeciesAreaCurve(A,c,z), # assig x and y, call previous functon
       type="l", xlab = "Island Area", ylab = "S",ylim = c(0,1000)) # plot aesthetics
  mtext(paste("c = ", c,"z = ", z), cex = 0.7) # adding text and fomatting in margins

  return()
}
SpeciesAreaPlot()
# now sweep throgh the set of functions to build a grid of plots
# global variables

cPars <- c(100,150,175) # c parameters
zPars <- c(0.10, 0.16, 0.26, 0.3) # z parameters
par(mfrow=c(3,4)) # changes the graphic pallet so we have 3 rows of graphs and 4 columns


for (i in seq_along(cPars)) {
  for (j in seq_along(zPars)) {
    SpeciesAreaPlot(c=cPars[i],z=zPars[j])
  }
}

# looping with for
cutPoint <- 0.1
z <- NA
ranData <- runif(100)
for (i in seq_along(ranData)){
  z <- ranData[i]
  if (z < cutPoint) break
}
print(z)

# looping with while
z <- NA
cycleNumber <- 0 
while (is.na(z) | z >= cutPoint) {
  z <- runif(1)
  cycleNumber<- cycleNumber+1
}

print(z)  
print(cycleNumber)

# looping with repeat
z <- NA
cycleNumber <- 0
repeat {
  z <- runif(1)
  cycleNumber <- cycleNumber+1
  if (z <= cutPoint) break
}

print(z)
print(cycleNumber)

# expand.grid to create a dataframe with all of the parameter combinations

expand.grid(cPars,zPars)
expand.grid(c=cPars,z=zPars)

  