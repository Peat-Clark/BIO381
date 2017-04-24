library(vegan)
data(varespec)
data(varechem)
ord <- metaMDS(varespec)
plot(ord, type = "t")

plot(0:10,0:10,type="n",axes=F,xlab="Abundance of Species 1",ylab="") 
axis(1)
points(5,0); text(5.5,0.5,labels="community A")
points(3,0); text(3.2,0.5,labels="community B")
points(0,0); text(0.8,0.5,labels="community C")

plot(0:10,0:10,type="n",xlab="Abundance of Species 1",
     ylab="Abundance of Species 2")
points(5,5); text(5,4.5,labels="community A")
points(3,3); text(3,3.5,labels="community B")
points(0,5); text(0.8,5.5,labels="community C")

#install.packages("scatterplot3d")
library(scatterplot3d)
d=scatterplot3d(0:10,0:10,0:10,type="n",xlab="Abundance of Species 1",
                ylab="Abundance of Species 2",zlab="Abundance of Species 3"); d
d$points3d(5,5,0); text(d$xyz.convert(5,5,0.5),labels="community A")
d$points3d(3,3,3); text(d$xyz.convert(3,3,3.5),labels="community B")
d$points3d(0,5,5); text(d$xyz.convert(0,5,5.5),labels="community C")

browseVignettes("vegan")



data(varespec)
head(varespec)
sptrans <- decostand(varespec, "max")
apply(sptrans, 2, max)
sptrans <- wisconsin(varespec)
sptrans <- decostand(varespec, "chi.square")
plot(procrustes(rda(sptrans), cca(varespec)))




set.seed(2)
community_matrix=matrix(
  sample(1:100,300,replace=T),nrow=10,
  dimnames=list(paste("community",1:10,sep=""),paste("sp",1:30,sep="")))
head(community_matrix)
example_NMDS=metaMDS(community_matrix, # Our community-by-species matrix
                     k=2) # The number of reduced dimensions. Incress if high stress is problem

plot(example_NMDS)

ordiplot(example_NMDS,type="n")
orditorp(example_NMDS,display="species",col="red",air=0.01)
orditorp(example_NMDS,display="sites",cex=1.25,air=0.01)

treat=c(rep("Treatment1",5),rep("Treatment2",5))
ordiplot(example_NMDS,type="n")
ordihull()
ordihull(example_NMDS,groups=treat,draw="polygon",col="grey90",label=F)
orditorp(example_NMDS,display="species",col="red",air=0.01)
orditorp(example_NMDS,display="sites",col=c(rep("green",5),rep("blue",5)),
         air=0.01,cex=1.25)

ordiplot(example_NMDS,type="n")
ordispider(example_NMDS,groups=treat)
orditorp(example_NMDS,display="species",col="red",air=0.01)
orditorp(example_NMDS,display="sites",col=c(rep("green",5),rep("blue",5)),
         air=0.01,cex=1.25)

ordiplot(example_NMDS,type="n")
ordiellipse(example_NMDS,groups=treat,col="grey",label=F)
orditorp(example_NMDS,display="species",col="red",air=0.01)
orditorp(example_NMDS,display="sites",col=c(rep("green",5),rep("blue",5)),
         air=0.01,cex=1.25)

# Define random elevations for previous example
elevation=runif(10,0.5,1.5)
# Use the function ordisurf to plot contour lines
ordisurf(example_NMDS,elevation,main="",col="forestgreen")
# Finally, display species on plot
orditorp(example_NMDS,display="species",col="grey30",air=0.1,
         cex=1)
