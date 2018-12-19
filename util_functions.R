require(tidyverse)

join_by_timestamp <- function(data_ground, data_weather) {
  df2 <- data_ground %>% 
    rename("timestamp_ground" = timestamp) %>% 
    merge(data_weather) %>% 
    mutate("time_diff" = difftime(timestamp_ground, .data$timestamp, units = "mins")) %>% 
    arrange(timestamp_ground, time_diff) %>% 
    group_by(timestamp_ground) %>% 
    slice(1)
  df2 
}
