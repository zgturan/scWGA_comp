source('./scripts/01_Setup.R')
setwd("./data/processed/rds")

aa2= grep("preseq",list.files(), val=T)
aa2= aa2[!aa2%in% c("Merged_preseq_xlsx.rds","Pico_SN_preseq.rds",'dMDA_101_10Mb_lift_preseq.rds',
                    "dMDA_101_10Mb_preseq.rds","dMDA_101_10Mb_t2t_preseq.rds",'Merged_preseq_xlsx_dup.rds'  )]
for (i in 1:length(aa2)){
        fname = file.path('./data/processed/rds/',aa2[i])
        readRDS(fname)}
all = lapply(aa2, function(x) readRDS(x))
all2= data.table::rbindlist(all)
all2= data.frame(all2)
all2x= all2
all2x$data = gsub("dMDA_101_5Mb\\b",  paste0("dMDA_101_5Mb", "_hg38"),  all2x$data)
all2x$data = gsub("Pico_76_250kb\\b",  paste0("Pico_76_250kb", "_hg38"),  all2x$data)
all2x$data = gsub("Pico_101_250kb\\b", paste0("Pico_101_250kb","_hg38"),  all2x$data)
all2x$data = gsub("PTA_48_500kb\\b",   paste0("PTA_48_500kb",  "_hg38"),  all2x$data)
all2x$data = gsub("PTA_101_500kb\\b",  paste0("PTA_101_500kb", "_hg38") , all2x$data)
qq=  strsplit(all2x$data,'_')
qq2= sapply(qq, function(x) x[[1]])
qq3= sapply(qq, function(x) x[[4]])
all2x$data= qq2
all2x$data= gsub('Pico','PicoPLEX', all2x$data)
all2x[,ncol(all2x)+1]= qq3
all2x$V4= gsub("lift", "LiftOver - T2T to hg38", all2x$V4)
all2x$V4= gsub("t2t",   "T2T", all2x$V4)
all2x_hg38= all2x[all2x$V4%in%'hg38',]
all2x_lift= all2x[all2x$V4%in%'LiftOver - T2T to hg38',]
all2x_t2t= all2x[all2x$V4%in%'T2T',]
saveRDS(all2x_hg38, file= './data/processed/rds/Preseq_hg38.rds')
saveRDS(all2x_lift, file= './data/processed/rds/Preseq_liftover.rds')
saveRDS(all2x_t2t, file= './data/processed/rds/Preseq_t2t.rds')