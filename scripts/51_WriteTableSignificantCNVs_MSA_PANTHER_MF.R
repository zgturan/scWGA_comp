source('./scripts/01_Setup.R')

datax <- read.table("./data/processed/txt/MSA_PANTHER_MF_GOslim.txt", sep = "\t", header=T, skip=11, quote = "", stringsAsFactors = FALSE)
datax2= datax[,c(1,7)]
aa= grep('Unclassified', datax2$PANTHER.GO.Slim.Molecular.Function,value = T)
datax2= datax2[!datax2$PANTHER.GO.Slim.Molecular.Function%in%aa,]
delimiters = "\\(G"
aa2=         strsplit(datax2[,1], delimiters, perl = TRUE)
aa3=         sapply(aa2, function(x) x[2])
aa4= gsub(')', '', aa3)
aa5= paste0('G',aa4)
aa6= cbind(aa5, datax2[2])
write.table(aa6, file = "./data/processed/txt/MSA_REVIGO_MF_GOslim.txt", sep = "\t",quote = F,
            row.names = F, col.names = F)
