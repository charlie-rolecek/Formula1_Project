### Charlie Rolecek ### 
### Data Wrangling Project ###
### 12/7/2022 ###
### Project Topic: Formula 1 ###
### Project Script: Scraping ### 
rm(list=ls())

library(rvest)
library(xml2)
library(tidyverse)

url = "https://en.wikipedia.org/wiki/2021_Formula_One_World_Championship"

champ_standings <- read_html(url)

champ_standings %>% 
  html_nodes(css = "table")

champ_table <- 
  champ_standings %>%
  html_nodes(css = "table") %>%
  nth(7) %>%
  html_table(fill = TRUE)

write.csv(champ_table, "champ_table.csv")
