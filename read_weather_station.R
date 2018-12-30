require(readxl)
require(lubridate)
require(magrittr)
require(dplyr) 

Isosuo_1 <- read_excel("../Data/Isosuo 11.7.-3.8_.xlsx")
names(Isosuo_1) <- make.names(names(Isosuo_1))
data_isosuo_weather_1 <- Isosuo_1 %>%
  rename("temp"=`Temperature..C.`) %>%
  rename("humid"=Humidity....)  %>%
  rename("timestamp"= Date.Time.Y.m.d.H.M.S.EEST..) %>% 
  mutate("timestamp"= ymd_hms(timestamp))

Isosuo_2 <- read_excel("../Data/Isosuo 22.8.-26.9_.xlsx")
names(Isosuo_2) <- make.names(names(Isosuo_2))
data_isosuo_weather_2 <- Isosuo_2 %>%
  rename("temp"=`Temperature..C.`) %>%
  rename("humid"=Humidity....)  %>%
  rename("timestamp"= Date.Time.Y.m.d.H.M.S.EEST..) %>% 
  mutate("timestamp"= ymd_hms(timestamp))

Isosuo <- rbind(data_isosuo_weather_1, data_isosuo_weather_2) %>% 
  mutate("field" = "Isosuo")

save(Isosuo, file="../Data/Isosuo.R")



# Read xls for Hirsikorpi

Hirsikorpi_file <- read_excel("../Data/Hirsikorpi_11.7.-22.8_.xlsx")
names(Hirsikorpi_file) <- make.names(names(Hirsikorpi_file))
Hirsikorpi <- Hirsikorpi_file %>%
  rename("temp"=`Temperature..C.`) %>%
  rename("humid"=Humidity....)  %>%
  rename("timestamp"= Date.Time.Y.m.d.H.M.S.EEST..) %>% 
  mutate("timestamp"= ymd_hms(timestamp)) %>% 
  mutate("field" = "Hirsikorpi")

save(Hirsikorpi, file="../Data/Hirsikorpi.R")



#save data_moisture

data_moisture <- read.csv("../Data/AA2_data.csv", sep = ";") %>% 
  rename(moisture1 = "ch1") %>% 
  rename(moisture2 = "Ch2") %>% 
  rename(moisture3 = "Ch3") %>% 
  mutate("timestamp"= ymd_hms(timestamp))

save(data_moisture, file="../Data/data_moisture.R")
