### Charlie Rolecek ### 
### Data Wrangling Project ###
### 12/7/2022 ###
### Project Topic: Formula 1 ###
### Project Script: Descriptive Analysis ###
rm(list=ls())
library(dplyr)
library(reshape2)


### Reading in final merged data set ###

formula_1_2021 <- read.csv("F1_merged_standings_pitstops.csv")
class(formula_1_2021)
str(formula_1_2021)
formula_1_2021$X <- NULL ## No need for row numbers
colnames(formula_1_2021)[15] <- "driver_final_standings"

### Cleaning data set for final time ###
formula_1_2021$race_Id <- as.numeric(formula_1_2021$race_Id)
formula_1_2021$driver_Id <- as.numeric(formula_1_2021$driver_Id)
formula_1_2021$pitstop_seconds <- as.numeric(formula_1_2021$pitstop_seconds)
formula_1_2021$stop_number <- as.numeric(formula_1_2021$stop_number)
formula_1_2021$lap_number <- as.numeric(formula_1_2021$lap_number)
formula_1_2021$race_number <- as.numeric(formula_1_2021$race_number)
#formula_1_2021$driver_number <- as.numeric(formula_1_2021$driver_number)
formula_1_2021$circut_Id <- as.numeric(formula_1_2021$circut_Id)
formula_1_2021$driver_final_standings <- as.numeric(formula_1_2021$driver_final_standings)
formula_1_2021$pitstop_seconds <- as.numeric(formula_1_2021$pitstop_seconds)
formula_1_2021$year_of_race <- as.numeric(formula_1_2021$year_of_race)

formula_1_2021$nationality <- as.factor(formula_1_2021$nationality)
formula_1_2021$driver <- as.factor(formula_1_2021$driver)
formula_1_2021$race_name <- as.factor(formula_1_2021$race_name)
formula_1_2021$driver_number <- as.factor(formula_1_2021$driver_number)

### Imputing the mean for NA's in column "pitstop_seconds ###
formula_1_2021$pitstop_seconds[is.na(formula_1_2021$pitstop_seconds)] <- mean(formula_1_2021$pitstop_seconds, na.rm = TRUE )

num_drivers <- as.numeric(length(unique(formula_1_2021$driver)))

### Group Stats by creating a table with driver names, their average pit stop time, and their final standing at the end of the season) 
t1 <- aggregate(formula_1_2021$pitstop_seconds, 
                by=list(formula_1_2021$driver), 
                FUN = mean)
colnames(t1)[1] <- "driver_name"
colnames(t1)[2] <- "average_pitstop_seconds"
t1$driver_final_standing <- unique(formula_1_2021$driver_final_standings)

summary(formula_1_2021)
summary(t1)

bartlett.test(pitstop_seconds~driver, 
              data = formula_1_2021)

t2 <- summarize(formula_1_2021, 
                driver = n(),
                Min.pitstop_seconds = min(pitstop_seconds, na.rm=TRUE),
                Max.pitstop_seconds = max(pitstop_seconds, na.rm=TRUE),
                Avg.pitstops_seconds = mean(pitstop_seconds,na.rm=TRUE))

formula_1 <- group_by(formula_1_2021, driver_Id)
class(formula_1)

t3 <- summarize(formula_1, 
                driver = n(),
                Min.pitstop_seconds = min(pitstop_seconds, na.rm=TRUE),
                Max.pitstop_seconds = max(pitstop_seconds, na.rm=TRUE),
                Avg.pitstops_seconds = mean(pitstop_seconds,na.rm=TRUE))
t3$driver <- NULL

t3

### Linear Regression ###
fit <- lm(average_pitstop_seconds ~ driver_final_standing, data = t1)
summary(fit)
cor(t1$average_pitstop_seconds, t1$driver_final_standing)

plot(average_pitstop_seconds ~ driver_final_standing, data = t1, xlab= "Diver Final Standing",  ylab = "Average Pitstop Time (seconds)")
abline(fit, col="red")

qqnorm(fit$residuals)
qqline(fit$residuals, col="red")

plot(fit$fitted.values, fit$residuals,
     xlab="Fitted Values", ylab="Residuals")

fit<- aov(pitstop_seconds~nationality, data = formula_1_2021)
summary(fit)

TukeyHSD(fit)

boxplot(pitstop_seconds~nationality,
        data=formula_1_2021,
        xlab="Nationality",
        ylab="Pitstop Time (seconds)")

### Visualization ###
plot(formula_1_2021$driver_number, # x axis
     formula_1_2021$pitstop_seconds, # y axis
     xlab="Driver Number", # x axis title
     ylab="Time at pit stops (seconds)")


plot(formula_1_2021$race_name, # x axis
     formula_1_2021$pitstop_seconds, # y axis
     xlab="Race", # x axis title
     ylab="Time at pit stops (seconds)")

boxplot(formula_1_2021$season_total_points,
        xlab = "Drivers",
        ylab = "Points Earned by Driver Throughout Season")

hist(formula_1_2021$pitstop_seconds, main = "Pit Stop Time", xlab = "Total Pit Stop Time (seconds)", col = 'blue')


group_means <- tapply(formula_1_2021$pitstop_seconds, 
                      formula_1_2021$driver, 
                      FUN = mean)
group_means
barplot(names=names(group_means),
        group_means, 
        ylab = "Average Pit Stop Time (seconds)",
        col = "forestgreen")



















