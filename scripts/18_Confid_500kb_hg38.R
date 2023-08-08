source('./scripts/01_Setup.R')
setwd("./data/processed/rds")

aa2=c("dMDA_101_500kb_ConfiScore.rds",  
      "Pico_76_500kb_ConfiScore.rds", 
      "Pico_101_500kb_ConfiScore.rds",   
      "PTA_48_500kb_ConfiScore.rds" ,  
      "PTA_101_500kb_ConfiScore.rds")
for (i in 1:length(aa2)){
        fname = file.path('./data/processed/rds/', aa2[i])
        readRDS(fname)}
all = lapply(aa2, function(x) readRDS(x))
all2= data.table::rbindlist(all)
all2= data.frame(all2)
qq= strsplit(all2$data,'_')
qq2= sapply(qq, function(x)x[[1]])
all2$data=qq2
all2$data=gsub('Pico','PicoPLEX', all2$data)
all2[,ncol(all2)+1]= rep('500 kb',nrow(all2))
all2[,ncol(all2)+1]= rep('hg38',nrow(all2))
colnames(all2)= c('id','confiscore', 'data','bin','version')
all2x=all2
saveRDS(all2x, file='./data/processed/rds/Confid_500kb_hg38.rds')