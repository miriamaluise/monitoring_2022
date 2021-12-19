#R code for uploading and visualising copernicus data
library(ncdf4)
setwd("C:/lab/copernicus/")

library(raster)
snow20211214 <- raster("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
snow20211214
plot(snow20211214)

#___________________________________day 2
library(ncdf4)
setwd("C:/lab/copernicus/")
library(raster)
snow20211214 <- raster("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
snow20211214
plot(snow20211214)

cl <- colorRampPalette(c('dark blue','blue','light blue'))(100)
plot(snow20211214, col=cl)

install.packages("viridis")
library(viridis)
library(RStoolbox)
library(ggplot2)
#ggplot function
ggplot() +
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent))

#ggplot function with viridis
ggplot() +
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
scale_fill_viridis()

ggplot() +
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
scale_fill_viridis(option="inferno")

ggplot() +
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
scale_fill_viridis(option="cividis") +
ggtitle("cividis palette")

#_____________________________________________________day 3
library(ncdf4)
library(raster)
library(viridis)
library(RStoolbox)
library(ggplot2)
library(patchwork)
setwd("C:/lab/copernicus/")

#1 list the files
#2 apply the raster function to the list with lapply function
#3 make a stack

rlist <- list.files(pattern="SCE") #1
list_rast <- lapply(rlist, raster) #2
list_rast
#the stack will put all the data together
snowstack <- stack(list_rast) #3
snowstack

ssummer <- snowstack$Snow.Cover.Extent.1
swinter <- snowstack$Snow.Cover.Extent.2 

p1 <- ggplot() +
geom_raster(ssummer, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during Professor Rocchini's birthday")

#ggplot is going to apply quadratic images
p2 <- ggplot() +
geom_raster(swinter, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during winter")

#now patchwork
#first, assign the 2 plots to an object
#if you haven't put the patchwork package, recall it with the library
p1 / p2

#how to crop the data in a specif region
#see the coordinates
#longitude from 0 to 20
#latitude from 30 to 50
ext <- c(0, 20, 30, 50)
ssummer_cropped <- crop(ssummer, ext)
swinter_cropped <- crop(swinter, ext)

p1 <- ggplot() +
geom_raster(ssummer_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during Professor Rocchini's birthday")

p2 <- ggplot() +
geom_raster(swinter_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during winter")

p1/p2






















