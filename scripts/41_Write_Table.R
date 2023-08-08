source('./scripts/01_Setup.R')

SampleInfo2= readRDS('./data/processed/rds/SampleInfo.rds')
SampleInfo2$Amplification.Method= gsub("PicoPlex v2|PicoPlex v3", 'PicoPlex', SampleInfo2$Amplification.Method)
delimiters = ".bowtie|.bt2"
aa2=         strsplit(SampleInfo2$File_name, delimiters, perl = TRUE)
aa3=         sapply(aa2, function(x) x[1])
aa3=         standardize_name(aa3)
SampleInfo2$File_name= aa3

SampleInfo2_PTA= SampleInfo2[SampleInfo2$Amplification.Method%in%'PTA',]
SampleInfo2_PTA= SampleInfo2_PTA[SampleInfo2_PTA$'Sample'%in%c('sample3/10 FC', 'sample4/06 CC',"sample2/01 CC", 'Fibr','NA12878'),]
PTA_allcells= data.frame(table(SampleInfo2_PTA$Sample))
SampleInfo2_Pico= SampleInfo2[SampleInfo2$Amplification.Method%in%'PicoPlex',]
SampleInfo2_Pico= SampleInfo2_Pico[SampleInfo2_Pico$'Sample'%in%c('sample3/10 FC', 'sample4/06 CC',"sample2/01 CC",'Fibr'),]
Pico_allcells= data.frame(table(SampleInfo2_Pico$Sample))
oo=   merge(PTA_allcells,by.x='Var1', Pico_allcells,by.y='Var1', all='T')
############################
PTA <- readRDS("./data/processed/rds/SignificantCNVs_PTA.rds")
PT= which(colnames(PTA)%in%c('datayy','cn_binsize','start_bin','end_bin','shared_count', 'shared_sample_names', 'shared_ind_number'))
PTA= PTA[,-PT]
uu= PTA[!PTA$chr%in%'chrX',]

qq= uu[!uu$cn%in%c(0, 1),] 
PicoPLEX <- readRDS("./data/processed/rds/SignificantCNVs_PicoPLEX.rds")
PP= which(colnames(PicoPLEX)%in%c('datayy','cn_binsize','start_bin','end_bin','shared_count', 'shared_sample_names', 'shared_ind_number'))
PicoPLEX= PicoPLEX[,-PP]
yy= PicoPLEX[!PicoPLEX$chr%in%'chrX',]

signi= data.frame(rbindlist(list(PTA, PicoPLEX)))
signi= signi[,c("Run" ,"Library", "Isolation.Method", "data", 'Sample', 'id', "version",'chr', 'cn', "cn_median", 'start','end', 'width')]
ordered_data=signi
qq= strsplit(ordered_data$Sample, ' ')
ordered_data$Brain_Region= sapply(qq, function(x) x[2])
ordered_data$Brain_Region= gsub('CC', 'Cingulate Cortex', ordered_data$Brain_Region)
ordered_data$Brain_Region= gsub('FC', 'Frontal Cortex',   ordered_data$Brain_Region)
ordered_data[is.na(ordered_data)] <- "NA"

ordered_data$Diagnosis= sapply(qq, function(x) x[1])
ordered_data$Diagnosis= gsub('sample3/10', 'Control', ordered_data$Diagnosis)
ordered_data$Diagnosis= gsub('sample4/06', 'MSA-1',   ordered_data$Diagnosis)
ordered_data$Diagnosis= gsub('sample2/01', 'MSA-2',   ordered_data$Diagnosis) 

# ordered_data= ordered_data[ordered_data$data%in%'PicoPLEX',]
ordered_data$chr <-    factor(ordered_data$chr, levels = c(paste0("chr", 1:22), 'chrX'))
ordered_data <- ordered_data[order(ordered_data$Sample, ordered_data$chr, ordered_data$start, ordered_data$end),]
colnames(ordered_data)[colnames(ordered_data)=='Sample'] ='Individual'
ordered_data= ordered_data[,c("Run" ,"Library", "Isolation.Method", "data", "version", 'Individual', "Diagnosis", "Brain_Region" ,
                              'id','chr', 'cn', "cn_median", 'start','end', 'width')]
