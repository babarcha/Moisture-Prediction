require(lubridate) # to use ymd_hms function
require(magrittr) # to use the %>%operator
require(dplyr) # to use rename, mutate, select, ...

# Reads the moisture data from AA2_data.csv file located in Data folder
Isosuo_moisture_csv <- read.csv("../Data/AA2_data.csv", sep = ";") 

Isosuo_moisture <- Isosuo_moisture_csv %>% 
  # rename the column names
  rename(moisture1 = "ch1") %>% 
  rename(moisture2 = "Ch2") %>% 
  rename(moisture3 = "Ch3") %>% 
  # Convert the timestamp to R timestamp type in the format yyyy-mm-dd hh:mm:ss  
  mutate("timestamp"= ymd_hms(timestamp))

# Remove the temporarily used data frames
rm(list=c("Isosuo_moisture_csv"))

# Save the cleaned up data as R data file
# This can be loaded in another file or from the console with 
# load("../Data/R/Isosuo_moisture.R") 
save(Isosuo_moisture, file="../Data/R/Isosuo_moisture.R")