args <- commandArgs(trailingOnly = T)
filenamex=as.character(args[[1]])

options(scipen=999)
outpath= "./data/processed/preseq"
source('./scripts/01_Setup.R')
if (file.exists(file.path(outpath, filenamex))) {
setwd(file.path(outpath, filenamex))
samples= list.files()
xx=c()
for (i in 1:length(samples)){
  # print(i)
  filex=  data.frame(read.delim(samples[i]))
  filex2= median(filex$EXPECTED_COVERED_BASES)
  names(filex2)= samples[i]
  xx=c(xx, filex2)
}
xxa=           data.frame(xx)
xx2=           data.frame(rownames(xxa), xxa[,1], rep(filenamex, length(samples)))
colnames(xx2)= c('id', "median_expected_covered_bases", "data")
saveRDS(xx2, file= file.path('./data/processed/rds', paste0(filenamex, '_preseq.rds')))
}
