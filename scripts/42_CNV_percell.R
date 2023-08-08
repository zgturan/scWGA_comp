source('./scripts/01_Setup.R')

SampleInfo2= readRDS('./data/processed/rds/SampleInfo.rds')
SampleInfo2$Amplification.Method= gsub("PicoPlex v2|PicoPlex v3", 'PicoPlex', SampleInfo2$Amplification.Method)
delimiters = ".bowtie|.bt2"
aa2=         strsplit(SampleInfo2$File_name, delimiters, perl = TRUE)
aa3=         sapply(aa2, function(x) x[1])
aa3=         standardize_name(aa3)
SampleInfo2$File_name= aa3
discard=  standardize_name(c('A100_Exp6_2_sn2_sample2_06_CC_dMDA_Purif4_S50_R','A32_dMDA_Exp6.2_sn2_sample2.06_CC_S31_R',
                             'A8_dMDA_Exp6.2_sn2_sample2.06_CC_S8_R','L4Exp8_1sn10_S18_R', 
                             'L34Exp8_1sn10_S19_R','L17Exp8_1sn6_S20_R', 'L32Exp8_1sn6_S21_R',
                             'L25Exp9_1sn9_S8_R','L26Exp9_1sn10_S9_R',
                             'A15_PTA_Exp8.1_sn3__sample1.10_FC_S15_R',
                             'L19Exp8_1sn7_S3_R','L9TestPTA_2singlecell_3_S2_R',
                             'A30_v2_Exp7.2_sn1_sample3.01_CC_S30_R','L6Exp8_1PC1100pg_ulgDNAsample1_10FC_S22_R', 
                             'L8Exp8_1PC215pg_ulgDNAsample1_10FC_S23_R','L16TestPTA_25_cells2_S24_R'))
SampleInfo3= SampleInfo2[!SampleInfo2$File_name%in%discard,]
################  Total number of PTA cells in the analysis ################  ################ 
SampleInfo2_PTA= SampleInfo2[SampleInfo2$Amplification.Method%in%'PTA',]
SampleInfo2_PTA= SampleInfo2_PTA[SampleInfo2_PTA$'Sample'%in%c('sample1/10 FC', 'sample2/06 CC',"sample3/01 CC", 'Fibr','NA12878'),]
PTA_allcells= data.frame(table(SampleInfo2_PTA$Sample))
################ PTA cells that passing QC ################ ################ ################
CNVs_PTA <- readRDS("./data/processed/rds/CNVs_PTA.rds")
CNVs_PTA= CNVs_PTA[,c('id','data','chr','cn','Sample')]
CNVs_PTA=CNVs_PTA[!CNVs_PTA$chr%in%'chrX',]
CNVs_PTAx= CNVs_PTA[CNVs_PTA$Sample%in%c('sample1/10 FC', 'sample2/06 CC', "sample3/01 CC",'Fibr','NA12878'), c('id', 'Sample')]
CNVs_PTAxx = distinct(CNVs_PTAx)
PTA_qcpassingcells= data.frame(table(CNVs_PTAxx$Sample))
################ PTA cells having significant CNVs ################ ################ ################
PTA_s <- readRDS("./data/processed/rds/SignificantCNVs_PTA.rds")
PT= which(colnames(PTA_s)%in%c('datayy','cn_binsize','start_bin','end_bin','shared_count', 'shared_sample_names', 
                               'shared_ind_number'))
PTA_s= PTA_s[,-PT]
PTA_s= PTA_s[!PTA_s$chr%in%'chrX',]
PTA_s= PTA_s[PTA_s$Sample%in%c('sample1/10 FC', 'sample2/06 CC', "sample3/01 CC",'Fibr','NA12878'), ]

PTA_sample2= PTA_s[PTA_s$Sample%in%'sample2/06 CC',] # how many significant CNVs were identified for PTA-sample2
# Number of amplifications: 4

PTA_sample2_t=     cbind(PTA_allcells[PTA_allcells$Var1%in%'sample2/06 CC', 'Freq'], 
                     PTA_qcpassingcells[PTA_qcpassingcells$Var1%in%'sample2/06 CC', 'Freq'], 
                     length(unique(PTA_sample2$id)), 
                     nrow(PTA_sample2), 
                     nrow(PTA_sample2[PTA_sample2$cn<2,]), 
                     nrow(PTA_sample2[PTA_sample2$cn>2,]))
rownames(PTA_sample2_t)= 'PTA_sample2/06CC_MSA1'
###### ############
PTA_sample1= PTA_s[PTA_s$Sample%in%'sample1/10 FC',] # how many significant CNVs were identified for PTA-sample1
PTA_sample1_t=     cbind(PTA_allcells[PTA_allcells$Var1%in%'sample1/10 FC', 'Freq'], 
                     PTA_qcpassingcells[PTA_qcpassingcells$Var1%in%'sample1/10 FC', 'Freq'], 
                     length(unique(PTA_sample1$id)), 
                     nrow(PTA_sample1), 
                     nrow(PTA_sample1[PTA_sample1$cn<2,]), 
                     nrow(PTA_sample1[PTA_sample1$cn>2,]))