ordered_data= ordered_data[!ordered_data$chr%in%'chrX',]
colnames(ordered_data)[which(colnames(ordered_data) %in% "Diagnosis")] = 'Samples'
ss= ordered_data[,c('data', 'id')]
ss2= ss[!duplicated(ss),]
################
ordered_dataq= ordered_data
ordered_dataq=ordered_dataq[!ordered_dataq$chr %in%'chrX',]
qqqq=data.frame(table(ordered_dataq[,'Samples']))
#################################################
CNVs_PicoPLEX <- readRDS("./data/processed/rds/CNVs_PicoPLEX.rds")
CNVs_PicoPLEX= CNVs_PicoPLEX[,c('id','data','chr','cn','Sample')]
CNVs_PTA <- readRDS("./data/processed/rds/CNVs_PTA.rds")
CNVs_PTA= CNVs_PTA[,c('id','data','chr','cn','Sample')]
aa= data.frame(rbindlist(list(CNVs_PicoPLEX, CNVs_PTA)))
sample4_all=    aa[aa$Sample%in%'sample4/06 CC',]
sample4=     ordered_dataq[ordered_dataq$Individual%in%"sample4/06 CC",]
sample4_au=  sample4[!sample4$chr%in%'chrX',]
sample4_oo2 = as.numeric(oo[oo$Var1%in%'sample4/06 CC', 2:3])
sample4_oo3 = sum(sample4_oo2[!is.na(sample4_oo2)])
sample4tt=     cbind(sample4_oo3, length(unique(sample4_all$id)), length(unique(sample4_au$id)), nrow(sample4_au), nrow(sample4_au[sample4_au$cn<2,]), nrow(sample4_au[sample4_au$cn>2,]))
rownames(sample4tt)= 'MSA-1'
#### #### #### #### #### #### #### #### #### ####
sample2_all=    aa[aa$Sample%in%'sample2/01 CC',]
sample2=     ordered_dataq[ordered_dataq$Individual%in%"sample2/01 CC",]
sample2_au=  sample2[!sample2$chr%in%'chrX',]
sample2_oo2 = as.numeric(oo[oo$Var1%in%'sample2/01 CC', 2:3])
sample2_oo3 = sum(sample2_oo2[!is.na(sample2_oo2)])
sample2_tt= cbind(sample2_oo3, length(unique(sample2_all$id)), length(unique(sample2_au$id)), nrow(sample2_au), nrow(sample2_au[sample2_au$cn<2,]), nrow(sample2_au[sample2_au$cn>2,]))
rownames(sample2_tt)='MSA-2'
#####################################
sample3_all=    aa[aa$Sample%in%'sample3/10 FC',]
sample3=     ordered_dataq[ordered_dataq$Individual%in%"sample3/10 FC",]
sample3_au=  sample3[!sample3$chr%in%'chrX',]
sample3_oo2 = as.numeric(oo[oo$Var1%in%'sample3/10 FC', 2:3])
sample3_oo3 = sum(sample3_oo2[!is.na(sample3_oo2)])
sample3tt= cbind(sample3_oo3, length(unique(sample3_all$id)), length(unique(sample3_au$id)), nrow(sample3_au), nrow(sample3_au[sample3_au$cn<2,]), nrow(sample3_au[sample3_au$cn>2,]))
rownames(sample3tt)='Control'
##############################################################
NA12878_all=    aa[aa$Sample%in%'NA12878',]
NA12878=     ordered_dataq[ordered_dataq$Samples%in%"NA12878",]
NA12878_au=  NA12878[!NA12878$chr%in%'chrX',]
NA12878_oo2 = as.numeric(oo[oo$Var1%in%'NA12878', 2:3])
NA12878_oo3 = sum(NA12878_oo2[!is.na(NA12878_oo2)])
NA12878_tt= cbind(NA12878_oo3, length(unique(NA12878_all$id)), length(unique(NA12878_au$id)), nrow(NA12878_au), nrow(NA12878_au[NA12878_au$cn<2,]), nrow(NA12878_au[NA12878_au$cn>2,]))
rownames(NA12878_tt)='NA12878'
#####################################
Fibr_all=    aa[aa$Sample%in%'Fibr',]
Fibr=     ordered_dataq[ordered_dataq$Samples%in%"Fibr",]
Fibr_au=  Fibr[!Fibr$chr%in%'chrX',]
Fibr_oo2 = as.numeric(oo[oo$Var1%in%'Fibr', 2:3])
Fibr_oo3 = sum(Fibr_oo2[!is.na(Fibr_oo2)])
Fibr_tt= cbind(Fibr_oo3, length(unique(Fibr_all$id)), length(unique(Fibr_au$id)), nrow(Fibr_au), nrow(Fibr_au[Fibr_au$cn<2,]), nrow(Fibr_au[Fibr_au$cn>2,]))
rownames(Fibr_tt)='Fibr'

###############################
dddd= rbind(sample4tt, sample2_tt, sample3tt, NA12878_tt, Fibr_tt)
eee= c('total # of cells', '# of cells passing QC','# of unique cells with at least one CNV','# of CNVs', '# of losses', '# of gains')
ordered_data$chr= as.character(ordered_data$chr)
ordered_data= ordered_data[!(ordered_data$chr=='chrX' & ordered_data$cn > 2),]
colnames(dddd)=eee
saveRDS(ordered_data, file= "./data/processed/rds/WriteTable_SignificantCNVs.rds")
saveRDS(dddd,         file= "./data/processed/rds/WriteTable_SummaryofSignificantCNV.rds")
############################
wb <- createWorkbook()
addWorksheet(wb, "SignificatCNVs")
writeData(wb,    "SignificatCNVs", ordered_data)
saveWorkbook(wb, "./results/SignificantCNVs_Jul132023_ZGT.xlsx", overwrite = TRUE)