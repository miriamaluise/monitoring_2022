#################################Exam project for monitoring ecosystems and functioning##################################à

#I wanted to study the changes of FCover  
#The Fraction of Vegetation Cover (FCover) corresponds to the fraction of ground covered by green vegetation. 
#Practically, it quantifies the spatial extent of the vegetation.
#comparison between 2018-2019-2020


#libraries needed
library(raster) # Raster data are saved in pixels, each one represents an area on the Earth's surface.
library(ncdf4)
library(RStoolbox)
library(ggplot2)
library(patchwork)
library(viridis)

#setting the working directory
setwd("C:/lab/fcover/")

#import all data together with the lapply function
#first build a list explaining to the software what are the images that we want to import directly with the function list.files

#making a list with the list.files function 
#to use the list.files we chose the similar patter of our data
list.files(pattern= "c_gls_FCOVER")
then we assign a name to our list
rlist <- list.files(pattern= "c_gls_FCOVER")
#to recall it just digit
rlist

#appliyng the lapply function 
list_rast <- lapply(rlist, raster)
list_rast #shows all the file which have been imported

#creating a stack to have all images together
stack(list_rast)
#assignin a name to it
fcoverstack <- stack(list_rast)
fcoverstack

#in R after checking fcoverstack we can notice that the names our our files are too long
#Fraction.of.green.Vegetation.Cover.1km.1, Fraction.of.green.Vegetation.Cover.1km.2, Fraction.of.green.Vegetatation.Cover.1km.3 

#we could rename them in this way
names(fcoverstack) <- c("FCOVER.1km.1", "FCOVER.1km.2", "FCOVER.1km.3")
#if we check fcoverstack now the names are these one less longer

#now we can separate the files and assign a name to the stack elements
fcover2018 <- fcoverstack$FCOVER.1km.2
fcover2019 <- fcoverstack$FCOVER.1km.3
fcover2020 <- fcoverstack$FCOVER.1km.3

#let's plot the image from 2018
#using a viridis palette needed for raster files

viridis(3)
viridis<-colorRampPalette(viridis(3))(100) 
plot(fcover2018, col=viridis, main="Global FCOVER 2018")


#trials

png("fcover2018.png", width = 2500, height = 2500, res = 300) #no
plot(fcover2018, col=viridis, main="Global FCOVER 2018")
dev.off

#we can save and export our file with PNG and dev.off
#dev.off is used to close the procedure of exporting the image
png(file="Global FCOVER 2018.png", units="cm")#no
plot(fcover2018, col=viridis)
dev.off

png(filename = "fcover2018",
    width = 480, height = 480, units = "px", pointsize = 12,
     bg = "white",  res = NA, …,)

































