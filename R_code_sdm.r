#R code for species distribution modelling, namely the distribution of individual 

library(sdm)
library(raster) #predictors
library(rgdal) #species

#system.file function shows all the files in a certain package
file <- system.file("external/species.shp", package="sdm")
file
#you will see the path in which are the data

#shapefile function exactly as the raster function for raster files
species <- shapefile(file)
plot(species, pch=17, col="blue")
