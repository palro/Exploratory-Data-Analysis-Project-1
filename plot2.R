## Step1 : Download zip file from given link
if(!file.exists("./data")){dir.create("data")}
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl1, destfile = "./data/Electric Power Consumption.zip")

## Step2 : Unzip contents
ZipContent <- unzip("./data/Electric Power Consumption.zip", exdir="./Project1")

## Step3 : Load only data from the dates 2007-02-01 and 2007-02-02
Datafile <- file("./Project1/household_power_consumption.txt")
Feb_twodays <- read.table(text = grep("^[1,2]/2/2007", readLines(Datafile), value=TRUE), sep=';',na.strings='?',col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##Step4 : Convert to Date/Time classes
Feb_twodays$Date <- as.Date(Feb_twodays$Date, format = "%d/%m/%Y")
Feb_twodays$Datetime <- as.POSIXct(paste(Feb_twodays$Date, Feb_twodays$Time))
Feb_twodays[,1:2] <- list(NULL)
Feb_twodays <- Feb_twodays[, c(8,1:7)]

##Step6 : Plot 2: Clear any plots on current graphics device, change system language in local domain to English , create scatter plot , copy to png file, close device
graphics.off()
Sys.setlocale("LC_ALL", "English")
plot(Feb_twodays$Datetime, Feb_twodays$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()