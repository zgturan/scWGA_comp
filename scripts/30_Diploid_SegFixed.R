args <- commandArgs(trailingOnly = T)
filenamex=as.character(args[[1]])

source('./scripts/01_Setup.R')
all2= readRDS("./data/processed/rds/SignificantCells.rds")

picocells_passing_mad_conf=all2
unique(picocells_passing_mad_conf$id)
picocells_passing_mad_conf=picocells_passing_mad_conf$id       

Pico_76_SegFixed <- readRDS(file.path('./data/processed/rds', paste0(filenamex, '_SegFixed_clouds_genome.rds')))
Pico_76_SegFixed=  Pico_76_SegFixed[,colnames(Pico_76_SegFixed)%in%picocells_passing_mad_conf]
Pico_76_pos <- readRDS(file.path('./data/processed/rds', paste0('location_', filenamex, '.rds')))
Pico_76_pos$CHR= as.character(Pico_76_pos$CHR)
Pico_76_SegFixed2= cbind(Pico_76_pos, Pico_76_SegFixed)
malex= Pico_76_SegFixed2[Pico_76_SegFixed2$CHR%in%'chrX',]
malex2= malex[,4:ncol(malex)]
malex3= apply(malex2, 2, median)
malex4= data.frame(names(malex3),as.numeric(malex3))
saveRDS(malex4, file= file.path('./data/processed/rds', paste0(filenamex, '_male_median.rds')) )

Pico_76_SegFixed3= Pico_76_SegFixed2[(Pico_76_SegFixed2$CHR %in% c(paste0("chr",1:22))),]
Pico_76_SegFixed3= Pico_76_SegFixed3[,-c(1:3)]

Pico_76_SegCopy= readRDS(file.path('./data/processed/rds', paste0('SegCopy_', filenamex, '.rds')))
Pico_76_SegCopy=  Pico_76_SegCopy[,colnames(Pico_76_SegCopy)%in%picocells_passing_mad_conf]
Pico_76_SegCopy2= cbind(Pico_76_pos, Pico_76_SegCopy)
Pico_76_SegCopy3= Pico_76_SegCopy2[(Pico_76_SegCopy2$CHR %in% c(paste0("chr",1:22))),]
Pico_76_SegCopy3=Pico_76_SegCopy3[,-c(1:3)]

# if the CN of the bin is not 2, replace those values with NA
Pico_76_SegFixed4= Pico_76_SegFixed3
Pico_76_SegFixed4[Pico_76_SegCopy3 != 2] <- NA
Pico_76_posx= Pico_76_pos[Pico_76_pos$CHR%in%c(paste0("chr",1:22)),]
Pico_76_SegFixed5= cbind(Pico_76_posx[,1], Pico_76_SegFixed4)
colnames(Pico_76_SegFixed5)[1] = 'Chr'
nn= length(colnames(Pico_76_SegFixed5))-1
sample_names = colnames(Pico_76_SegFixed5)[-1] 

medians =rbind()
for (y in 1:nn){
  idx=   sample_names[y]
  for (i in 1:22){
              chrx=          paste0('chr',i)
              datax=         Pico_76_SegFixed5[Pico_76_SegFixed5$Chr%in%chrx,]
              datax2=        datax[,idx]
              na_positions = c(0, which(is.na(datax2)), length(datax2) + 1)
              
                for (i in 1:(length(na_positions) - 1)) {
                  start =        na_positions[i] + 1
                  end   =        na_positions[i + 1] - 1
                  segment_data = datax2[start:end]
                  segment_data = segment_data[!is.na(segment_data)]
                
                  if (length(segment_data) > 0) {
                    median_val =  median(segment_data)
                    aa=           c(chrx, idx, median_val, length(segment_data))
                    medians    =  rbind(medians, aa)  }}}}
medians=data.frame(medians)
colnames(medians)= c('chr','id','Medians','Count')
medians$Medians=   as.numeric(medians$Medians)
medians$Count=     as.numeric(medians$Count)

saveRDS(medians, file= file.path('./data/processed/rds', paste0(filenamex, '_diploidregions.rds')))