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











