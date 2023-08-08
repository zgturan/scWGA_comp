source('./scripts/01_Setup.R')
key_df <- data.frame(Variable = c('id',
                                  "amplification method",
                                  "bin size", 
                                  "MAD",
                                  "hg38_500kb_MAD",
                                  "confidence score",
                                  "hg38_500kb_confidence_score",
                                  "number of reads",
                                  "hg38",
                                  "Liftover",
                                  "T2T",
                                  "dMDA",
                                  "PTA",
                                  "PicoPLEX",
                                  "NA",
                                  "median_expected_covered_bases"),
                     
                     Description = c('sample identifier',
                                     'single cell whole genome amplification method that was used to amplify the genome of the cell',
                                     "Bin size that was used to run Ginkgo", 
                                     "median absolute deviation; Ginkgo reported MAD values (calculated only for autosomes)",
                                     "median absolute deviation was calculated using 500 Mb bin size (calculated only for autosomes)",
                                     "confidence score; confidence score was calculated as described in Perez-Rodriguez et al. 2019 (calculated only for autosomes)",
                                     "confidence score that was calculated using 500 Mb bin size (calculated only for autosomes)",
                                     "The number of reads reported by Ginkgo",
                                     "human genome version 38",
                                     "data was aligned to T2T, and performed liftover to hg38 using levioSAM2",
                                     "telomere-to-telomere",
                                     "droplet multiple displacement amplification",
                                     "primary template-directed amplification",
                                     "PicoPLEX WGA (Whole Genome Amplification) Kit",
                                     "not available",
                                     "Median of the 'EXPECTED_COVERED_BASES' column that was obtained by using Preseq"))

Confid_MAD_VariableSize_hg38_xlsx <- readRDS("./data/processed/rds/Confid_MAD_VariableSize_hg38_xlsx.rds")
standardize_name <- function(name) {
  return(gsub('[^0-9a-zA-Z]+', '_', name))}
Confid_MAD_VariableSize_hg38_xlsx$id=      standardize_name(Confid_MAD_VariableSize_hg38_xlsx$id)
Confid_MAD_VariableSize_hg38_xlsx[is.na(Confid_MAD_VariableSize_hg38_xlsx)] <- "NA"
Confid_MAD_VariableSize_hg38_xlsx = Confid_MAD_VariableSize_hg38_xlsx [-which(colnames(Confid_MAD_VariableSize_hg38_xlsx) == 'version')]
colnames(Confid_MAD_VariableSize_hg38_xlsx) = gsub('MAD', 'hg38_MAD', colnames(Confid_MAD_VariableSize_hg38_xlsx) )
colnames(Confid_MAD_VariableSize_hg38_xlsx) = gsub('confidence score', 'hg38_confidence_score', colnames(Confid_MAD_VariableSize_hg38_xlsx) )

delimiters <- ".bowtie|.bt2"
aa2=       strsplit(Confid_MAD_VariableSize_hg38_xlsx$id, delimiters, perl = TRUE)
aa3=       sapply(aa2, function(x)x[1])
Confid_MAD_VariableSize_hg38_xlsx$id=aa3


Confid_MAD_VariableSize_liftover_xlsx <- readRDS("./data/processed/rds/Confid_MAD_VariableSize_liftover_xlsx.rds")
Confid_MAD_VariableSize_liftover_xlsx$id=      standardize_name(Confid_MAD_VariableSize_liftover_xlsx$id)
Confid_MAD_VariableSize_liftover_xlsx[is.na(Confid_MAD_VariableSize_liftover_xlsx)] <- "NA"
Confid_MAD_VariableSize_liftover_xlsx = Confid_MAD_VariableSize_liftover_xlsx [-which(colnames(Confid_MAD_VariableSize_liftover_xlsx) == 'version')]
colnames(Confid_MAD_VariableSize_liftover_xlsx) = gsub('MAD', 'Liftover_MAD', colnames(Confid_MAD_VariableSize_liftover_xlsx) )
colnames(Confid_MAD_VariableSize_liftover_xlsx) = gsub('confidence score', 'Liftover_confidence_score', colnames(Confid_MAD_VariableSize_liftover_xlsx))

delimiters <- ".bowtie|.bt2"
aa2=       strsplit(Confid_MAD_VariableSize_liftover_xlsx$id, delimiters, perl = TRUE)
aa3=       sapply(aa2, function(x)x[1])
Confid_MAD_VariableSize_liftover_xlsx$id= aa3


Confid_MAD_VariableSize_t2t_xlsx <- readRDS("./data/processed/rds/Confid_MAD_VariableSize_t2t_xlsx.rds")
Confid_MAD_VariableSize_t2t_xlsx$id=      standardize_name(Confid_MAD_VariableSize_t2t_xlsx$id)
Confid_MAD_VariableSize_t2t_xlsx[is.na(Confid_MAD_VariableSize_t2t_xlsx)] <- "NA"
Confid_MAD_VariableSize_t2t_xlsx = Confid_MAD_VariableSize_t2t_xlsx [-which(colnames(Confid_MAD_VariableSize_t2t_xlsx) == 'version')]
colnames(Confid_MAD_VariableSize_t2t_xlsx) = gsub('MAD', 'T2T_MAD', colnames(Confid_MAD_VariableSize_t2t_xlsx) )
colnames(Confid_MAD_VariableSize_t2t_xlsx) = gsub('confidence score', 'T2T_confidence_score', colnames(Confid_MAD_VariableSize_t2t_xlsx))

