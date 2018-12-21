result <- join_by_timestamp(data_ground_level[1:10, ], Isosuo)

N <- nrow(data_ground_level)
for (i in 11:N)   { 
  tmp <- join_by_timestamp(data_ground_level[i, ], Isosuo)
  result <- rbind(result, tmp)
  }

save(result, file = "../Data/merged_Isosuo.R") 

load("../Data/merged_Isosuo.R")

            
            
            
            
