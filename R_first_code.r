# This is my first code in GitHub

#Here are the imputs data
#Costanza data on streams
 water <-c(100, 200, 300, 400, 500)
 water
#the c stands for combine and it's used to combine arguments in a function
#<- is used to assign a value to a name
 
 #Marta data on fishing genomes
 fishes <- c(10, 50, 60, 100, 200)
 fishes
 
 #plot the diversity of fishes (y) versus the amount of water (x)
 plot(water, fishes)
#using the plot function and inside the parenthesis as arguments the things you want to plot

#data we developed can be stored in a table (grafico)
#table in R is called data frame

streams <-data.frame(water, fishes)

#From now on we are going to import and/or export data
#setting the working directory
setwd("C:/lab")

#Let's export our table!
write.table(streams, file="my_first_table.txt")

#Some colleagues did sent us a table, how to import it on R?
read.table("my_first_table.txt")
#Let's assign it to an object inside R
miriamtable <- read.table("my_first_table.txt")

#the first statistics for lazy beautiful people
summary(miriamtable) #shows the statistics

#Marta does not like water
#Marta wants to get info only on fishes
#we can choose to just see one object among a table/list/other by using the $ sign
summary(miriamtable$fishes)

#how to make a histogram
hist(miriamtable$fishes)
hist(miriamtable$water)