delimiters <- ".bowtie|.bt2"
aa2=       strsplit(Confid_MAD_VariableSize_t2t_xlsx$id, delimiters, perl = TRUE)
aa3=       sapply(aa2, function(x)x[1])
Confid_MAD_VariableSize_t2t_xlsx$id=aa3

Merged_readnumber_xlsx <- readRDS("./data/processed/rds/Merged_readnumber_xlsx.rds")
standardize_name <- function(name) {
  return(gsub('[^0-9a-zA-Z]+', '_', name))}
Merged_readnumber_xlsx$id=      standardize_name(Merged_readnumber_xlsx$id)
Merged_readnumber_xlsx[is.na(Merged_readnumber_xlsx)] <- "NA"
head(Merged_readnumber_xlsx)
colnames(Merged_readnumber_xlsx) = gsub('data', 'amplification method', colnames(Merged_readnumber_xlsx) )

Merged_preseq_xlsx <- readRDS("./data/processed/rds/Merged_preseq_xlsx.rds")
standardize_name <- function(name) {
  return(gsub('[^0-9a-zA-Z]+', '_', name))}
Merged_preseq_xlsx$id=      standardize_name(Merged_preseq_xlsx$id)
Merged_preseq_xlsx[is.na(Merged_preseq_xlsx)] <- "NA"
head(Merged_preseq_xlsx)
colnames(Merged_preseq_xlsx) = gsub('data', 'amplification method', colnames(Merged_preseq_xlsx) )


merged_data <- full_join(Confid_MAD_VariableSize_hg38_xlsx, Confid_MAD_VariableSize_liftover_xlsx, by = c("id", "amplification method")) %>%
  full_join(., Confid_MAD_VariableSize_t2t_xlsx, by = c("id", "amplification method")) %>%
  full_join(., Merged_readnumber_xlsx, by = c("id", "amplification method")) %>%
  full_join(., Merged_preseq_xlsx, by = c("id", "amplification method"))


merged_data_dmda=   merged_data[merged_data$`amplification method`%in%'dMDA',]
merged_data_dmda =  merged_data_dmda [-which(colnames(merged_data_dmda) == 'bin size.x')]
merged_data_dmda =  merged_data_dmda [-which(colnames(merged_data_dmda) == 'bin size.y')]
merged_data_dmda= merged_data_dmda[,c("id", "amplification method","bin size",
                                     "hg38_number of reads",
                                     "hg38_median_expected_covered_bases",
                                     "hg38_confidence_score" ,                           
                                     "hg38_MAD",
                                     "Liftover_number of reads",
                                     "Liftover_median_expected_covered_bases", 
                                     "Liftover_confidence_score",
                                     "Liftover_MAD", 
                                     "T2T_number of reads" ,                  
                                     "T2T_median_expected_covered_bases",
                                     "T2T_confidence_score",
                                     "T2T_MAD")]

merged_data_dmda[is.na(merged_data_dmda)] <- "NA"

merged_data_t2t=   merged_data[merged_data$`amplification method`%in%'PicoPLEX',]
merged_data_t2t =  merged_data_t2t [-which(colnames(merged_data_t2t) == 'bin size.x')]
merged_data_t2t =  merged_data_t2t [-which(colnames(merged_data_t2t) == 'bin size.y')]
merged_data_t2t=   merged_data_t2t[,c("id", "amplification method","bin size",
                                      "hg38_number of reads",
                                      "hg38_median_expected_covered_bases",
                                      "hg38_confidence_score" ,                           
                                      "hg38_MAD",
                                      "Liftover_number of reads",
                                      "Liftover_median_expected_covered_bases", 
                                      "Liftover_confidence_score",
                                      "Liftover_MAD", 
                                      "T2T_number of reads" ,                  
                                      "T2T_median_expected_covered_bases",
                                      "T2T_confidence_score",
                                      "T2T_MAD")]

merged_data_t2t[is.na(merged_data_t2t)] <- "NA"

merged_data_liftover=   merged_data[merged_data$`amplification method`%in%'PTA',]
merged_data_liftover =  merged_data_liftover [-which(colnames(merged_data_liftover) == 'bin size.x')]
merged_data_liftover =  merged_data_liftover [-which(colnames(merged_data_liftover) == 'bin size.y')]
merged_data_liftover=   merged_data_liftover[,c("id", "amplification method","bin size",
                                                "hg38_number of reads",
                                                "hg38_median_expected_covered_bases",
                                                "hg38_confidence_score" ,                           
                                                "hg38_MAD",
                                                "Liftover_number of reads",
                                                "Liftover_median_expected_covered_bases", 
                                                "Liftover_confidence_score",
                                                "Liftover_MAD", 
                                                "T2T_number of reads" ,                  
                                                "T2T_median_expected_covered_bases",
                                                "T2T_confidence_score",
                                                "T2T_MAD")]

