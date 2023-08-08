args <- commandArgs(trailingOnly = T)
filenamex= as.character(args[[1]])

standardize_name <- function(name) {
  return(gsub('[^0-9a-zA-Z]+', '_', name))}
selectedCells	= read.table(file.path('./data/processed/', filenamex, 'analysis'), header=TRUE)
delimiters = ".bowtie|.bt2"
samp <- readRDS("./data/processed/rds/SampleInfo.rds")
wer=  strsplit(samp$File_name, delimiters, perl = TRUE)

samp$File_name=  standardize_name(sapply(wer, function(x) x[1]))
excc= samp[samp$Sample%in%c('NA12878',"Fibr", "Bulk gDNA P67/10 FC", "NA12878 5 cells"),'File_name']
aa2=         strsplit(selectedCells$mad, delimiters, perl = TRUE)
aa3=         sapply(aa2, function(x) x[1])
aa3=         standardize_name(aa3)
discard=     c('A100_Exp6_2_sn2_06_CC_dMDA_Purif4_S50_R','A32_dMDA_Exp6.2_sn2_06_CC_S31_R',
             'A8_dMDA_Exp6.2_sn2_06_CC_S8_R','L4Exp8_1sn10_S18_R', 'A99_Exp1_8_3_sn10_10_FC_dMDA_S49_R',
             'L34Exp8_1sn10_S19_R','L17Exp8_1sn6_S20_R', 'L32Exp8_1sn6_S21_R','L25Exp9_1sn9_S8_R', 
             'L26Exp9_1sn10_S9_R',
             'A15_PTA_Exp8.1_sn3__10_FC_S15_R','L19Exp8_1sn7_S3_R','L9TestPTA_2singlecell_3_S2_R',
             'A30_v2_Exp7.2_sn1_01_CC_S30_R','L6Exp8_1PC1100pg_ulgDNA10FC_S22_R', 
             'L8Exp8_1PC215pg_ulgDNA10FC_S23_R','L16TestPTA_25_cells2_S24_R', excc)
discard= standardize_name(discard)
# 16
discard6= which(aa3%in%discard)
if (length(discard6) != 0) {
  selectedCells = selectedCells[-discard6,]
} else{
  selectedCells =selectedCells[,1]
  }

analysisType	= "lorenz"
analysisID <-   "analysis"
loc= readRDS(file.path('./data/processed/rds', paste0('location_', filenamex, '.rds')))
loca= loc[loc$CHR%in%paste0('chr', 1:22),]
autosomes= nrow(loca)
raw = read.table(file.path('./data/processed/',filenamex, 'data'), header=TRUE, sep="\t")
raw = raw[1:autosomes,]
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

values <- list()

if(analysisType == "lorenz") {
  jpeg(filename= file.path('./data/processed', filenamex, paste0(filenamex, '_', analysisType,".jpeg")), width=1400, height=1000)
  plottedFirst = 0
  for(j in 1:length(cellIDs)) {
    k = cellIDs[j]
    
    nReads = sum(raw[,k])
    uniq = unique(sort(raw[,k]))
    lorenz = matrix(0, nrow=length(uniq), ncol=2)
    a = c(length(which(raw[,k]==0)), tabulate(raw[,k], nbins=max(raw[,k])))
    b = a*(0:(length(a)-1))
    for (i in 2:length(uniq)) {
      lorenz[i,1] = sum(a[1:uniq[i]]) / l
      lorenz[i,2] = sum(b[2:uniq[i]]) / nReads
    }
    
    if(plottedFirst == 0) {
      par(mar=c(5.1, 4.1, 4.1, 18), xpd=TRUE)
      plot(lorenz, type="n", xlim=c(0,1), main=paste0("Lorenz Curve of Coverage Uniformity_", filenamex), 
           xlab="Cumulative Fraction of Genome", ylab="Cumulative Fraction of Total Reads", xaxt="n", 
           yaxt="n", cex.main=2, cex.axis=1.5, cex.lab=1.5)
    } else {
      points(lorenz, type="n")
    }
    
    if(plottedFirst == 0) {
      tu = par('usr')
      rect(tu[1], tu[3], tu[2], tu[4], col = "gray85")
      abline(h=seq(0,1,.1), col="white", lwd=2)
      abline(v=seq(0,1,.1), col="white", lwd=2)
      axis(side=1, at=seq(0,1,.1), tcl=.5, cex.axis=2)
      axis(side=2, at=seq(0,1,.1), tcl=.5, cex.axis=2)
      axis(side=3, at=seq(0,1,.1), tcl=.5, cex.axis=2, labels=FALSE)
      axis(side=4, at=seq(0,1,.1), tcl=.5, cex.axis=2, labels=FALSE)
      lines(c(0,1), c(0,1), lwd=2.5)
      tu = par('usr')
    }
    
    plottedFirst = 1
    try(lines(smooth.spline(lorenz), col=rainbow(length(cellIDs))[j], lwd=2.5), silent=TRUE)
    values[[j]] <- list("cellID" = paste0(filenamex, '_',j), "nReads" = nReads, "lorenz" = lorenz)
  }
  dev.off()
  file.create(paste(analysisID,'.done', sep=""))
}

cellID= cellIDs
data_list <- list()
for (j in 1:length(values)) {
  data = as.data.frame(values[[j]]$lorenz)
  names(data) = c("CumulativeFractionOfGenome", "CumulativeFractionOfTotalReads")
  data$cellID = rep(values[[j]]$cellID, nrow(data))
  data_list[[j]] = data}
all_data = do.call(rbind, data_list)
saveRDS(all_data, file= file.path('./data/processed/rds', paste0(filenamex, '_lorenz.rds')))
