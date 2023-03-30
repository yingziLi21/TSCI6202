# In global.R we can put things to make sure they are accessible to both ui.R and server.R.
# In this case, it's data_list and data_choices..

library(dplyr)

data_list<- data()$results
data_choices<- 1:nrow(data_list) %>% setNames(data_list[,"Item"])
