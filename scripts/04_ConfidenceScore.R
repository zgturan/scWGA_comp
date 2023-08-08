args <- commandArgs(trailingOnly = T)
filenamex=as.character(args[[1]])

turan_SegNorm = read.table(file.path('./data/processed/', filenamex, 'SegFixed'), header=TRUE, sep="\t")
turan_SegNorm$CHR= as.character(turan_SegNorm$CHR)
turan_ploidy <- readRDS(file.path('./data/processed/rds', paste0('cell_cn_', filenamex, '.rds')))
turan_ploidy= data.frame(id= turan_ploidy[,'Sample'], predicted_ploidy=as.numeric(turan_ploidy[,'Copy_Number']))
turan_ploidy$id= as.character(turan_ploidy$id)
identical(colnames(turan_SegNorm[,4:ncol(turan_SegNorm)]), turan_ploidy$id)
turan_clouds= sweep(turan_SegNorm[,4:ncol(turan_SegNorm)], 2, turan_ploidy$predicted_ploidy, "*")
saveRDS(turan_clouds, file= file.path('./data/processed/rds', paste0(filenamex, '_SegFixed.rds')))

loca= turan_SegNorm[turan_SegNorm$CHR%in%paste0('chr', 1:22),]
autosomes= nrow(loca)
turan_clouds= turan_clouds[1:autosomes,]
confx= c()
for (i in 1:ncol(turan_clouds)){
  cellx= turan_clouds[,i]
  CS = 1 - 2*(median(abs(cellx-round(cellx)), na.rm = T))
  confx= c(confx, CS)}
confx2= data.frame(colnames(turan_clouds), confx, rep(filenamex, length(confx)))
colnames(confx2)= c('cellid', "confidence_score", "data")

saveRDS(confx2, file= file.path('./data/processed/rds', paste0(filenamex, '_ConfiScore.rds')))