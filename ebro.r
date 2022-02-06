#quantitative estimate land cover ebro delta

#library required
library(raster)
library(RStoolbox)
library(ggplot2)

#setting the working directory
setwd("C:/lab/ebro/")

#1 do the list the files available with list.files
rlist<- list.files(pattern="ebro")

#lapply: Apply a Function over a List
list_rast <- lapply(rlist, brick)
list_rast

#A raster can contain one or more bands
#A basic color image consists of three bands: red, green, and blue. 
#Each band represents light reflected from the red, green or blue portions of the electromagnetic spectrum. 
#The pixel brightness for each band, when composited creates the colors that we see in an image.

#plotting the ebro image of 1984
plotRGB(list_rast[[1]], r=1, g=2, b=3, stretch="lin")
e1984<- list_rast[[1]]
plotRGB(e1984, r=1, g=2, b=3, stretch="lin")
plotRGB(e1984, r=2, g=3, b=1, stretch="lin")
plotRGB(e1984, r=3, g=1, b=2, stretch="lin")

#plotting the ebro image of the 2021
#reassign a new name
e2021 <- list_rast[[2]]
#plot with rgb
plotRGB(e2021, r=1, g=2, b=3, stretch="lin")
plotRGB(e2021, r=2, g=3, b=1, stretch="lin")
plotRGB(e2021, r=3, g=1, b=2, stretch="lin")

#how to explain to the software where is the forest
#classifying the images according to their different reflectance
#using RStoolbox package
#using unsuperClass function

e1984c <- unsuperClass(e1984, nClasses=2)








