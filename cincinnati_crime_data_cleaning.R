# Acquainting yourself with the data --------------------------------------

# Set the working directory
setwd("D:/College/Courses/Data Wrangling/Week 1")


# Import the data ---------------------------------------------------------
crime_data <- read.csv("week1_cincy_crimes.csv", header = TRUE, stringsAsFactors = FALSE)

# Display the first ten rows
head(crime_data, n = 10)

# Examine the structure
str(crime_data)


# Change the names of columns in the dataset
names(crime_data) <- c("instance_id","status","mode_of_break_in","day_of_week",
                       "victim_gender","total_number_victims","total_suspects")

# Verifying if names are assigned correctly
names(crime_data)

# Missing values per column
colSums(is.na(crime_data))


# Cleaning the data -------------------------------------------------------

# Unique observations in the data frame
crime_data_clean <- unique(crime_data)

# Unique values in each column
unique(crime_data_clean$status)
unique(crime_data_clean$mode_of_break_in)
unique(crime_data_clean$day_of_week)
unique(crime_data_clean$victim_gender)
unique(crime_data_clean$total_number_victims)
unique(crime_data_clean$total_suspects)

# Recoding the values for status column
crime_data_clean$status[is.na(crime_data_clean$status)] <- "U--UNKNOWN"

# QA Check
unique(crime_data_clean$status)

# Recoding the values for mode_of_break_in column
crime_data_clean$mode_of_break_in[crime_data_clean$mode_of_break_in == "??"] <- NA

# QA Check
unique(crime_data_clean$mode_of_break_in)

# Recoding the values for day_of_week
crime_data_clean$day_of_week[is.na(crime_data_clean$day_of_week)] <- "UNKNOWN"

# QA Check
unique(crime_data_clean$day_of_week)


# Recoding the values of the victim_gender variable
crime_data_clean$victim_gender[crime_data_clean$victim_gender == "F - FEMALE"] <- "FEMALE"
crime_data_clean$victim_gender[crime_data_clean$victim_gender == "M - MALE"] <- "MALE"
crime_data_clean$victim_gender[crime_data_clean$victim_gender == "NON-PERSON (BUSINESS"] <- "BUSINESS"

# QA Check
unique(crime_data_clean$victim_gender)


# Identifying outliers/aberrant values
outlier_victim <- boxplot(crime_data_clean$total_number_victims, main = "Total Number of Victims")$out
unique(outlier_victim)

outlier_suspects <- boxplot(crime_data_clean$total_suspects, main = "Total number of Suspects")$out
unique(outlier_suspects)

# Frequency table
table(crime_data_clean$total_number_victims)
table(crime_data_clean$total_suspects)

# Summary Statistics
summary(crime_data_clean$total_number_victims)
summary(crime_data_clean$total_suspects)


# Exploratory Data Analysis -----------------------------------------------

# Filtering the unique status values for each instance id
crime_status_filter <- unique(crime_data_clean[c("instance_id","status")])

# Plot the Status variable
plot(factor(crime_status_filter$status), main = "Status of the Reported Cases", xlab = "Status", ylab="Frequency",
    ylim = c(0,6000))

# Filtering the unique mode of break in values for each instance id
crime_mode_filter <- unique(crime_data_clean[c("instance_id","mode_of_break_in")])

# Mode of break in
plot(factor(crime_mode_filter$mode_of_break_in), main = "Mode of Break-In for Reported Cases", 
     xlab = "Mode of Break In", ylab="Frequency", ylim = c(0,700))

# Filtering the unique days on which the incident occured for each instance id
crime_day_filter <- unique(crime_data_clean[c("instance_id","day_of_week")])
# Day of Week
plot(factor(crime_day_filter$day_of_week), main = "Days on which the incident occured", 
     xlab = "Days", ylab="Frequency", ylim = c(0,2500))

# Victim Gender
plot(factor(crime_data$victim_gender), main = "Incidents by Victim Genders", 
     xlab = "Gender", ylab="Frequency", ylim = c(0,12000))

# Filtering the total suspects for each instance id
crime_suspects_filter <- unique(crime_data[c("instance_id","total_suspects")])

# Total Suspects
hist(crime_suspects_filter$total_suspects, main = " Frequency of total suspects", xlab = "Number of Suspects",
     ylim = c(0,7000))

# Filtering the total victims for each instance id
crime_victim_filter <- unique(crime_data[c("instance_id","total_number_victims")])
# Total Victims

# Plotting total victims
with(subset(crime_victim_filter, total_number_victims < 10), 
     hist(total_number_victims, main = " Frequency of total victims", xlab = "Number of Victims",
                                                                      ylim = c(0,15000)))

