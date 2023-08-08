args <- commandArgs(trailingOnly = T)
filenamex=as.character(args[[1]])

options(scipen=999)
set.seed(1)


for (t in 1:length(namex)){
  filenamex= namex[t]
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
    cell_stat_path = file.path("./data/processed/rds3", paste0(aa[i], "_paper.rds"))
    
    if(file.exists(cell_stat_path)){
      top=8  
      cell_stat <-     readRDS(cell_stat_path)
      cell_hg38 <-     readRDS(file.path(outpath, filenamex, paste0(aa[i], ".rds")))
      cell_hg38$labels$title <- NULL
      cell_hg38a= cell_hg38
      
      if (filenamex == "Pico_101_250kb_lift") {
        filenamey <- "PicoPLEX_101bp_250kb_Liftover"
      } else {
        filenamey <- "PicoPLEX_76bp_250kb_Liftover"
      }

      first=           ggarrange(cell_stat, cell_hg38a, ncol=1, nrow = 2, heights = c(1, 1),
                       common.legend = T, widths = c(1, 3),
                       labels= c(paste0(filenamey, ';', paste0(' MAD= ',   round(mada[i,1], 2)),
                                        paste0(' Confidence_score= ',       round(confa$confidence_score[i], 2)))),
                       font.label = list(size = 50))+
                       theme(plot.margin = unit(c(0.001, 0.001,  0.001, 0.001), "pt")) 
      ggsave(first, filename = file.path('./results/CN_plotsx/PicoPLEX_paper/pdf',paste0(aa[i],'.pdf')),
             unit="cm", width = 130, height = 65, useDingbats = F, limitsize = FALSE)
      
      
    } else {
      cat("The cell_stat for", aa[i], "does not exist.\n")
    }
  } else {
    cat('At least one name is wrong\n')
  }
}
}