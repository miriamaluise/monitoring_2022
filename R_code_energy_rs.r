#R code for estimating energy in the ecosystem
library(raster)
setwd("C:/lab/")
#install.packages("rgdal")
library(rgdal)
#importing the data
l1992 <- brick("defor1_.jpg")
l1992

#Bands: defor1_.1, defor1_.2, defor1_.3
#plotRGB
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")


#______________________________________________day 2
l2006 <-brick("defor2_.jpg")
l2006
#let's plot the image from 2006
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")


#par
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")

#calculate the energy in 1992
dev.off() #to calcel previous plotting
dvi1992 <-l1992$defor1_.1 -l1992$defor1_.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1992,col=cl)

#calculating the energy lost in 2006
dvi2006 <- l2006$defor2_.1 - l2006$defor2_.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi2006, col=cl)
#Why is used the yellow colour? will catch immidiately your eyes

#differencing two images of energy in two different times
dvidif <-dvi1992 - dvi2006
#plot the results
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(dvidif, col=cld)

#final plot: original images, dvis, dvi differences
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)

pdf("energy.pdf") #to save all the stuff as a pdf
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off()

pdf("dvi.pdf")
par(mfrow=c(3,1))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off() 















