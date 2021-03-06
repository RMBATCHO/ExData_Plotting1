#Unzip file and upload the data.
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep=";", na.strings="?")
unlink(temp)

# Subset the data from the dates 2007-02-01 and 2007-02-02.
subdata <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

# Convert the Date and Time variables to Date/Time classes.
subdata$datetime <- paste(subdata$Date, subdata$Time)
subdata$datetime <- strptime(subdata$datetime, "%d/%m/%Y %H:%M:%S")

# Plot histogram for Global Active Power     
par(mar=c(5,5,2,1), oma=c(0,1,0,0))
hist(subdata$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)", las = 2)

# Save plot as PNG
dev.copy(png,"plot1.png",width=480,height=480,units="px")
dev.off()