merged_data_liftover[is.na(merged_data_liftover)] <- "NA"
###############################
Confid_MAD_500kb_hg38_xlsx <- readRDS("./data/processed/rds/Confid_MAD_500kb_hg38_xlsx.rds")
Confid_MAD_500kb_hg38_xlsx$id=      standardize_name(Confid_MAD_500kb_hg38_xlsx$id)
Confid_MAD_500kb_hg38_xlsx[is.na(Confid_MAD_500kb_hg38_xlsx)] <- "NA"
Confid_MAD_500kb_hg38_xlsx = Confid_MAD_500kb_hg38_xlsx [-which(colnames(Confid_MAD_500kb_hg38_xlsx) == 'version')]
Confid_MAD_500kb_hg38_xlsx = Confid_MAD_500kb_hg38_xlsx [-which(colnames(Confid_MAD_500kb_hg38_xlsx) == 'bin size')]
colnames(Confid_MAD_500kb_hg38_xlsx) = gsub('MAD', 'hg38_500kb_MAD', colnames(Confid_MAD_500kb_hg38_xlsx) )
colnames(Confid_MAD_500kb_hg38_xlsx) = gsub('confidence score', 'hg38_500kb_confidence_score', colnames(Confid_MAD_500kb_hg38_xlsx))

head(Confid_MAD_500kb_hg38_xlsx)

dmda_hg38_500x= Confid_MAD_500kb_hg38_xlsx[Confid_MAD_500kb_hg38_xlsx$`amplification method`%in%'dMDA',]
head(dmda_hg38_500x)
dim(dmda_hg38_500x)
# 43  4
head(merged_data_dmda)
dim(merged_data_dmda)
# 43 15
merged_data_dmdax <- full_join(merged_data_dmda, dmda_hg38_500x, by = c("id", "amplification method"))
head(merged_data_dmdax)


Pico_hg38_500x= Confid_MAD_500kb_hg38_xlsx[Confid_MAD_500kb_hg38_xlsx$`amplification method`%in%'PicoPLEX',]
head(Pico_hg38_500x)
dim(Pico_hg38_500x)
# 37  4
head(merged_data_t2t)
dim(merged_data_t2t)
# 37 15
merged_data_Picox <- full_join(merged_data_t2t, Pico_hg38_500x, by = c("id", "amplification method"))
head(merged_data_Picox)
###############################
discard=  c('A100_Exp6_2_sn2_P70_06_CC_dMDA_Purif4_S50_R','A32_dMDA_Exp6.2_sn2_P70.06_CC_S31_R',
            'A8_dMDA_Exp6.2_sn2_P70.06_CC_S8_R',
            'L4Exp8_1sn10_S18_R', 'L34Exp8_1sn10_S19_R',
            'L17Exp8_1sn6_S20_R', 'L32Exp8_1sn6_S21_R',
            'L6Exp8_1PC1100pg_ulgDNAP67_10FC_S22_R', 
            'L8Exp8_1PC215pg_ulgDNAP67_10FC_S23_R',
            'L16TestPTA_25_cells2_S24_R')

discard=standardize_name(discard)

merged_data_dmdax= merged_data_dmdax[!merged_data_dmdax$id%in%discard,]
delimx= "_P70|_P67|_Fibr|_P55"
res1_dmda= strsplit(merged_data_dmdax$id, delimx, perl = T)
merged_data_dmdax$id=  sapply(res1_dmda, function(x) x[1])
head(merged_data_dmdax)


merged_data_Picox= merged_data_Picox[!merged_data_Picox$id%in%discard,]
res1_pico= strsplit(merged_data_Picox$id, delimx, perl = T)
merged_data_Picox$id=  sapply(res1_pico, function(x) x[1])
head(merged_data_Picox)


merged_data_liftover= merged_data_liftover[!merged_data_liftover$id%in%discard,]
res1_lift= strsplit(merged_data_liftover$id, delimx, perl = T)
merged_data_liftover$id=  sapply(res1_lift, function(x) x[1])
head(merged_data_liftover)


wb <- createWorkbook()
addWorksheet(wb, "KEY")
addWorksheet(wb, "A)dMDA")
addWorksheet(wb, "B)PicoPLEX")
addWorksheet(wb, "C)PTA")

writeData(wb, "KEY", key_df)
writeData(wb, "A)dMDA", merged_data_dmdax)
writeData(wb, "B)PicoPLEX", merged_data_Picox)
writeData(wb, "C)PTA", merged_data_liftover)

saveWorkbook(wb, "./results/scWGS_Comparison_Statistics_Jul13_2023_paper.xlsx", overwrite = TRUE)

