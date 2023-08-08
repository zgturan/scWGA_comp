args <- commandArgs(trailingOnly = T)
filenamex=as.character(args[[1]])

exclude_files <- c("dMDA_101_5Mb_t2t", "Pico_101_250kb_t2t", "Pico_76_250kb_t2t", "PTA_101_500kb_t2t", "PTA_48_500kb_t2t",
                   'Pico_76_250kb_t2t_q1','Pico_76_250kb_t2t_q10','Pico_101_250kb_t2t_q1','Pico_101_250kb_t2t_q10',
                   'PTA_48_500kb_t2t_q1','PTA_48_500kb_t2t_q10','PTA_101_500kb_t2t_q1','PTA_101_500kb_t2t_q10')
if (!(filenamex %in% exclude_files)){
turan_CNV1_svd= readRDS(file.path('./data/processed/rds', paste0('CNV1_', filenamex,'.rds')))
CNV1= turan_CNV1_svd
number_of_CN= CNV1[(CNV1$chr %in% c(paste0("chr",1:22), "chrX")),]
number_of_CN5=number_of_CN
saveRDS(number_of_CN5, file= file.path('./data/processed/rds', paste0(filenamex, '_number_of_CN5_genome.rds')))
########################################################################
turan_Clouds <- readRDS(file.path('./data/processed/rds', paste0(filenamex, '_SegFixed_clouds_genome.rds')))
pos <- readRDS(file.path('./data/processed/rds', paste0('location_', filenamex, '.rds')))
pos$CHR= as.character(pos$CHR)
turan_Clouds2= cbind(pos, turan_Clouds)
turan_Clouds3= turan_Clouds2[(turan_Clouds2$CHR %in% c(paste0("chr",1:22), "chrX")),]
turan_Clouds3= turan_Clouds3[!turan_Clouds3$CHR%in%1,]
pos= pos[(pos$CHR %in% c(paste0("chr",1:22), "chrX")),]
pos= pos[!pos$START%in%0,]
###########################################################
number_of_CN6 = rbind()
for (x in 1:dim(number_of_CN5)[1]){
    idx= number_of_CN5$id[x]
    datax=         unique(number_of_CN5[number_of_CN5$id%in%idx,'data'])
    cnv_value =    turan_Clouds3[(colnames(turan_Clouds3) %in% number_of_CN5$id[x])]
    cnv_value2 =   data.frame(pos, cnv_value)
    chr =          cnv_value2[cnv_value2$CHR %in% number_of_CN5$chr[x],]
    chrx=          unique(chr$CHR)
    start_pos =    chr[(chr$START %in% number_of_CN5$start[x]),]
    start_posx =   chr[(chr$START %in% number_of_CN5$start[x]),'START']
    end_pos =      chr[(chr$END %in% number_of_CN5$end[x]),]
    end_posx =     chr[(chr$END %in% number_of_CN5$end[x]),'END']
    cnv_mean =    mean(cnv_value[as.numeric(rownames(start_pos)[1]):as.numeric(rownames(end_pos)[1]),])
    cnv_sd =      sd(cnv_value[as.numeric(rownames(start_pos)[1]):as.numeric(rownames(end_pos)[1]),])
    cnv_median =  median(cnv_value[as.numeric(rownames(start_pos)[1]):as.numeric(rownames(end_pos)[1]),])
    cnv_binsize = length(cnv_value[as.numeric(rownames(start_pos)[1]):as.numeric(rownames(end_pos)[1]),])
    start_bin =   as.numeric(rownames(start_pos)[1])
    end_bin =     as.numeric(rownames(end_pos)[1])
    #effect size
    cnv = number_of_CN5$cnv[x]
    cnv_ss = cnv - cnv_mean
    cnv_ss_t = cnv_ss / cnv_sd
    aaa = c(chrx, start_posx, end_posx, idx, cnv, datax, cnv_mean, cnv_sd, cnv_median, cnv_binsize, cnv_ss_t, start_bin, end_bin)
    number_of_CN6 = rbind(number_of_CN6, aaa)}  
colnames(number_of_CN6)= c('chr','start','end', 'id', 'cnv','data','cn_mean','cn_sd','cn_median','cn_binsize','z2score','start_bin','end_bin')
rownames(number_of_CN6) = NULL
number_of_CN6=data.frame(number_of_CN6)
number_of_CN6$start=as.numeric(number_of_CN6$start)
number_of_CN6$end=as.numeric(number_of_CN6$end)
number_of_CN6$cnv=as.numeric(number_of_CN6$cnv)
number_of_CN6$cn_mean=as.numeric(number_of_CN6$cn_mean)
number_of_CN6$cn_sd= as.numeric(number_of_CN6$cn_sd) 
number_of_CN6$cn_median= as.numeric(number_of_CN6$cn_median) 
number_of_CN6$cn_binsize= as.numeric(number_of_CN6$cn_binsize) 
number_of_CN6$z2score= as.numeric(number_of_CN6$z2score) 
number_of_CN6$start_bin= as.numeric(number_of_CN6$start_bin) 
number_of_CN6$end_bin= as.numeric(number_of_CN6$end_bin) 
saveRDS(number_of_CN6, file= file.path('./data/processed/rds', paste0(filenamex, '_SegFixed_cnv_stat_genome.rds')))}