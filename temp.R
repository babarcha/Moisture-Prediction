# result <- join_by_timestamp(data_ground_level[1:10, ], data2)

N <- nrow(data_ground_level)
for (i in 1:N)   { 
  tmp <- join_by_timestamp(data_ground_level[i, ], data2)
  result <- rbind(result, tmp)
  }

save(result, file = "../Data/merged_Isosuo.R") 

# load("../Data/merged_Isosuo.R")

            
            
            
            
