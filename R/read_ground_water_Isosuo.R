require(readxl) # to use read_excel function
require(lubridate) # to use ymd_hms function
require(magrittr) # to use the %>%operator
require(dplyr) # to use rename, mutate, select, ...

# Read the data from 3 csv files AA_2_1.csv AA_2_2.csv AA_2_3.csv and combine


Isosuo_grund_water_cvs_1 <- read.csv("../Data/AA_2_1.csv", sep = ";") %>% 
  # Remove the first 11 lines that contains log 
  slice(12:n()) %>% 
  # Remove the first 11 lines that contains log 
  slice(12:n()) %>% 
  # Remove the first column that contains data point number
  select("X", "X.1") %>% 
  # rename columns
  rename(timestamp = X) %>%
  rename(ground_water_1 = X.1) %>%
  # convert 
  mutate(ground_water_1 = as.numeric(ground_water_1)) %>%
  # Replace . with - in the timestamp data
  # Convert the timestamp to R timestamp type in the format yyyy-mm-dd hh:mm:ss
  mutate(timestamp= gsub("[.]", "-", timestamp)) %>% 
  mutate(timestamp = dmy_hms(timestamp)) %>% 
  #Remove the rows with empty timestamp value
  filter(!is.na(timestamp))
  
Isosuo_grund_water_cvs_2 <- read.csv("../Data/AA_2_2.csv", sep = ";") %>% 
  # Remove the first 11 lines that contains log 
  slice(12:n()) %>% 
  # Remove the first column that contains data point number
  select("X", "X.1") %>% 
  # rename columns
  rename(timestamp = X) %>%
  rename("ground_water_2" = X.1) %>%
  # convert 
  mutate(ground_water_2 = as.numeric(ground_water_2)) %>%
  # Replace . with - in the timestamp data
  # Convert the timestamp to R timestamp type in the format yyyy-mm-dd hh:mm:ss
  mutate(timestamp= gsub("[.]", "-", timestamp)) %>% 
  mutate(timestamp = dmy_hms(timestamp)) %>% 
  #Remove the rows with empty timestamp value
  filter(!is.na(timestamp))

Isosuo_grund_water_cvs_3 <- read.csv("../Data/AA_2_3.csv", sep = ";") %>% 
  # Remove the first 11 lines that contains log 
  slice(12:n()) %>% 
  # Remove the first 11 lines that contains log 
  slice(12:n()) %>% 
  # Remove the first column that contains data point number
  select("X", "X.1") %>% 
  # rename columns
  rename(timestamp = X) %>%
  rename(ground_water_3 = X.1) %>%
  # convert 
  mutate(ground_water_3 = as.numeric(ground_water_3)) %>%
  # Replace . with - in the timestamp data
  # Convert the timestamp to R timestamp type in the format yyyy-mm-dd hh:mm:ss
  mutate(timestamp= gsub("[.]", "-", timestamp)) %>% 
  mutate(timestamp = dmy_hms(timestamp)) %>% 
  #Remove the rows with empty timestamp value
  filter(!is.na(timestamp))

# Combine the data from three files COLUMNWISE

Isosuo_ground_water <- inner_join(Isosuo_grund_water_cvs_1, Isosuo_grund_water_cvs_2, by="timestamp")
Isosuo_ground_water <- inner_join(Isosuo_ground_water, Isosuo_grund_water_cvs_3, by="timestamp")

# Remove the temporarily used data frames
# rm(list=c("Isosuo_grund_water_cvs_1", "Isosuo_grund_water_cvs_2", "Isosuo_grund_water_cvs_3"))

# Save the cleaned up data as R data file
# This can be loaded in another file or from the console with 
# load("../Data/R/Isosuo_ground_water.R") 
save(Isosuo_ground_water, file="../Data/R/Isosuo_ground_water.R")

