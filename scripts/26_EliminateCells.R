args <- commandArgs(trailingOnly = T)
CNVnamesx= as.character(args[[1]])

source('./scripts/01_Setup.R')
standardize_name <- function(name) {
  return(gsub('[^0-9a-zA-Z]+', '_', name))}


Confid_MAD_VariableSize_hg38_xlsx <- readRDS(file.path('./data/processed/rds', paste0(CNVnamesx, ".rds")))
delimiters = ".bowtie|.bt2"
aa2=         strsplit(Confid_MAD_VariableSize_hg38_xlsx$id, delimiters, perl = TRUE)
aa3=         sapply(aa2, function(x) x[1])
aa3=         standardize_name(aa3)
discard=     standardize_name(c('A100_Exp6_2_sn2_06_CC_dMDA_Purif4_S50_R','A32_dMDA_Exp6.2_sn2_06_CC_S31_R',
                                'A8_dMDA_Exp6.2_sn2_06_CC_S8_R','L4Exp8_1sn10_S18_R', 'A99_Exp1_8_3_sn10_10_FC_dMDA_S49_R',
                                'L34Exp8_1sn10_S19_R','L17Exp8_1sn6_S20_R', 'L32Exp8_1sn6_S21_R','L25Exp9_1sn9_S8_R', 
                                'L26Exp9_1sn10_S9_R',
                                'A15_PTA_Exp8.1_sn3__10_FC_S15_R','L19Exp8_1sn7_S3_R','L9TestPTA_2singlecell_3_S2_R',
                                'A30_v2_Exp7.2_sn1_01_CC_S30_R','L6Exp8_1PC1100pg_ulgDNA10FC_S22_R', 
                                'L8Exp8_1PC215pg_ulgDNA10FC_S23_R','L16TestPTA_25_cells2_S24_R'))
discard6=    which(aa3%in%discard)
Confid_MAD_VariableSize_hg38_xlsx= Confid_MAD_VariableSize_hg38_xlsx[-discard6,]
colnames(Confid_MAD_VariableSize_hg38_xlsx)[colnames(Confid_MAD_VariableSize_hg38_xlsx) == "confidence score"] <- "confidence_score"
Confid_MAD_VariableSize_hg38_xlsx2= Confid_MAD_VariableSize_hg38_xlsx[(Confid_MAD_VariableSize_hg38_xlsx$MAD <= 0.3) & 
                                                                      (Confid_MAD_VariableSize_hg38_xlsx$confidence_score >= 0.7),]

Confid_MAD_VariableSize_hg38_xlsx2= Confid_MAD_VariableSize_hg38_xlsx2[Confid_MAD_VariableSize_hg38_xlsx2$`amplification method`%in%
                                                                         unique(grep('PicoPLEX|PTA', Confid_MAD_VariableSize_hg38_xlsx2$`amplification method`, value=T)),]

dim(Confid_MAD_VariableSize_hg38_xlsx2)
colnames(Confid_MAD_VariableSize_hg38_xlsx2)
dim(Confid_MAD_VariableSize_hg38_xlsx2)

Confid_MAD_VariableSize_hg38_xlsx2$id

summary(Confid_MAD_VariableSize_hg38_xlsx2[,'MAD'])
summary(Confid_MAD_VariableSize_hg38_xlsx2[,'confidence_score'])
# 40  6

all2x=Confid_MAD_VariableSize_hg38_xlsx2

write.table(paste0(all2x$id,'.pdf'), row.names = F, col.names = F, quote= F,sep = '\n',
            file=file.path('./data/processed/txt', paste0(CNVnamesx, "_filteredcells")))

CNV1_hg38 <- readRDS(file.path('./data/processed/rds', paste0(CNVnamesx, "_CNV1.rds")))
CNV1_hg38= CNV1_hg38[CNV1_hg38$chr%in% c(paste0('chr',1:22),'chrX'),]
CNV1_hg38= CNV1_hg38[(CNV1_hg38$id%in%all2x$id),]
saveRDS(CNV1_hg38, 
        file= file.path('./data/processed/rds', paste0(CNVnamesx, "_filteredCNVscells.rds")))  

CNV1_hg38= CNV1_hg38[CNV1_hg38$chr%in%paste0('chr',1:22),]
total_cnv= nrow(CNV1_hg38)
data1= data.frame(table(CNV1_hg38$cnv))
deletions=    sum(data1[data1$Var1%in%c(0,1),'Freq'])
duplications= sum(data1[!data1$Var1%in%c(0,1),'Freq'])


final_number=                  cbind(CNVnamesx, 
                                    nrow(Confid_MAD_VariableSize_hg38_xlsx2),
                                    nrow(all2x), 
                                    round(100*(nrow(all2x)/nrow(Confid_MAD_VariableSize_hg38_xlsx2)),2), 
                                    total_cnv, deletions, duplications)
colnames(final_number)=       c('data',
                                'total_numberofcells', 
                                'aftermadconfi_cellnumber', 
                                'percentofremainingcells',
                                'aftermadconfi_total_cnv', 
                                'aftermadconfi_deletions' ,
                                'aftermadconfi_duplications')

saveRDS(final_number, file= file.path('./data/processed/rds', paste0(CNVnamesx, '_CNVTable.rds')))