rownames(PTA_sample1_t)= 'PTA_sample1/10FC_Control'
###### ############
PTA_sample3= PTA_s[PTA_s$Sample%in%'sample3/01 CC',] # how many significant CNVs were identified for PTA-sample3
PTA_sample3_t=     cbind(PTA_allcells[PTA_allcells$Var1%in%'sample3/01 CC', 'Freq'], 
                     PTA_qcpassingcells[PTA_qcpassingcells$Var1%in%'sample3/01 CC', 'Freq'], 
                     length(unique(PTA_sample3$id)), 
                     nrow(PTA_sample3), 
                     nrow(PTA_sample3[PTA_sample3$cn<2,]), 
                     nrow(PTA_sample3[PTA_sample3$cn>2,]))
rownames(PTA_sample3_t)= 'PTA_sample3/01CC_MSA2'
###### ############
PTA_NA12878= PTA_s[PTA_s$Sample%in%'NA12878',] # how many significant CNVs were identified for PTA-NA12878
PTA_NA12878_t=     cbind(PTA_allcells[PTA_allcells$Var1%in%'NA12878', 'Freq'], 
                         PTA_qcpassingcells[PTA_qcpassingcells$Var1%in%'NA12878', 'Freq'], 
                         length(unique(PTA_NA12878$id)), 
                         nrow(PTA_NA12878), 
                         nrow(PTA_NA12878[PTA_NA12878$cn<2,]), 
                         nrow(PTA_NA12878[PTA_NA12878$cn>2,]))
rownames(PTA_NA12878_t)= 'PTA_NA12878'
################  Total number of Pico cells in the analysis ################  ################ 
SampleInfo2_Pico= SampleInfo2[SampleInfo2$Amplification.Method%in%'PicoPlex',]
SampleInfo2_Pico= SampleInfo2_Pico[SampleInfo2_Pico$'Sample'%in%c('sample1/10 FC', 'sample2/06 CC',"sample3/01 CC",'Fibr'),]
Pico_allcells= data.frame(table(SampleInfo2_Pico$Sample))
################ Pico cells that passing QC ################ ################ ################
CNVs_PicoPLEX <- readRDS("./data/processed/rds/CNVs_PicoPLEX.rds")
CNVs_PicoPLEX=CNVs_PicoPLEX[!CNVs_PicoPLEX$chr%in%'chrX',]
CNVs_PicoPLEX= CNVs_PicoPLEX[,c('id','data','chr','cn','Sample')]
CNVs_PicoPLEXx= CNVs_PicoPLEX[CNVs_PicoPLEX$Sample%in%c('sample1/10 FC', 'sample2/06 CC', "sample3/01 CC",'Fibr','NA12878'), 
                              c('id', 'Sample')]
CNVs_PicoPLEXxx = distinct(CNVs_PicoPLEXx)
PicoPLEX_qcpassingcells= data.frame(table(CNVs_PicoPLEXxx$Sample))
################ Pico cells having significant CNVs ################ ################ ################
PicoPLEX_s <- readRDS("./data/processed/rds/SignificantCNVs_PicoPLEX.rds")
PT= which(colnames(PicoPLEX_s)%in%c('datayy','cn_binsize','start_bin','end_bin','shared_count', 'shared_sample_names', 
                                    'shared_ind_number'))
PicoPLEX_s= PicoPLEX_s[,-PT]
PicoPLEX_s= PicoPLEX_s[!PicoPLEX_s$chr%in%'chrX',]
PicoPLEX_s= PicoPLEX_s[PicoPLEX_s$Sample%in%c('sample1/10 FC', 'sample2/06 CC', "sample3/01 CC",'Fibr','NA12878'), ]


Pico_sample2= PicoPLEX_s[PicoPLEX_s$Sample%in%'sample2/06 CC',] # how many significant CNVs were identified for Pico-sample2
# Number of amplifications: 

Pico_sample2_t=     cbind(Pico_allcells[Pico_allcells$Var1%in%'sample2/06 CC', 'Freq'], 
                      PicoPLEX_qcpassingcells[PicoPLEX_qcpassingcells$Var1%in%'sample2/06 CC', 'Freq'], 
                      length(unique(Pico_sample2$id)), 
                      nrow(Pico_sample2), 
                      nrow(Pico_sample2[Pico_sample2$cn<2,]), 
                      nrow(Pico_sample2[Pico_sample2$cn>2,]))
