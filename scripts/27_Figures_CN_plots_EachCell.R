args <- commandArgs(trailingOnly = T)
filenamex=as.character(args[[1]])

options(scipen=999)
outpath= file.path("./data/processed")

source('./scripts/01_Setup.R')

setwd(file.path(outpath, filenamex))
aa=        read.table('analysis', header = T)[,1]
delimiters <- ".bowtie|.bt2"
aa2=       strsplit(aa, delimiters, perl = TRUE) 
hg38_cell= sapply(aa2, function(x)x[1])
mada=      read.table('mad_txt2', header = T)
mada2=     strsplit(rownames(mada), delimiters, perl = TRUE)
hg38_mad=  sapply(mada2, function(x)x[1])
confa=      readRDS(file.path(outpath, 'rds',paste0(filenamex,'_ConfiScore.rds')))
confa2=     strsplit(confa$cellid, delimiters, perl = TRUE)
hg38_conf=  sapply(confa2, function(x)x[1])

for (i in 1:length(aa2)){
  variablesx= c(hg38_cell[i], hg38_mad[i], hg38_conf[i])
  if (all(variablesx == variablesx[1])){
  top=8  
  cell_hg38 <-     readRDS(file.path(outpath, filenamex,paste0(aa[i], ".rds")))
  first= ggarrange(cell_hg38, ncol=1, nrow = 1, 
                    labels=c(paste0(filenamex, paste0(' MAD= ', round(mada[i,1], 5)),
                                    paste0(' Conf_score= ', round(confa$confidence_score[i], 5)))),
                             widths = c(1,1), 
                             font.label = list(size = 80))
  ggsave(first, filename =file.path('./results/CN_plots',paste0(aa[i],'.pdf')),

         unit="cm", width = 120, height = 30, useDingbats = F, limitsize = FALSE)
  }
  else{
   cat('At least one name is wrong\n')
  }}