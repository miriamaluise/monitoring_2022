# R code for chemical cycling study
# time series of NO2 change in Europe during the lockdown
# https://www.esa.int/Applications/Observing_the_Earth/Copernicus/Sentinel-5P/Coronavirus_lockdown_leading_to_drop_in_pollution_across_Europe
# https://acp.copernicus.org/preprints/acp-2020-995/acp-2020-995.pdf

library(raster)

# Set the working directory
setwd("~/lab/en/") # Linux 
# setwd("C:/lab/en/")  # windows
# setwd("/Users/name/lab/en/") # mac

en01 <- raster("EN_0001.png")
# what is the range of the data?
# https://www.google.com/search?q=R+colours+names&tbm=isch&ved=2ahUKEwiF-77Z1bX0AhULtKQKHQ3WDWYQ2-cCegQIABAA&oq=R+colours+names&gs_lcp=CgNpbWcQAzIECAAQEzoHCCMQ7wMQJzoICAAQCBAeEBNQiQhYnwxgwg1oAHAAeACAAUqIAZYDkgEBNpgBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=vKKgYYWtOovokgWNrLewBg&bih=526&biw=1056#imgrc=OtMzJfyT_OwIiM
cl <- colorRampPalette(c('red','orange','yellow'))(100) # 

# plot the NO2 values of January 29020 by the cl palette
plot(en01, col=cl)

# Exercise: import the end of March NO2 and plot it
en13 <- raster("EN_0013.png")
plot(en13, col=cl)

# Build a multiframe window with 2 rows and 1 column with the par function
par(mfrow=c(2,1))
plot(en01, col=cl)
plot(en13, col=cl)

# import all the images
EN01 <- raster("EN_0001.png")
EN02 <- raster("EN_0002.png")
EN03 <- raster("EN_0003.png")
EN04 <- raster("EN_0004.png")
EN05 <- raster("EN_0005.png")
EN06 <- raster("EN_0006.png")
EN07 <- raster("EN_0007.png")
EN08 <- raster("EN_0008.png")
EN09 <- raster("EN_0009.png")
EN10 <- raster("EN_0010.png")
EN11 <- raster("EN_0011.png")
EN12 <- raster("EN_0012.png")
EN13 <- raster("EN_0013.png")

# plot all the data together
par(mfrow=c(4,4))
plot(EN01, col=cl)
plot(EN02, col=cl)
plot(EN03, col=cl)
plot(EN04, col=cl)
plot(EN05, col=cl)
plot(EN06, col=cl)
plot(EN07, col=cl)
plot(EN08, col=cl)
plot(EN09, col=cl)
plot(EN10, col=cl)
plot(EN11, col=cl)
plot(EN12, col=cl)
plot(EN13, col=cl)

EN <- stack(EN01, EN02, EN03, EN04, EN05, EN06, EN07, EN08, EN09, EN10, EN11, EN12, EN13)

# plot the stack altogether
plot(EN, col=cl)

# plot only the first image from the stack
# check the stack names
EN
plot(EN$EN_0001, col=cl)

# rgb
plotRGB(EN, r=1, g=7, b=13, stretch="lin")


#__________________________________day 2

#how to import all data together with the lapply function
#first build a list explaining to the software what are the images that we want to import directly with the function list.files
library(raster)
setwd("C:/lab/en/")
rlist <- list.files(pattern="EN")
rlist #is the name of our list

#now we can apply the lapply function
list_rast <- lapply(rlist, raster)
list_rast #shows all the file which have been imported

#every images together
EN_stack <- stack(list_rast)
EN_stack


cl <- colorRampPalette(c('red','orange','yellow'))(100) #
plot(EN_stack, col=cl)

#exercise: plot only the first image of the stack
plot(EN_stack$EN_0001, col=cl)

#difference between final image and the first
ENdif<- EN_stack$EN_0001 - EN_stack$EN_0013
cldif <- colorRampPalette(c('blue','white','red'))(100) #
plot(ENdif, col=cldif)

#how to use code build by others without copypasting
#automated processing source function
#importing the data from the en folder in which we saved the code that we are gonna read on r
#use the extension when you recall it on r e.g., .txt
source("R_script.txt")









