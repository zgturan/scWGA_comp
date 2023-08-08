source('./scripts/01_Setup.R')
setwd("./data/processed/rds")

aa= grep("MAD",list.files(), val=T)
aa2= grep('500kb.rds', aa, val=T)
aa2=aa2[!(aa2%in%c("MAD_500kb.rds","MAD_ConfScore_500kb.rds"))]
for (i in 1:length(aa2)){
        fname = file.path('./data/processed/rds/',aa2[i])
        readRDS(fname)}
all = lapply(aa2, function(x) readRDS(x))
all2= data.table::rbindlist(all)
all2= data.frame(all2)
qq= strsplit(all2$V3,'_')
qq2= sapply(qq, function(x)x[[1]])
all2$V3=qq2
all2$V3=gsub('Pico','PicoPLEX', all2$V3)
all2[,ncol(all2)+1]= rep('500 kb',nrow(all2))
all2[,ncol(all2)+1]= rep('hg38',nrow(all2))
colnames(all2)= c('id', 'MAD', 'data','bin','version')
all2x=all2
saveRDS(all2x, file='./data/processed/rds/MAD_500kb_hg38.rds')