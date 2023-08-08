args <- commandArgs(trailingOnly = T)
filenamex=as.character(args[[1]])

standardize_name <- function(name) {
  return(gsub('[^0-9a-zA-Z]+', '_', name))}
selectedCells	= read.table(file.path('./data/processed/', filenamex, 'analysis'), header=TRUE)
delimiters = ".bowtie|.bt2"
samp <- readRDS("./data/processed/rds/SampleInfo.rds")
wer=  strsplit(samp$File_name, delimiters, perl = TRUE)
samp$File_name=  standardize_name(sapply(wer, function(x) x[1]))
excc= samp[samp$Sample%in%c('NA12878',"Fibr", "Bulk gDNA P67/10 FC", "NA12878 5 cells"),'File_name']
delimiters = ".bowtie|.bt2"
aa2=         strsplit(selectedCells$mad, delimiters, perl = TRUE)
aa3=         sapply(aa2, function(x) x[1])
aa3=         standardize_name(aa3)
discard=     c('A100_Exp6_2_sn2_06_CC_dMDA_Purif4_S50_R','A32_dMDA_Exp6.2_sn2_06_CC_S31_R',
               'A8_dMDA_Exp6.2_sn2_06_CC_S8_R','L4Exp8_1sn10_S18_R', 'A99_Exp1_8_3_sn10_10_FC_dMDA_S49_R',
               'L34Exp8_1sn10_S19_R','L17Exp8_1sn6_S20_R', 'L32Exp8_1sn6_S21_R','L25Exp9_1sn9_S8_R', 
               'L26Exp9_1sn10_S9_R',
               'A15_PTA_Exp8.1_sn3__10_FC_S15_R','L19Exp8_1sn7_S3_R','L9TestPTA_2singlecell_3_S2_R',
               'A30_v2_Exp7.2_sn1_01_CC_S30_R','L6Exp8_1PC1100pg_ulgDNA10FC_S22_R', 
               'L8Exp8_1PC215pg_ulgDNA10FC_S23_R','L16TestPTA_25_cells2_S24_R')
discard= standardize_name(discard)
# 16
discard6= which(aa3%in%discard)

if (length(discard6) != 0) {
  selectedCells = selectedCells[-discard6,]
  
} else{
  selectedCells =selectedCells[,1]
}

analysisType	= "gc"
analysisID <-   "analysis"
loc= readRDS(file.path('./data/processed/rds', paste0('location_', filenamex, '.rds')))
loca= loc[loc$CHR%in%paste0('chr', 1:22),]
autosomes= nrow(loca)

raw = read.table(file.path('./data/processed/', filenamex, 'data'), header=TRUE, sep="\t")
raw = raw[1:autosomes,]
GC = readRDS(file.path('./data/processed/rds', paste0(filenamex, '_gc','.rds')))
GC= GC[1:autosomes,]
GC= data.frame(GC)
colnames(GC)='V1'
l = dim(raw)[1] # Number of bins
w = dim(raw)[2] # Number of samples

normal = sweep(raw+1, 2, colMeans(raw+1), '/')
normal2 = normal
# --
cellIDs = c()
for(i in 1:length(selectedCells))
  cellIDs[i] = which(colnames(raw) == as.character(selectedCells[i]))

if(is.null(cellIDs))
  stop("Error")

gc_values <- list()
if(analysisType == "gc")
{
  jpeg(filename= file.path('./data/processed',filenamex, paste0(filenamex, '_', analysisType,".jpeg")), 
       width=1400, height=1000)
  legendNames = c()
  plottedFirst = 0
  for(j in 1:length(cellIDs))
  {
    k = cellIDs[j]
    low = lowess(GC[,1], log(normal2[,k]), f=0.05)
    app = approx(low$x, low$y, GC[,1])
    cor = exp(log(normal2[,k]) - app$y)
    df <- data.frame(GC_Content = GC[,1], Log_Normalized_Read_Counts = log(normal2[,k]), Fitted_Values = app$y)
    df$cellID = paste0(filenamex, '_', j, '_', selectedCells[j])
    gc_values[[j]] <- df
    if(plottedFirst == 0) {
      par(mar=c(5.1, 4.1, 4.1, 18), xpd=TRUE)
      try(plot(GC[,1], log(normal2[,k]), main="GC Content vs. Bin Counts", type= "n", xlim=c(min(.3, min(GC[,1])),  
                                                                                             max(.6, max(GC[,1]))), 
               xlab="GC content", ylab="Normalized Read Counts (log scale)", cex.main=2, cex.axis=1.5, cex.lab=1.5))
    } else {
      try(points(GC[,1], log(normal2[,k]), type="n"))
    }
    if(plottedFirst == 0)
    {
      tu = par('usr')
      rect(tu[1], tu[3], tu[2], tu[4], col = "gray85")
      abline(v=axTicks(1), col="white", lwd=2)
      abline(h=axTicks(2), col="white", lwd=2)
    }
    plottedFirst = 1
    try(points(app, col=rainbow(length(cellIDs))[j] ))
  }
  dev.off()
  file.create(paste(analysisID,'.done', sep=""))
}
all_data <- do.call(rbind, gc_values)
unique(all_data$cellID)
saveRDS(all_data, file= file.path('./data/processed/rds', paste0(filenamex, '_gc_plot.rds')))