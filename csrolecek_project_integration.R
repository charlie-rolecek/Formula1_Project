### Charlie Rolecek ### 
### Data Wrangling Project ###
### 12/7/2022 ###
### Project Topic: Formula 1 ###
### Project Script: Integration ### 

rm(list=ls()) 

library(lubridate)
### Reading in scraped Wikipedia table documenting the 2021 World Drivers Championship Standing
champ_standing_2021 <- read.csv("champ_table.csv") 
champ_standing_2021

### Cleaning up scraped table ### 
champ_standing_2021$X <- NULL ### Duplicated Column of Position
colnames(champ_standing_2021)[1] <- "position"
colnames(champ_standing_2021)[2] <- "driver"
colnames(champ_standing_2021)[25] <- "points"
champ_standing_2021[3:24] <- NULL ### Removing placement at each race

### Reading Open Formula 1 Data From Kaggle ###
historical_pit_stops <- read.csv("pit_stops.csv")
historical_drivers <- read.csv("drivers.csv")
historical_races <- read.csv("races.csv")

### Horizontal merge is required based of shared driverId value in pit_stops and drivers ###
drivers_pit_stops <- merge(historical_pit_stops, historical_drivers, by='driverId')

### Combining Forename and Surname to driver to match scraped table from Wikipedia to allow for horizontal merge
drivers_pit_stops$driver <- paste(drivers_pit_stops$forename, drivers_pit_stops$surname, sep=" ")
drivers_pit_stops$forename <- NULL
drivers_pit_stops$surname <- NULL
drivers_pit_stops$url <- NULL

### Horizontal merge to add races to drives_pit_stops ###
races_drivers_pit_stops <- merge(drivers_pit_stops, historical_races, by='raceId')
races_drivers_pit_stops

### Cleaning merged data set ### 
races_drivers_pit_stops$fp1_date <- NULL
races_drivers_pit_stops$fp1_time <- NULL
races_drivers_pit_stops$fp2_date <- NULL
races_drivers_pit_stops$fp2_time <- NULL
races_drivers_pit_stops$fp3_date <- NULL
races_drivers_pit_stops$fp3_time <- NULL
races_drivers_pit_stops$quali_date <- NULL
races_drivers_pit_stops$quali_time <- NULL
races_drivers_pit_stops$sprint_date <- NULL 
races_drivers_pit_stops$sprint_time <- NULL
races_drivers_pit_stops$url <- NULL
races_drivers_pit_stops$time.x <- NULL
races_drivers_pit_stops$time.y <- NULL
races_drivers_pit_stops$driverRef <- NULL 
races_drivers_pit_stops$code <- NULL

colnames(races_drivers_pit_stops)[1] <- "race_Id"
colnames(races_drivers_pit_stops)[2] <- "driver_Id"
colnames(races_drivers_pit_stops)[3] <- "stop_number"
colnames(races_drivers_pit_stops)[4] <- "lap_number"
colnames(races_drivers_pit_stops)[5] <- "pitstop_seconds"
colnames(races_drivers_pit_stops)[6] <- "pitstop_milliseconds"
colnames(races_drivers_pit_stops)[7] <- "driver_number"
colnames(races_drivers_pit_stops)[8] <- "date_of_birth"
colnames(races_drivers_pit_stops)[9] <- "nationality"
colnames(races_drivers_pit_stops)[10] <- "driver"
colnames(races_drivers_pit_stops)[11] <- "year_of_race"
colnames(races_drivers_pit_stops)[12] <- "race_number"
colnames(races_drivers_pit_stops)[13] <- "circut_Id"
colnames(races_drivers_pit_stops)[14] <- "race_name"

### Reordering Columns ###
formula1_pitstops <- races_drivers_pit_stops[, c(1, 14, 2, 10, 5, 6, 3, 4, 11, 12, 7, 8, 9, 13)]
min(formula1_pitstops$pitstop_milliseconds)
max(formula1_pitstops$pitstop_milliseconds)

### Creating New Data Sets sub-setting certain parameters ###
formula1_pitstops_2021 <- subset(formula1_pitstops, year_of_race == 2021)

### pitstop.csv, drivers.csv, races.csv merged to create formula1_pitstops_2021 
### and scraped Wikipedia table named champ_standing_2021
champ_standing_pitstops_2021 <- merge (formula1_pitstops_2021, champ_standing_2021, by = "driver")

### Cleaning Final Merged Data Set ### 
colnames(champ_standing_pitstops_2021)[16] <- "season_total_points"
colnames(champ_standing_pitstops_2021)[15] <- "race_poistion"

write.csv(champ_standing_pitstops_2021, "F1_merged_standings_pitstops.csv")












