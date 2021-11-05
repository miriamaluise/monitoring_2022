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


#________day 2
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






