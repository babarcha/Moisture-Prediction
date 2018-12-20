# This script joins Isosuo_moisture, Isosuo_ground_water and Isosuo_weather
# The join is done by mathing the closest timestamps 

require(tidyverse)
require(lubridate)
require(data.table)

load("../Data/R/Isosuo_weather.R")
load("../Data/R/Isosuo_moisture.R")
load("../Data/R/Isosuo_ground_water.R")

# Create a temp copy of Isosuo_weather for joining
# Add a temporary copy of the timestamp field to be used for the merge
Isosuo_weather_temp <- Isosuo_weather %>% 
  mutate("timestamp_weather" = timestamp)

# Create a temp copy of Isosuo_ground_water_temp for joining
# Add a temporary copy of the timestamp field to be used for the merge
Isosuo_ground_water_temp <- Isosuo_ground_water %>% 
  mutate("timestamp_ground_water" = timestamp)

# Create a copy of Isosuo_moisture for merging
Isosuo_combined <- Isosuo_moisture

# Remove Isosuo_weather and Isosuo_ground_water and Isosuo_moisture from environment 
# The remaining code uses the temporary copies
rm(list=c("Isosuo_weather", "Isosuo_ground_water", "Isosuo_moisture"))

# Add timestamp_weather column which contains the nearest timestamp in the Isosuo_weather dataframe
# i.e. find the nearest time at which weather station measurement is available
setDT(Isosuo_combined)[, timestamp_weather := setDT(Isosuo_weather_temp)[Isosuo_combined, timestamp_weather, on = "timestamp", roll = "nearest"]]

# Add timestamp_ground_water column which contains the nearest timestamp in the Isosuo_ground_water dataframe
# i.e. find the nearest time at which ground water measurement is available
setDT(Isosuo_combined)[, timestamp_ground_water := setDT(Isosuo_ground_water_temp)[Isosuo_combined, timestamp_ground_water, on = "timestamp", roll = "nearest"]]

# Compute the time differences between moisture and other measurement timestamps
# These columns, time_diff_weather and time_diff_ground_water can be used to filter data 
# for which the time difference between measurements are greater than a treshold value
Isosuo_combined <- Isosuo_combined %>% 
  mutate("time_diff_weather" = difftime(.data$timestamp, timestamp_weather, units = "mins")) %>% 
  mutate("time_diff_ground_water" = difftime(.data$timestamp, timestamp_ground_water, units = "mins"))

# Remove timestamp field (there is still the timestamp_weater column)
Isosuo_weather_temp <- Isosuo_weather_temp %>% 
  select(-timestamp)

# Remove timestamp field (there is still the timestamp_ground_water column)
Isosuo_ground_water_temp <- Isosuo_ground_water_temp %>% 
  select(-timestamp)

# Join Isosuo_combined and Isosuo_weather_temp by timestamp_weather
# timestamp_weather column is the timestamp found in Isosuo_weather_temp which is the closest in time 
Isosuo_combined <- inner_join(Isosuo_combined, Isosuo_weather_temp, by="timestamp_weather" )

# Join Isosuo_combined and Isosuo_ground_water_temp by timestamp_ground_water
# timestamp_ground_water column is the timestamp found in Isosuo_weather_temp which is the closest in time 

Isosuo_combined <- inner_join(Isosuo_combined, Isosuo_ground_water_temp, by="timestamp_ground_water" )
Isosuo_combined 

# Remove the temporary dataframes from environment
rm(list=c("Isosuo_weather_temp", "Isosuo_ground_water_temp"))

# Save the cleaned up data as R data file
# This can be loaded in another file or from the console with 
# load("../Data/R/Isosuo_combined.R") 
save(Isosuo_combined, file="../Data/R/Isosuo_combined.R")