rownames(Pico_sample2_t)= 'PicoPLEX_sample2/06CC_MSA1'
###### ############
Pico_sample1= PicoPLEX_s[PicoPLEX_s$Sample%in%'sample1/10 FC',] # how many significant CNVs were identified for PTA-sample1
Pico_sample1_t=     cbind(Pico_allcells[Pico_allcells$Var1%in%'sample1/10 FC', 'Freq'], 
                      PicoPLEX_qcpassingcells[PicoPLEX_qcpassingcells$Var1%in%'sample1/10 FC', 'Freq'], 
                      length(unique(Pico_sample1$id)), 
                      nrow(Pico_sample1), 
                      nrow(Pico_sample1[Pico_sample1$cn<2,]), 
                      nrow(Pico_sample1[Pico_sample1$cn>2,]))
rownames(Pico_sample1_t)= 'PicoPLEX_sample1/10FC_Control'
###### ############
Pico_sample3= PicoPLEX_s[PicoPLEX_s$Sample%in%'sample3/01 CC',] # how many significant CNVs were identified for PTA-sample3
Pico_sample3_t=     cbind(Pico_allcells[Pico_allcells$Var1%in%'sample3/01 CC', 'Freq'], 
                      PicoPLEX_qcpassingcells[PicoPLEX_qcpassingcells$Var1%in%'sample3/01 CC', 'Freq'], 
                      length(unique(Pico_sample3$id)), 
                      nrow(Pico_sample3), 
                      nrow(Pico_sample3[Pico_sample3$cn<2,]), 
                      nrow(Pico_sample3[Pico_sample3$cn>2,]))
rownames(Pico_sample3_t)= 'PicoPLEX_sample3/01CC_MSA2'
###### ############
Pico_Fibr= PicoPLEX_s[PicoPLEX_s$Sample%in%'Fibr',] # how many significant CNVs were identified for PTA-sample1
Pico_Fibr_t=     cbind(Pico_allcells[Pico_allcells$Var1%in%'Fibr', 'Freq'], 
                       PicoPLEX_qcpassingcells[PicoPLEX_qcpassingcells$Var1%in%'Fibr', 'Freq'], 
                       length(unique(Pico_Fibr$id)), 
                       nrow(Pico_Fibr), 
                       nrow(Pico_Fibr[Pico_Fibr$cn<2,]), 
                       nrow(Pico_Fibr[Pico_Fibr$cn>2,]))
rownames(Pico_Fibr_t)= 'PicoPLEX_Fibr'
###################################
Pico_NA12878= PicoPLEX_s[PicoPLEX_s$Sample%in%'NA12878',] 
Pico_NA12878_t=           cbind(Pico_allcells[Pico_allcells$Var1%in%'NA12878', 'Freq'], 
                                PicoPLEX_qcpassingcells[PicoPLEX_qcpassingcells$Var1%in%'NA12878', 'Freq'], 
                                length(unique(Pico_NA12878$id)), 
                                nrow(Pico_NA12878), 
                                nrow(Pico_NA12878[Pico_NA12878$cn<2,]), 
                                nrow(Pico_NA12878[Pico_NA12878$cn>2,]))
rownames(Pico_NA12878_t)= 'PicoPLEX_NA12878'
###################################
dddd= rbind(PTA_sample2_t,  PTA_sample1_t, PTA_NA12878_t,
            Pico_sample2_t, Pico_sample1_t, Pico_sample3_t, Pico_Fibr_t)
eee= c('# of cells', '# of cells passing QC', '# of cells with at least one CNV', '# number of CNVs', '# of losses', 
       '# of gains')
colnames(dddd)=eee
saveRDS(dddd, file='./data/processed/rds/WriteTable_Detailed_Summary_SignificantCNVs.rds')
######################
key_df <- data.frame(Variable = c('CC',
                                  'FC',
                                  'Fibr',
                                  'MSA',
                                  'MSA-1',
                                  'MSA-2',
                                  '# of cells',
                                  "# of cells passing QC", 
                                  "# of cells with at least one CNV",
                                  "# number of CNVs",
                                  "# of losses",
                                  "# of gains"),
                     
                     Description = c('Cingulate Cortex',
                                     'Frontal Cortex',
                                     'Fibroblasts with a known 1.7 Mb CNV including SNCA (triplication) on Chr 4',
                                     'Multiple system atrophy',
                                     'MSA patient 1',
                                     'MSA patient 2',
                                     'the initial total number of cells',
                                     "the total number of cells that passing QC which is MAD<=0.3 and confidence score>=0.7", 
                                     "the total number of unique cells that have at least one CNV",
                                     "the total number of CNVs",
                                     "the total number of losses",
                                     "the total number of gains"))
wb <- createWorkbook()
addWorksheet(wb, "KEY")
writeData( wb,"KEY", key_df)

addWorksheet(wb, "Summary_SignificantCNVs")
writeData( wb,  rowNames = TRUE, "Summary_SignificantCNVs", dddd)

saveWorkbook(wb, "./results/Summary_SignificantCNVs_June292023_ZGT.xlsx", overwrite = TRUE)