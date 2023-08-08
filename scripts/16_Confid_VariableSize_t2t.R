source('./scripts/01_Setup.R')

setwd("./data/processed/rds")

aa= grep("Confi",list.files(), val=T)
aa2= aa[aa%in%c("dMDA_101_5Mb_t2t_ConfiScore.rds",
                "Pico_76_250kb_t2t_ConfiScore.rds",
                "Pico_101_250kb_t2t_ConfiScore.rds",
                "PTA_48_500kb_t2t_ConfiScore.rds", 
                "PTA_101_500kb_t2t_ConfiScore.rds")]

for (i in 1:length(aa2)){
        fname = file.path('./data/processed/rds/',aa2[i])
        readRDS(fname)}
all = lapply(aa2, function(x) readRDS(x))
all2= data.table::rbindlist(all)
all2= data.frame(all2)
qq= strsplit(all2$data,'_')
qq2= sapply(qq, function(x) x[[1]])
qq3= sapply(qq, function(x) x[[3]])
all2$data=qq2
all2$V4=qq3
all2$V4= gsub('5Mb', '5 Mb', all2$V4)
all2$V4= gsub('500kb', '500 kb', all2$V4) 
all2$V4= gsub('250kb', '250 kb', all2$V4) 
all2[,ncol(all2)+1]= rep('T2T',nrow(all2))
colnames(all2)= c('id','confiscore', 'data','bin','version')
all2x=all2
all2x$data= gsub('Pico', 'PicoPLEX', all2x$data) 
saveRDS(all2x, file='./data/processed/rds/Confid_VariableSize_t2t.rds')
