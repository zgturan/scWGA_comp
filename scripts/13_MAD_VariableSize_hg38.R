source('./scripts/01_Setup.R')

setwd("./data/processed/rds")
standardize_name <- function(name) {
  return(gsub('[^0-9a-zA-Z]+', '_', name))}

aa= grep("MAD",list.files(), val=T)
aa2= aa[aa%in%c("MAD_dMDA_101_5Mb.rds", "MAD_Pico_76_250kb.rds", "MAD_Pico_101_250kb.rds","MAD_PTA_48_500kb.rds",
                "MAD_PTA_101_500kb.rds")]
for (i in 1:length(aa2)){
        fname = file.path('./data/processed/rds/',aa2[i])
        readRDS(fname)}
all = lapply(aa2, function(x) readRDS(x))
all2= data.table::rbindlist(all)
all2= data.frame(all2)
qq= strsplit(all2$V3,'_')
qq2= sapply(qq, function(x) x[[1]])
qq3= sapply(qq, function(x) x[[3]])
all2$V3=qq2
all2$V4=qq3
all2$V4= gsub('5Mb', '5 Mb', all2$V4)    
all2$V4= gsub('500kb', '500 kb', all2$V4) 
all2$V4= gsub('250kb', '250 kb', all2$V4) 
all2[,ncol(all2)+1]= rep('hg38',nrow(all2))
colnames(all2)= c('id','MAD', 'data','bin','version')
all2$data= gsub('Pico', 'PicoPLEX', all2$data) 
all2x=all2
saveRDS(all2x, file='./data/processed/rds/MAD_VariableSize_hg38.rds')
