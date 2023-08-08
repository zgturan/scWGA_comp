source('./scripts/01_Setup.R')

filenamesx <- gsub('.rds', '', readRDS("./data/processed/rds/filenamesx.rds"))

aa2= paste0(filenamesx, '_SegFixed_cnv_stat_genome.rds')
aa2= c( "PTA_48_500kb_lift_SegFixed_cnv_stat_genome.rds",
        "PTA_101_500kb_lift_SegFixed_cnv_stat_genome.rds",
        "Pico_76_250kb_lift_SegFixed_cnv_stat_genome.rds",
        "Pico_101_250kb_lift_SegFixed_cnv_stat_genome.rds",
        
        "PTA_48_500kb_t2t_SegFixed_cnv_stat_genome.rds",
        "PTA_101_500kb_t2t_SegFixed_cnv_stat_genome.rds",
        "Pico_76_250kb_t2t_SegFixed_cnv_stat_genome.rds",
        "Pico_101_250kb_t2t_SegFixed_cnv_stat_genome.rds")

all_data = list()
for (i in 1:length(aa2)){
  fname = file.path('./data/processed/rds/',aa2[i])
  all_data[[i]] = readRDS(fname)
}
all2 = data.table::rbindlist(all_data)
all2 = data.frame(all2)
all2= all2[,-which(colnames(all2)%in%c('cn_sd','z2score'))]

saveRDS(all2, file='./data/processed/rds/All_cnv_stat2_genome.rds')