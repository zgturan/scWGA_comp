source('./scripts/01_Setup.R')

SignificantCells <- readRDS("./data/processed/rds/SignificantCells.rds")

SignificantCells= SignificantCells[SignificantCells$data%in% c('PTA', 'PicoPLEX'),]
delimiters = ".bowtie|.bt2"
aa=  strsplit(SignificantCells$id, delimiters, perl=T)
aa2= sapply(aa, function(x) x[1])
aa2= standardize_name(aa2)
SignificantCells$id= aa2
SignificantCells_lift= SignificantCells[SignificantCells$version%in%'LiftOver - T2T to hg38',]
SignificantCells_t2t=  SignificantCells[SignificantCells$version%in%'T2T',]
SignificantCells_liftx= SignificantCells_lift[!SignificantCells_lift$id%in%"A14_v2_Exp9_1_sn1_06_CC_S14_R",]
SignificantCells_t2tx=  SignificantCells_t2t[SignificantCells_t2t$id%in%SignificantCells_liftx$id,]


SignificantCells_liftxx= SignificantCells_liftx[SignificantCells_liftx$cnv > 2, c('chr','start','end','id')]
SignificantCells_liftxx= SignificantCells_liftxx[!SignificantCells_liftxx$chr %in% c('chrX', 'chrY'),]
unique_id_lift= unique(SignificantCells_liftxx$id)
for (x in 1:length(unique_id_lift)) {
  idx=           unique_id_lift[x]
  cnv_value=     SignificantCells_liftxx[SignificantCells_liftxx$id%in%idx, c('chr','start','end' )]
  write.table(cnv_value, file= file.path('./data/processed/t2t_gains/', 
                                        paste0(idx, '_lift.bed')),
              quote = FALSE,sep = "\t",
              row.names = FALSE, col.names = FALSE)
}


SignificantCells_t2txx= SignificantCells_t2tx[SignificantCells_t2tx$cnv > 2, c('chr','start','end','id')]
SignificantCells_t2txx= SignificantCells_t2txx[!SignificantCells_t2txx$chr%in%c('chrX','chrY'),]
unique_id_t2t= unique(SignificantCells_t2txx$id)
for (x in 1:length(unique_id_t2t)) {
  idx=           unique_id_t2t[x]
  cnv_value=     SignificantCells_t2txx[SignificantCells_t2txx$id%in%idx, c('chr','start','end')]
  write.table(cnv_value, file= file.path('./data/processed/t2t_gains/', 
                                        paste0(idx, '_t2t.bed')),
              quote = FALSE,sep = "\t",
              row.names = FALSE, col.names = FALSE)
}
