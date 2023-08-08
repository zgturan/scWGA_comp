source('./scripts/01_Setup.R')
setwd("./data/processed/rds")

aa= grep("_male_median.rds",list.files(), val=T)
aa2= aa
for (i in 1:length(aa2)){
  fname = file.path('./data/processed/rds/',aa2[i])
  readRDS(fname)}

all = lapply(aa2, function(x) readRDS(x))
all2= data.table::rbindlist(all)
all2= data.frame(all2)
delimx= ".bowtie|.bt2"
res1= strsplit(all2$names.malex3., delimx, perl = T)
all2[,ncol(all2)+1]=  sapply(res1, function(x) x[1])
colnames(all2)[ncol(all2)]='generic_name'
all2$generic_name= standardize_name(all2$generic_name)
all3= all2[,-1]
colnames(all3)[1]= 'cn_median'
all4= data.frame(all3[,'generic_name'], all3[,'cn_median'])
colnames(all4)= c('generic_name','cn_median')

ordered_data_male_pico <- readRDS("./data/processed/rds/ordered_data_male_pico.rds")
ordered_data_male_pico_m= all4[all4$generic_name%in%ordered_data_male_pico$generic_name_standardized,]
saveRDS(ordered_data_male_pico_m, file= './data/processed/rds/ordered_data_male_pico_wholechrX.rds')

ordered_data_male_pta <- readRDS("./data/processed/rds/ordered_data_male_pta.rds")
ordered_data_male_pta_m= all4[all4$generic_name%in%ordered_data_male_pta$generic_name_standardized,]
saveRDS(ordered_data_male_pta_m, file= './data/processed/rds/ordered_data_male_pta_wholechrX.rds')