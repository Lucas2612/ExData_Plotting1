#Assuming the text file is in the same directory as script

# Setting the file name
print("Setting the file name...")
fileName <- "./household_power_consumption.txt"

# Getting the first 5 rows to find colClasses
print("Getting the first 5 rows to find colClasses...")
file_5rows <- read.table(fileName, header = TRUE, nrows = 5, sep=";", as.is=c(1:2))

# Getting colClasses
print("Getting colClasses...")
classes <- sapply(file_5rows, class)

# Loading complete file
print("Loading complete file...")
household_file_all <- read.table(fileName, header = TRUE, sep=";", na.strings=c("?"), colClasses=classes)

# Filtering file
print("Filtering file...")
household_frame <- subset(household_file_all, Date=='1/2/2007' | Date=='2/2/2007')

# Converting Time Column
print("Converting Time Column...") 
household_frame[, 2] <- as.POSIXct(paste(household_frame[, 1], household_frame[, 2]), format="%d/%m/%Y %H:%M:%S")

# Converting Date Column
print("Converting Date Column...")
household_frame[, 1] <- as.Date(household_frame[, 1], "%d/%m/%Y")


# Generating PNG file
print("Generating PNG file 4...")

# Creating file
print("Creating file...")
png(filename="plot4.png", width=480, height=480, units="px")

# Plotting graphic 
print("Plotting graphic...")
par(mfrow= c(2, 2))
with(household_frame, {
plot(Time, household_frame$Global_active_power, type="s", xlab="", ylab="Global Active Power (kilowatts)")
plot(Time, household_frame$Voltage, type="s", xlab="datetime", ylab="Voltage")
plot(Time, household_frame$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
points(Time, household_frame$Sub_metering_2, type="l", col="red")
points(Time, household_frame$Sub_metering_3, type="l", col="blue")
legend("topright", pch="________",  col=c("black", "red", "blue"), bty="n", legend=c("sub_metering_1", "sub_metering_2", "sub_metering_3"))
plot(Time, household_frame$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
})

# Saving file
print("Saving file...")
dev.off()

print("Finish!!!")