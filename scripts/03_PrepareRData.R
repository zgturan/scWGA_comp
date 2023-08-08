args <- commandArgs(trailingOnly = T)
filenamex=as.character(args[[1]])

source('./scripts/01_Setup.R')

raw_dMDA_5Mb = read.table(file.path('./data/processed',filenamex, 'data'), header=TRUE, sep="\t")
saveRDS(raw_dMDA_5Mb, file =  file.path('./data/processed/rds', paste0('raw_', filenamex, '.rds')))

CNV1= read.table(file.path('./data/processed', filenamex, 'CNV1'))
colnames(CNV1)= NULL
rownames(CNV1)= NULL
CNV1= data.frame(CNV1)
colnames(CNV1)=c('chr','start','end','id','cnv')
CNV1$chr= as.character(CNV1$chr)
CNV1$id= as.character(CNV1$id)
CNV1$data=rep(filenamex, nrow(CNV1))
CNV1$width=(CNV1$end - CNV1$start)+1
CNV1= CNV1[CNV1$chr %in% c(paste0("chr",1:22),'chrX','chrY'),]
CNV1= CNV1[!CNV1$start%in%0,]
saveRDS(CNV1, file =  file.path('./data/processed/rds', paste0('CNV1_', filenamex, '.rds')))

SegNorm = read.table(file.path('./data/processed/', filenamex, 'SegNorm'), header=TRUE)
saveRDS(SegNorm, file = file.path('./data/processed/rds', paste0('SegNorm_', filenamex, '.rds')))
loca= SegNorm[,1:3]
saveRDS(loca, file= file.path('./data/processed/rds', paste0('location_', filenamex, '.rds')))

# locax for bedtools subtract to find differences
locax= loca[loca$CHR %in% paste0("chr",1:22),]
write.table(locax, file= file.path(paste0('./data/processed/diploid/',filenamex,'/output'), paste0('location_', filenamex, '.bed')),
            quote = FALSE,sep = "\t",
            row.names = FALSE,col.names = FALSE)

SegCopy = read.table(file.path('./data/processed', filenamex, 'SegCopy'), header=TRUE)
saveRDS(SegCopy, file = file.path('./data/processed/rds', paste0('SegCopy_', filenamex, '.rds')))

SegBreaks = read.table(file.path('./data/processed', filenamex, 'SegBreaks'), header=TRUE, sep="\t")
saveRDS(SegBreaks, file = file.path('./data/processed/rds', paste0('SegBreaks_', filenamex, '.rds')))

SegFix = read.table(file.path('./data/processed', filenamex, 'SegFixed'), header=TRUE, sep="\t")
saveRDS(SegFix, file = file.path('./data/processed/rds', paste0('SegFixed_', filenamex, '.rds')))

resultsx = read_tsv(file.path('./data/processed', filenamex, 'results.txt'))
resultsxx= as.data.frame(resultsx[,1:2])
resultsxx= resultsxx[!is.na(resultsxx[,'Copy_Number']),]
saveRDS(resultsxx, file = file.path('./data/processed/rds', paste0('cell_cn_', filenamex, '.rds')))

SegStats = read.table(file.path('./data/processed/', filenamex, 'SegStats'), header=TRUE, sep="\t")
segstat1=  data.frame(rownames(SegStats), SegStats[,'Reads'],  SegStats[,'Disp'], rep(filenamex,length(rownames(SegStats))))
saveRDS(segstat1, file = file.path('./data/processed/rds', paste0('SegStats_', filenamex, '.rds')))

###########
filenamesx= c("dMDA_101_5Mb.rds",
              "dMDA_101_5Mb_lift.rds",
              "dMDA_101_5Mb_t2t.rds",
              
              "Pico_101_250kb_lift.rds",
              "Pico_101_250kb_t2t.rds",  
              "Pico_101_250kb.rds",      
   
              "Pico_76_250kb_lift.rds",  
              "Pico_76_250kb_t2t.rds",   
              "Pico_76_250kb.rds",   

              "PTA_101_500kb_lift.rds",  
              "PTA_101_500kb_t2t.rds",  
              "PTA_101_500kb.rds",
              
              "PTA_48_500kb_lift.rds",   
              "PTA_48_500kb_t2t.rds",   
              "PTA_48_500kb.rds") 

saveRDS(filenamesx,  file = './data/processed/rds/filenamesx.rds')
############