#Lecture #24: Base Graphics I
#PWC
#April 25, 2017

#Preserving Defaults, Attaching A Data Frame

####################################################
#  Standard calls for preserving defaults, and reading a csv
par() # a ridiculous number of graphic parameters
opar <- par(no.readonly=TRUE) # store defaults of changeable options
Ant.Data <- read.table(file="antcountydata.csv",
                       header=TRUE,
                       sep=",",
                       stringsAsFactors=FALSE)
attach(Ant.Data) # to cut down on typing of data frame name

##############################################################
#Basic Graphs & Lines
plot(x=lat.centroid,y=n.species,log="y") # log transforms; use x,y, or xy
plot(x=lat.centroid,y=n.species)
abline(h=20) # drawing a horizontal line
abline(v=46,lwd=2,lty="twodash",col="grey") # drawing a vertical line
abline(a=-1600,b=40) # intercept and slope
abline(lm(n.species~lat.centroid)) # standard regression
lines(lowess(n.species~lat.centroid),col="blue",lty="dotdash",lwd=2.5)
rug(lat.centroid) # show the density of data points
rug(n.species,side=2) # can be done on any axis for any variable
grid()
box(which="outer") # box options: outer, inner, figure, plot
box(col="gray",lwd=5)
text(44,60,"my text here at 44,60") # located using points along the xy axis

##############################################################
#Standard Axes
par(opar)
x <- 1:1000
y <- runif(1000,0.2)
plot(x,y,type="l",col="grey",ylim=c(0,1.2))
grid(nx=NA,ny=NULL,col="black")

# adjustments for standard axes

# use  xlim and y lim for clipping or adding white space
plot(x,y,type="l",col="grey",xlim=c(400,600),ylim=c(-1,1))

# use xlim and ylim reversed to flip axes
plot(x,y,,type="l",col="grey",xlim=c(1000,0))

# use lab for ticks x,y, len of label (default=7)
plot(x,y,type="l",col="grey",ylim=c(0,1.2),
     lab=c(1,5,7))

# use mgp for lines of text from edge. 3 numbers are:
# 1) margin label; 2) tick mark labels; 3) axis line
# defaults are 3,1,0

plot(x,y,type="l",col="grey",ylim=c(0,1.2),
     mgp=c(0,1,0)) # pulls in label

plot(x,y,type="l",col="grey",ylim=c(0,1.2),
     mgp=c(3,-1,0)) # pulls in label to inside


plot(x,y,type="l",col="grey",ylim=c(0,1.2),
     mgp=c(3,1,1)) # moves out entire axis

# use tcl to control length and direction of ticks; default=-0.5
plot(x,y,type="l",col="grey",ylim=c(0,1.2),
     tcl=1,lab=c(5,5,7))

# could pull in labels and use inner tick marks
# use las to flip tick labels to all horizontal
plot(x,y,type="l",col="grey",xlim=c(-40,1000),ylim=c(0.17,1),
     tcl=0.3,mgp=c(2,0.2,0),las=1,ann=FALSE,bty="L")

# use xlog in par or log in plot for transform
plot(x,y,type="l",col="grey",log="x")

# use xaxs and yaxs to control style of axis setting
# default = r = expanded range
# or set as i = exact range

par(pty="s") # the shape of the frame, s=square
par(mfrow=c(2,1))
par(mar=c(2,2,1,1))
plot(x,y,type="l",col="grey",ann=FALSE,xaxs="r")
plot(x,y,type="l",col="grey",ann=FALSE,xaxs="i")

######################################################
#Custom Axes
par(opar)
# create random data with gamma distribution
x <- 1:20
y <- rgamma(20,1,2)

# set x limit to avoid clipping at start
par(mar=c(5,4,4,4))
plot(x,y,type="b",pch=23,bg="slateblue",
     xlim=c(0,20),ylim=c(0,1.3),
     axes=FALSE,ann=FALSE)

# use sequence and take default tick labels
axis(1,at=seq(0,20,by=5))

# use mtext to add text labels in the margins
mtext("Time",1,line=3)

# use sequence and override with user labels
axis(2, at=seq(0,1.3,length=4),labels=c("low","med","high","peak"),
     las=2)

# thicken up tick lines and move axis out a bit
axis(3,at=seq(0,20,by=5),line=1,lwd=2,lwd.ticks=2,font=2)

# move the axis and ticks inward with the mgp argument
axis(4,at=seq(0,1.3,length=4),labels=c("l","m","h","p"),
     las=2,mgp=c(0,1.4,1.9),tcl=2,
     col.axis="red",col="slateblue")

# overplot the axis to easily create minor tick marks
axis(4,at=seq(0,1.3,length=7),labels=FALSE,
     mgp=c(0,1.4,1.9),tcl=0.75,
     col="slateblue")
par(opar)

#################################################
#Cleaned Up Regression
par(mar=c(5,6,2,2)+0.1)
plot(x=lat.centroid,y=n.species,
     xlab="Latitude",ylab="Number of Species",
     las=1,cex.axis=1.2,cex.lab=1.5)
reg.model <- lm(n.species~lat.centroid)
abline(reg.model)
rug(n.species,side=2)
grid()

############################################
#Text Annotations
x <- 1:5
y <- seq(1,5,1)
plot(x,y)
text(1,1,"right",pos=4) # use pos to offset the text
# use vectors for multiple plotting
plot(x,y,ann=FALSE, axes= FALSE, col="green")
box(col="gray")
text(x[-3],y[-3],c("right","top","bottom","left"),pos=c(4,3,1,2))
text(3,3,"overlay")
text(4,2,"angle = 10 degrees",srt=10)

