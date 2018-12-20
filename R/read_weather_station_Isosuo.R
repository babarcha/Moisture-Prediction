require(readxl) # to use read_excel function
require(lubridate) # to use ymd_hms function
require(magrittr) # to use the %>%operator
require(dplyr) # to use rename, mutate, select, ...

# Read the weather statition data form 2 files 
# Isosuo 11.7.-3.8_.xlsx and Isosuo 22.8.-26.9_.xlsx
# The file path is given relative to the root folder of the project
Isosuo_weather_xls_1 <- read_excel("../Data/Isosuo 11.7.-3.8_.xlsx")
Isosuo_weather_xls_2 <- read_excel("../Data/Isosuo 22.8.-26.9_.xlsx")
# Combine these two files
Isosuo_weather_xls <- rbind(Isosuo_weather_xls_1, Isosuo_weather_xls_2)

# Cleanup data
Isosuo_weather <- Isosuo_weather_xls %>%
  # Rename column names
  rename("timestamp"= `Date Time(Y-m-d H:M:S EEST )`) %>% 
  rename("temperature"=`Temperature (C)`) %>%
  rename("temperature2"=`2nd TempTemperature (C)`) %>%
  rename("wind_speed"=`Wind speed (m/s)`) %>%
  rename("wind_gust"=`Wind gust (m/s)`) %>%
  rename("wind_direction"=`Wind direction (deg)`) %>%
  rename("humidity"=`Humidity (%)`) %>% 
  rename("rainfall"=`Rainfall (mm)`) %>% 
  rename("solar_radiation"=`Solar radiation (W/m^2)`) %>% 
  rename("pressure"=`Pressure (hPa)`) %>% 
  # Convert the timestamp to R timestamp type in the format yyyy-mm-dd hh:mm:ss 
  mutate("timestamp"= ymd_hms(timestamp))

# Remove the temporarily used data frames
rm(list=c("Isosuo_weather_xls_1", "Isosuo_weather_xls_2", "Isosuo_weather_xls"))

# Save the cleaned up data as R data file
# This can be loaded in another file or from the console with 
# load("../Data/R/Isosuo_weather.R") 
save(Isosuo_weather, file="../Data/R/Isosuo_weather.R")