# Checking working directory
getwd()


library(readxl)

# Reading data
excel_sheets("mbta.xlsx")
mbta <- read_excel("mbta.xlsx", sheet = "Sheet1", skip = 1)

# Structure, top 6 columns and summary of data
str(mbta)
head(mbta)
summary(mbta)

# Removing row 1,7 & 11 and column 1
mbta_clean <- mbta[-c(1,7,11), -1]

# Transforming the wide data set into long
mbta_long <- gather(mbta_clean, Month, thou_riders, -mode)
head(mbta_long)

# Converting thou_riders into numeric type
mbta_long$thou_riders <- as.numeric(mbta_long$thou_riders)

# Validating column types
head(mbta_long)

# Spreading the data
mbta_ads <- spread(mbta_long, mode, thou_riders)

# QC
head(mbta_ads)
names(mbta_ads)

# Separating the "Month" column into "Year" and "Month" columns
mbta_final <- separate(mbta_ads, Month, c("Year", "Month"), sep = "-")
head(mbta_final)

# Summary, Histogram and Boxplot of final data
summary(mbta_final)
hist(mbta_final$Boat)
boxplot(mbta_final$Boat)$out

# Filtering Outlier
filter(mbta_final, Boat == 40)

# Changing outlier
mbta_final$Boat[mbta_final$Boat == 40] <- 4

# Summary, Histogram and Boxplot of final dataset
summary(mbta_final)
hist(mbta_final$Boat)
boxplot(mbta_final$Boat)$out
