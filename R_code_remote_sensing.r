#R code for ecosystem monitoring by remote sensing

#First of all, we need to install additional packages

#raster package to manage image data

#https://cran.r-project.org/web/packages/raster/index.html
install.packages("raster")


library(raster)
setwd("C:/lab/")
#we are going to import satellite data
l2011 <- brick("p224r63_2011.grd")
#objects cannot be numbers

plot(l2011)
#B1 is the refecltance in the blue bend
#B2 is the reflectance in the green bend
#B3 is the reflectance in the red bend

cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(l2011,col=cl)
plotRGB(l2011, r=3, g=2, b=1,stretch="Lin")


#_____________________________________________________________________________________________________________________________________day 2
#B1 is the refecltance in the blue bend
#B2 is the reflectance in the green bend
#B3 is the reflectance in the red bend
#B4  is the reflectance in the NIR bend

#let's plot the green bend
plot(l2011$B2_sre)
cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(l2011$B2_sre, col=cl)

#change the colorRampPalette with dark green, green and light green, e.g clg
clg <- colorRampPalette (c("dark green", "green", "light green")) (100)
plot(l2011$B2_sre, col=clg)

#do the same with the blue bend using "dark blue", "blue" and "light blue"
#B1
plot(l2011$B1_sre)
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(l2011$B1_sre, col=clb)

#plot both images in one multiframe graph
par(mfrow=c(1,2)) #the first number is the number of rows in the multiframe, the second number is the number of colomns
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

#plot both images in just one multiframe graph with 2 rows and one colomn
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)


#_____________________________________________________________________________________________________________________day 3
plot(l2011$B1_sre) #blue wavelenght
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(l2011$B1_sre, col=clb)
#let's plot the green bend
plot(l2011$B2_sre)
clg <- colorRampPalette (c("dark green", "green", "light green")) (100)
plot(l2011$B2_sre, col=clg)


# multiframe
par(mfrow=c(1,2)) # the first number is the number of rows in the multiframe, while the second one is the mnumber of columns

# plot the blue and the green besides, with different colorRampPalette
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)
par(mfrow=c(2,1)) # the first number is the number of rows in the multiframe, while the second one is the mnumber of columns


# plot the blue and the green besides, with different colorRampPalette
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

par(mfrow=c(2,2)) # the first number is the number of rows in the multiframe, while the second one is the mnumber of columns

# Exercise: plot the first four bands with two rows and two columns
par(mfrow=c(2,2)) # the first number is the number of rows in the multiframe, while the second one is the mnumber of columns

clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

clr <- colorRampPalette(c("dark red","red","pink"))(100)
plot(l2011$B3_sre, col=clr)

#we should clean the window with the function dev.off()
dev.off()
#plotRGB function
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
#we insert the NIR
plotRGB(l2011,r=4, g=3, b=2, stretch="Lin") #false colour
#let's put the NIR in the green 
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
#let's put the NIR in the blue
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")

#multiframe with all these images
par(mfrow=c(2,2))
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")



#_______________________________________________________________________________day 4, final day on this tropical forest reserve
library(raster)
setwd("C:/lab/")
l2011 <- brick("p224r63_2011.grd")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

#importing past data
#the first character is an L   l1988 <- brick("p224r63_1988.grd")
par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")

#put the NIR in the blue channel
par(mfrow=c(2,1))
plotRGB(l1988, r=2, g=3, b=4, stretch="Lin")
plotRGB(l2011, r=2, g=3, b=4, stretch="Lin")















