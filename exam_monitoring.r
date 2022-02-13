#################################Exam project for monitoring ecosystems and functioning##################################à

#I wanted to study the changes of FCover  
#The Fraction of Vegetation Cover (FCover) corresponds to the fraction of ground covered by green vegetation. 
#Practically, it quantifies the spatial extent of the vegetation.
#comparison between 2018-2019-2020


#libraries needed
library(raster) # Raster data are saved in pixels, each one represents an area on the Earth's surface.
library(ncdf4)
library(RStoolbox)
library(ggplot2) #to make plots
library(patchwork)
library(viridis) #palette for plots
library(ggpubr) #to export ggplots

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
fcover2020 <- fcoverstack$FCOVER.1km.1

#let's plot the image from 2018
#using a viridis palette needed for raster files

viridis(3)
viridis<-colorRampPalette(viridis(3))(100) 
plot(fcover2018, col=viridis, main="Global FCOVER 2018")

#we can save and export our file with PNG and dev.off
#dev.off is used to close the procedure of exporting the image


png("fcover2018.png", width = 2500, height = 2500, res = 300) 
plot(fcover2018, col=viridis, main="Global FCOVER 2018")
dev.off()

#we can try and plot the three images with ggplot

p2018 <- ggplot() + geom_raster(fcover2018, mapping = aes(x=x, y=y, fill= FCOVER.1km.2)) + scale_fill_viridis(option="viridis") + ggtitle ("Fcover 2018")
p2019 <- ggplot() + geom_raster(fcover2019, mapping = aes(x=x, y=y, fill= FCOVER.1km.3)) + scale_fill_viridis(option="viridis") + ggtitle ("Fcover 2019")
p2020 <- ggplot() + geom_raster(fcover2020, mapping = aes(x=x, y=y, fill= FCOVER.1km.1)) + scale_fill_viridis(option="viridis") + ggtitle ("Fcover 2020")
#the p is lower 
#R is case sensitive


#to see them all together to make a quick comparison we can use the patchwork library
#i want to see them piled up vertically
p2018/p2019/p2020
fcover_comparison <- p2018/p2019/p2020

#i want to export this
#install package to export ggplots
#install.packages("ggpubr")
#library(ggpubr)
ggexport(fcover_comparison, filename= "fcovercomparison.png", width = 2500, height = 2500, res = 300)

#now i want to make a close up to the Brasil area
#i need the crop function to search for the data in a specific region
#to do so i have to put the coordinates for longitude and latidute
#Brazil is located at latitude from
#
#and longitude from
ext <- c()
crop2018 <- crop(fcover2018, ext)
crop2020 <- crop(fcover2020, ext)

#plotting again with ggplot

c2018<- ggplot() + geom_raster(crop2018, mapping = aes(x=x, y=y, fill= FCOVER.1km.2)) + scale_fill_viridis(option="viridis") + ggtitle ("Fcover Brasil 2018")

c2020 <- ggplot() + geom_raster(crop2020, mapping = aes(x=x, y=y, fill= FCOVER.1km.1)) + scale_fill_viridis(option="viridis") + ggtitle ("Fcover Brasil 2020")



































