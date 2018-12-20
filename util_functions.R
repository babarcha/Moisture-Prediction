require(tidyverse)
require(lubridate)

join_by_timestamp <- function(data_ground, data_weather) {
  df2 <- data_ground %>% 
    rename("timestamp_ground" = timestamp) %>% 
    merge(data_weather) %>% 
    mutate("time_diff" = difftime(timestamp_ground, .data$timestamp, units = "mins")) %>% 
    mutate("time_diff_abs" = abs(time_diff)) %>% 
    group_by(timestamp_ground) %>%
    mutate(min_diff = min(time_diff_abs)) %>% 
    ungroup() %>% 
    filter(time_diff_abs==min_diff)
  df2 
}


