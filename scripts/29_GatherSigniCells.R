source('./scripts/01_Setup.R')
library(data.table)

aa2= paste0(aa, '_filteredCNVscells.rds')
all_data=list()
for (i in 1:length(aa2)){
  fname = file.path('./data/processed/rds/',aa2[i])
  all_data[[i]] = readRDS(fname)}
all2 = data.table::rbindlist(all_data)
all2=  data.frame(all2)

saveRDS(all2, file='./data/processed/rds/SignificantCells.rds')