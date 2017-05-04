
xVar <- as.factor(rep(c("1-Con","2-Pluv.","3-Amb.","4-Mod.","5-Sev.",
                        "6-Ext."),each=20))
set.seed(2)
cT <- rnorm(n=20, mean=90, sd=20)
pT <- rnorm(n=20, mean=150, sd=20)
aT <- rnorm(n=20, mean=100, sd=15)
sT <- rnorm(n=20, mean=70, sd=12)
mT <- rnorm(n=20, mean=40, sd=15)
eT <- rnorm(n=20, mean=5, sd=20)

yVar <- c(cT,pT,aT,sT,mT,eT)

dataFrame <- data.frame(xVar,yVar)

boxplot(yVar~xVar,data=dataFrame,col=c("grey", "blue", "light blue",
                                       "orange", "red", "dark red"),main = "Response to Precipitation Treatment",
        xlab = "Treatment", ylab = "Response Variable")

#################


xVar <- as.factor(rep(c("1-Small","2-Medium","3-Large",
                        "1-Small2","2-Medium2","3-Large2",
                        "1-Small3","2-Medium3","3-Large3"),each=20))

set.seed(2)
sm <- rnorm(n=20, mean=50, sd=22)
me <- rnorm(n=20, mean=30, sd=10)
la <- rnorm(n=20, mean=5, sd=15)
sm2 <- rnorm(n=20, mean=50, sd=22)
me2 <- rnorm(n=20, mean=30, sd=10)
la2 <- rnorm(n=20, mean=5, sd=15)
sm3 <- rnorm(n=20, mean=50, sd=22)
me3 <- rnorm(n=20, mean=30, sd=10)
la3 <- rnorm(n=20, mean=5, sd=15)

yVar <- c(sm,me,la,sm2,me2,la2,sm3,me3,la3)
yVar

dataFrame <- data.frame(xVar,yVar)

boxplot(yVar~xVar,data=dataFrame,col=c("grey"),main = "Seed size v. Drought",
        xlab = "Seed Size", ylab = "Response Variable")

#################


xVar <- as.factor(rep(c("1-ACSA","2-BEAL","3-QURU","4-POGR",
                        "5-PRSE", "6-TSCA","7-ACRU","8-CADE"),each=20))

set.seed(2)
sm <- rnorm(n=20, mean=20, sd=5)
me <- rnorm(n=20, mean=0, sd=10)
la <- rnorm(n=20, mean=-20, sd=30)
sm2 <- rnorm(n=20, mean=-5, sd=15)
me2 <- rnorm(n=20, mean=0, sd=10)
la2 <- rnorm(n=20, mean=20, sd=15)
sm3 <- rnorm(n=20, mean=-10, sd=10)
sm4 <- rnorm(n=20, mean=0, sd=20)


yVar <- c(sm,me,la,sm2,me2,la2,sm3,sm4)
yVar

dataFrame <- data.frame(xVar,yVar)

boxplot(yVar~xVar,data=dataFrame,col=c("grey"),main = "Optimal P for Germination",
        xlab = "Species", ylab = "% P", ylim=c(-100,100))


#################


xVar <- as.factor(rep(c("1-small","2-medium","3-large"),each=20))

set.seed(2)
sm <- rnorm(n=20, mean=20, sd=20)
me <- rnorm(n=20, mean=0, sd=30)
la <- rnorm(n=20, mean=-20, sd=40)


yVar <- c(sm,me,la)
yVar

dataFrame <- data.frame(xVar,yVar)

boxplot(yVar~xVar,data=dataFrame,col=c("grey"),main = "Optimal Precip for Germination",
        xlab = "Seed size / density", ylab = "% P", ylim=c(-100,100))

##########
xVar <- as.factor(rep(c("1-Locally Adapted","2-Future Adapted"),each=20))

set.seed(2)
sm <- rnorm(n=20, mean=10, sd=10)
me <- rnorm(n=20, mean=-30, sd=20)

yVar <- c(sm,me)
yVar

dataFrame <- data.frame(xVar,yVar)

boxplot(yVar~xVar,data=dataFrame,col=c("grey"),main = "Optimal Precip for Germination",
        xlab = "'Provenance'", ylab = "% P", ylim=c(-100,100))

#############
x <- 1:10
y <-1:10

plot(x,y,type="n",xlim=c(0,10),ylim=c(0,10))

lines(x,y)



###########


###################################################
# use all of this to combine graphic elements

# set up plotting regions

par(opar)
layout(matrix(c(2,0,1,3),nrow=2,byrow=TRUE),
       heights=c(1,8),widths=c(8,1))
layout.show(3)
########################################################
# create some skewed data and sort it
x <- sort(rgamma(100,shape=2,scale=1))
y <- sort(rgamma(100,shape=2,scale=1),decreasing=TRUE)

########################################################
# generate the basic scatterplot
par(mar=c(4,5,0,0))
plot(x,y,ann=FALSE,cex=2,pch=21,bg="cornflowerblue", xlab = "test")

par(mar=c(0,5,0,0))
#par(bty="n")
#par(xaxt="n")


boxplot(x,names=FALSE,horizontal=TRUE,col="cornflowerblue")
par(mar=c(4,0,0,0))

#par(yaxt="n")
boxplot(y,names=FALSE, horizontal=FALSE,col="cornflowerblue")

