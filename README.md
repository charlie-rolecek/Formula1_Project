# Formula 1 Pit Stop Analysis

In this project, I analyzed Formula 1 race data along with the 2021 Formula 1 World Drivers Championship Standings to examine the relation between the duration of driver’s pit stops and the driver’s final placement within the standings to better understand how minimal mistakes can shape the result of the season.

## Data Sources

The data used for this analysis was obtained from the [Kaggle](https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020) and [Wikipedia](https://en.wikipedia.org/wiki/2021_Formula_One_World_Championship) which provides access to historical Formula 1 data in a structured format.

## Analysis Methods

I used R to extract, transform and load the data from the Ergast API, and to perform statistical analysis and visualization of the data. Specifically, I used the following libraries:

- `dplyr` for data manipulation and filtering
- `ggplot2` for data visualization

## Results

My analysis found a statistically significant correlation between the duration of pit stops and a driver’s final placement within the standings. Drivers who had shorter pit stops tended to finish higher in the standings, while drivers who had longer pit stops tended to finish lower, not only in each race but also within the final driver standings.

## Repository Contents

This repository contains the following files:

- `csrolecek_project.RData` - R code output environment for this project
- `csrolecek_project_scraping.R` - R code to scrape the 2021 Drivers Championship Table from Wikipedia
- `csrolecek_project_integration.R` - R code to integrate the files recieved from Kaggle which inlcuded pitstop time, drivers, and races into the table from Wikipedia
- `csrolecek_project_descriptive_analysis.R` - R code to for descriptive analysis and visualization of the project
- `csrolecek_project_report.pdf` - A detailed report that includes findings and visualizations used for analysis throughout the project


## Usage

To use this code and reproduce the analysis, you will need to have R and the required libraries installed on your system. You can then run the the above files to extract and analyze the data, and generate the final results.

## Conclusion

This project shows the power of data analysis to uncover insights and correlations that are not immediately apparent. By analyzing the duration of pit stops and its relation to driver standings, we gain a better understanding of how even small mistakes can have a big impact on the final results of a Formula 1 season.
