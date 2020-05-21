###############################################################################
# 02b_script.R
# Script to follow in-class examples
###############################################################################

###############
# Data Import #
###############


# Importing .csv files ----------------------------------------------------

# Base R
read.csv("data/flights.csv")

# Load package readr
library(readr)
readr::read_csv("data/flights.csv")

# Load package data.table
library(data.table)
fread("data/flights.csv")



# Importing Excel files ---------------------------------------------------

# import packages
library(readxl)

# identify the sheet you want
excel_sheets("data/mydata.xlsx")

# now read in the data
read_excel("data/mydata.xlsx", sheet = "PICK_ME_FIRST!")

setwd('D:/MS BANA/Fall sem/Data Wrangling 7025/Week 2')


install.packages("readxl")
library(readxl)

?read_excel
aircraft <- read_excel('aircraft.xlsx', sheet = "Trainers", skip = 4)
attach(aircraft)

class(FY)
summary(aircraft)

unique(aircraft$MD)
table(aircraft$MD)

unique(aircraft$FY)
table(aircraft$FY)

summary(aircraft$FH)
quantile(aircraft$FH, 0.9)

range(aircraft$Cost)
diff(range(aircraft$Cost))

hist(FH, breaks=100)
?hist

boxplot(FH~MD)

plot(factor(FY))
barplot(table(FY))


library(readr)
url <- "http://academic.udayton.edu/kissock/http/Weather/gsod95-current/OHCINCIN.txt"
weather <- read_table(url, col_names = F)
?read_table

names(weather) <- c('Month', 'Day', 'Year', 'Temp')
names(weather)

summary(weather)
detach(aircraft)
attach(weather)

max(Temp)
min(Temp)
weather$Temp[weather$Temp == -99] <- NA
?min
summary(weather)

boxplot(Temp~Month)