# illustration of plot math
plot(x,y,ann=FALSE, axes= FALSE, type="n")
box(col="gray")

text(3,4,
     expression(sqrt(x[i]^2+y[i]^2)-hat(beta)))


text(3,3,
     expression(bar(x) == sum(frac(x[i], n),
                              i == 1,n)))

# alter size, color, font, and rotation
text(3,3,
     expression(bar(x) == sum(frac(x[i], n),
                              i == 1,n)),
     cex=4,col="red",font=1,srt=-10)

text(3,2,
     expression(paste("Temperature (", degree,
                      "C) in 2013")))

#######################################################
#Graphical Annotations
x <- 1:10
y <-runif(10)

plot(x,y,type="n",xlim=c(0,10),ylim=c(0,1))

points(x,y)
lines(x,y)

xspline(x,y,shape=0) # -1,0,1
xspline(x,y,shape=1,open=FALSE)
polygon(x,y,col="coral")

rect(8,0.1,10,0.2,col="blue")
rect(0,0,x,y,lty="dashed")
segments(0,1,3,0)
segments(0,0,x,y)
arrows(0,0,x,y)
points(0,0)

#######################################################
#Clean Up & Detach
detach(Ant.Data) # detach ant data
par(opar) # restore original parameters

####################################
#Panel Layout & 4 Variations On Plot Type
####################################################
# illustrating panel layout and 4 variations on plot type
Random.Data <- rnorm(20)
time <- 1:20
par(mfrow=c(3,2))
plot(Random.Data,type="p")
plot(Random.Data,type="l")
plot(Random.Data,type="b")
plot(Random.Data,type="o")
plot(Random.Data,type="s")
plot(Random.Data,type="h")

par(opar)
plot(Random.Data,type="n")

####################################################
#Special Plots With Linear Model
attach(Ant.Data)
####################################################
# illustrating special plots that come with a linear model
par(mfrow=c(2,2))
Ant.Model <- lm(n.species~lat.centroid)
summary(Ant.Model)
plot(Ant.Model)
plot(lat.centroid,n.species)
abline(Ant.Model)
abline(h=10,lty="dashed")
abline(v=45,col="red",lty="dotdash")

####################################################
#Plots In A Single Dimension
# illustrating plots for a single dimension of data
par(mfrow=c(1,2))

plot(n.species) # plots numeric data in order
plot(table(ecoregion)) # plots tabled counts of factors as lines

barplot(table(ecoregion))
Little.Data <- c(3,2,1,5,6)
names(Little.Data) <- LETTERS[1:5]
barplot(Little.Data) # plots numeric data as bar heights

pie(Little.Data) # plots numeric data as pie slices     
dotchart(Little.Data) # plots numeric data as ordered dot plots

boxplot(n.species) # plots numeric data as box plot
hist(n.species) # plots numeric data as histogram
stripchart(Little.Data) # plots numeric data in a single strip chart
plot(density(n.species)) # plots kernel density of a numeric variable

###############################################################
#Bar Plot With Custom Error Bars
ecoregion.means <- by(n.species,ecoregion,mean)

barplot(ecoregion.means,names.arg=letters[1:5],
        ylim=c(0,100))
midpoints <- barplot(ecoregion.means,plot=FALSE)
ecoregion.sd <- by(n.species,ecoregion,sd)

arrows(midpoints,ecoregion.means,midpoints,
       ecoregion.means+ecoregion.sd,angle=90,
       length=0.1)

# For a double-headed arrow, adjust starting
# points and use code=3
arrows(midpoints,ecoregion.means-ecoregion.sd,midpoints,
       ecoregion.means+ecoregion.sd,angle=90,
       length=0.1,code=3)
points(midpoints,ecoregion.means,pch=19)

# plotting points with asymmetric
# confidence intervals
par(opar)

# using the quantile function
z <- rnorm(1000)
quantile(z,probs=0.95)
hist(z)
abline(v=quantile(z,probs=c(0.05,0.95)),lty="dashed",col="red")
abline(v=quantile(z,probs=c(0.025,0.975)),lty="dotted",col="blue")

# Calculate Confidence intervals with the by function
quantile(n.species,probs=0.025)
Con.low <- by(n.species,ecoregion,quantile,probs=0.025)
Con.high <- by(n.species,ecoregion,quantile,probs=0.975)

# set up a blank plot (show code first)
plot(1:5,1:5)
plot(1:5,1:5,xlim=c(0.5,5),ylim=c(0,100))
plot(1:5,1:5,xlim=c(0.5,5),ylim=c(0,100),type="n")

# fully blank plot
plot(1:5,1:5,xlim=c(0.5,5),ylim=c(0,100),type="n",
     ,axes= FALSE,ann=FALSE)

# add axes with labels
axis(1,at=seq(1:5),labels=letters[1:5])
axis(2)
mtext("Number of Species",side=2,line=2.5)
box(bty="L")
arrows(1:5,ecoregion.means,1:5,Con.low,angle=90,length=0.1)
arrows(1:5,ecoregion.means,1:5,Con.high,angle=90,length=0.1)
points(1:5,ecoregion.means,pch=23,cex=1.5,bg="gold")
abline(h=seq(0,100,by=20),col="gray",lty="dotted")

# add minor tick marks
# first find your location in the plot
points(1,0)
points(0,0)
points(0.5,0)
par("usr") # get limits

# try plotting a point points(0.32,10)
points(0.32,10)
par("xpd")
par(xpd=TRUE) # change clippig to figure region
points(0.32,10)
# first refresh plot
segments(rep(0.32,5),seq(10,90,length=5),rep(0,5),seq(10,90,length=5))

