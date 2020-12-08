# Load packages
library(tidyverse)
library(lubridate)
library(readr)


# Download and import the dataset

filename <- "data.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("data")) { 
  unzip(filename) 
}

# Import data
data <- read_delim("household_power_consumption.txt",
                   delim = ";",
                   na    = c("?"),
                   col_types = list(col_date(format = "%d/%m/%Y"),
                                    col_time(format = ""),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number()
                                                ))
# subset 2 days only

date2 <- data %>% filter(Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))

#combine date and time
date2 <- mutate(date2, dt = ymd_hms(paste(Date, Time)))


plot(Sub_metering_1 ~ dt, date2, type = "l",
     ylab = "Energy sub metering",
     xlab = NA)

lines(Sub_metering_2 ~ dt, date2, type = "l", col = "red")

lines(Sub_metering_3 ~ dt, date2, type = "l", col = "blue")

legend("topright",
       col = c("black",
               "red",
               "blue"),
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       lty = 1)


# save plot
dev.copy(png, "plot3.png",
         width  = 480,
         height = 480)

dev.off()

# done



                                         