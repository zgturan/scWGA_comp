source('./scripts/01_Setup.R')
setwd("./data/processed/rds")
filenamesx <- readRDS("./data/processed/rds/filenamesx.rds")

aa2= paste0('SegStats_', filenamesx)
for (i in 1:length(aa2)){
        fname = file.path('./data/processed/rds/',aa2[i])
        readRDS(fname)}
all = lapply(aa2, function(x) readRDS(x))
all2= data.table::rbindlist(all)
all2= data.frame(all2)
colnames(all2)=c('id','number of reads', 'index of dispersion','data')
all2x=all2
all2x$data = gsub("dMDA_101_5Mb\\b",  paste0("dMDA_101_5Mb", "_hg38"),  all2x$data)
all2x$data = gsub("Pico_76_250kb\\b",  paste0("Pico_76_250kb", "_hg38"),  all2x$data)
all2x$data = gsub("Pico_101_250kb\\b", paste0("Pico_101_250kb","_hg38"),  all2x$data)
all2x$data = gsub("PTA_48_500kb\\b",   paste0("PTA_48_500kb",  "_hg38"),  all2x$data)
all2x$data = gsub("PTA_101_500kb\\b",  paste0("PTA_101_500kb", "_hg38") , all2x$data)
qq= strsplit(all2x$data,'_')
qq2= sapply(qq, function(x)x[[1]])
qq3= sapply(qq, function(x)x[[4]])
all2x$data= qq2
all2x$data= gsub('Pico','PicoPLEX', all2x$data)
all2x[,ncol(all2x)+1]= qq3
colnames(all2x)[5]='version'
all2x$version= gsub("lift", "LiftOver - T2T to hg38", all2x$version)
all2x$version= gsub("t2t",   "T2T", all2x$version)
all2x_hg38= all2x[all2x$version%in%'hg38',]
all2x_lift= all2x[all2x$version%in%'LiftOver - T2T to hg38',]
all2x_t2t=  all2x[all2x$version%in%'T2T',]
saveRDS(all2x_hg38, file= './data/processed/rds/ReadNumber_hg38.rds')
saveRDS(all2x_lift, file= './data/processed/rds/ReadNumber_liftover.rds')
saveRDS(all2x_t2t, file= './data/processed/rds/ReadNumber_t2t.rds')