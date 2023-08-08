args <- commandArgs(trailingOnly = T)
filenamex=as.character(args[[1]])

selectedCells	= read.table(file.path('./data/processed/', filenamex, 'analysis'), header=TRUE)
analysisType	= "mad"
analysisID <-   "analysis"
loc= readRDS(file.path('./data/processed/rds', paste0('location_', filenamex, '.rds')))
loca= loc[loc$CHR%in%paste0('chr', 1:22),]
autosomes= nrow(loca)
raw = read.table(file.path('./data/processed/',filenamex, 'data'), header=TRUE, sep="\t")
dim(raw)
raw = raw[1:autosomes,]
l = dim(raw)[1] # Number of bins
w = dim(raw)[2] # Number of samples
#
normal = sweep(raw+1, 2, colMeans(raw+1), '/')
normal2 = normal
# --
cellIDs = c()
for(i in 1:length(selectedCells[,1]))
  cellIDs[i] = which(colnames(raw) == as.character(selectedCells[i, 1]))

if(is.null(cellIDs))
  stop("Error")

a = matrix(0, length(cellIDs), 4)
rownames(a) <- colnames(normal[,cellIDs])

for(i in 1:length(cellIDs)){
    cell = cellIDs[i]
    a[i, 1] = mad(normal[-1    , cell] - normal[1:(l-1), cell])   # same as diff()
    a[i, 2] = mad(normal[-(1:2), cell] - normal[1:(l-2), cell])
    a[i, 3] = mad(normal[-(1:3), cell] - normal[1:(l-3), cell])
    a[i, 4] = mad(normal[-(1:4), cell] - normal[1:(l-4), cell])
    }   
a2= data.frame(rownames(a), as.numeric(a[,1]), filenamex)
colnames(a2)=c('V1','V2','V3')

saveRDS(a2, file= file.path('./data/processed/rds', paste0('MAD_', filenamex, '.rds')))

