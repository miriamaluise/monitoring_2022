#R code for uploading and visualising copernicus data
library(ncdf4)
setwd("C:/lab/copernicus/")

library(raster)
snow20211214 <- raster("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
snow20211214
plot(snow20211214)
