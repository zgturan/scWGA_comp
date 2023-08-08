source('./scripts/01_Setup.R')

all2= readRDS("./data/processed/rds/SignificantCells.rds")
All_cnv_stat2_genome <- readRDS("./data/processed/rds/All_cnv_stat2_genome.rds")
All_cnv_stat2_genome=All_cnv_stat2_genome[All_cnv_stat2_genome$id%in%unique(all2$id),]
merged_read = merge(all2, All_cnv_stat2_genome, by = c("id", "chr", "start","end", "cnv"), all = TRUE)
merged_read= merged_read[(merged_read$version%in%'LiftOver - T2T to hg38') & (merged_read$data.x%in%'PicoPLEX') , ]
################# ################# ################# ################# ################# #################
delimx= ".bowtie|.bt2"
res1= strsplit(merged_read$id, delimx, perl = T)
merged_read[,ncol(merged_read)+1]=  sapply(res1, function(x) x[1])
colnames(merged_read)[ncol(merged_read)]='generic_name'
merged_readx= merged_read

SampleInfo2= readRDS('./data/processed/rds/SampleInfo.rds')
samp1= strsplit(SampleInfo2$File_name, delimx, perl = T)
samp2= sapply(samp1, function(x)x[1])
SampleInfo2[,ncol(SampleInfo2)+1]=  samp2
colnames(SampleInfo2)[ncol(SampleInfo2)]='generic_name_standardized'

SampleInfo2x= SampleInfo2[,-which(colnames(SampleInfo2)%in%c('Description' ,'Urgent'))]
SampleInfo2x$Amplification.Method= gsub("PicoPlex v3|PicoPlex v2", "PicoPLEX", SampleInfo2x$Amplification.Method)
colnames(SampleInfo2x)[which(colnames(SampleInfo2x)%in%'Amplification.Method')]='data'

standardize_name <- function(name) {
  return(gsub('[^0-9a-zA-Z]+', '_', name))}

merged_readx$generic_name_standardized = sapply(merged_readx$generic_name, standardize_name)
SampleInfo2x$generic_name_standardized = sapply(SampleInfo2x$generic_name, standardize_name)
colnames(merged_readx)[which(colnames(merged_readx)=='data.y')]='datayy'
colnames(merged_readx)[which(colnames(merged_readx)=='data.x')]='data'
result4= merge(merged_readx, SampleInfo2x, by.x= 'generic_name_standardized', by.y= 'generic_name_standardized', 
               all = TRUE)
result4= result4[complete.cases(result4$id),]
colnames(result4)[which(colnames(result4)=='data.x')]='data'
################# ################# ################# ################# ################# #################
result4a= result4[(result4$version%in%'LiftOver - T2T to hg38') & (result4$data%in%'PicoPLEX') , ]

all_loss= result4[result4$cnv%in%c(0,1),]
all_gains= result4[!result4$cnv%in%c(0,1),]

within_two_bin_sizes = function(cnv1_start_bin, cnv1_end_bin, cnv2_start_bin, cnv2_end_bin) {
                          start_diff = abs(cnv1_start_bin - cnv2_start_bin)
                          end_diff   = abs(cnv1_end_bin - cnv2_end_bin)
                          return((start_diff) <= 2500000 & (end_diff) <= 2500000)}
process_dataframe <- function(df) {
  df$shared_cell_number = 0
  df$shared_id = NA
  df$shared_sample_names = NA 
  df$shared_id_names = NA 
  shared_id_counter = 1
  
  for (i in 1:nrow(df)) {
    count = 0
    shared_cells_list = c()
    shared_sample_names = c() 
    shared_id_names = c() 
    for (j in 1:nrow(df)) {
      if (df$chr[i] == df$chr[j] &&
          within_two_bin_sizes(df$start[i], df$end[i], df$start[j], df$end[j])) {
        count = count + 1
        shared_cells_list = c(shared_cells_list, j)
        shared_sample_names = c(shared_sample_names, df$Sample[j])
        shared_id_names = c(shared_id_names, df$id[j]) 
      }
    }
    if (count > 1 && is.na(df$shared_id[i])) {
      df$shared_id[shared_cells_list] = shared_id_counter
      shared_id_counter = shared_id_counter + 1
    }
    if (length(unique(shared_sample_names)) > 1) { 
      df$shared_sample_names[i] = paste(unique(shared_sample_names), collapse = ",") 
    }
    if (!is.null(shared_id_names) && length(unique(shared_id_names)) > 1) {
      df$shared_id_names[i] = paste(unique(shared_id_names), collapse = ",")
    }
    df$shared_cell_number[i] = count
  }
  return(df)
}
result1 = process_dataframe(all_loss)
result2 = process_dataframe(all_gains)
result3= data.frame(rbindlist(list(result1, result2)))
result3= result3[,-which(colnames(result3)%in%'shared_id_names')]
for (i in 1:nrow(result3)) {
  if (is.na(result3[i, 'shared_sample_names'])) {
    result3[i, 'shared_sample_names'] = result3[i, 'Sample']
  }
}

result4x= result3[result3$data%in%'PicoPLEX',]
result4x$chr <- factor(result4x$chr, levels = c(paste0("chr", 1:22), 'chrX'))
ordered_data <- result4x[order(result4x$id, result4x$chr, result4x$start, result4x$end),]
colnames(ordered_data)[which(colnames(ordered_data)=='cnv')]='cn'

ordered_data_male= ordered_data[ordered_data$chr%in%'chrX',]
ordered_data_male= ordered_data_male[ordered_data_male$cn%in%1,]
ordered_data_malex= ordered_data_male[,c('generic_name_standardized','chr','start','end', 'cn','cn_median')]
mean_cn_median = aggregate(cn_median ~ generic_name_standardized, data = ordered_data_malex, FUN = mean)

ordered_data_fibr= ordered_data[ordered_data$Sample%in%'Fibr'  &  ordered_data$chr%in%'chr4' &  
                                  ordered_data$start%in%88454582 &  ordered_data$end%in%90255973 ,]
ordered_data_fibrx= ordered_data_fibr[,c('generic_name_standardized','chr','start','end', 'cn','cn_median')]
mean_cn_median_fibr = aggregate(cn_median ~ generic_name_standardized, data = ordered_data_fibrx, FUN = mean)
saveRDS(mean_cn_median_fibr, file= './data/processed/rds/ordered_data_fibr_pico.rds')
###########################
ordered_datax= ordered_data
qq= strsplit(ordered_datax$shared_sample_names, ',', perl = T)
ordered_datax$shared_ind_number= sapply(qq, function(x) length(x))
saveRDS(ordered_datax, file = './data/processed/rds/CNVs_PicoPLEX_forcommonality.rds')

ordered_datax= ordered_datax[ordered_datax$cn_binsize>5,]
ordered_datax$cn_median = round(ordered_datax$cn_median, 2)
saveRDS(ordered_datax, file = './data/processed/rds/CNVs_PicoPLEX.rds')

lower_1_percentileq = 1.29
upper_1_percentileq = 2.80
delx= ordered_datax$shared_ind_number<2 & ordered_datax$cn <  2  & ordered_datax$cn_median <= lower_1_percentileq
dupx= ordered_datax$shared_ind_number<2 & ordered_datax$cn >= 3 & ordered_datax$cn_median  >= upper_1_percentileq

ordered_datax_s= ordered_datax[delx | dupx ,]
ordered_datax_s= ordered_datax_s[,-which(colnames(ordered_datax_s)%in%c('generic_name_standardized', 
                                                                        'data.y','shared_id', 
                                                   'generic_name' , "Bp", "File_name"))]
saveRDS(ordered_datax_s, file = './data/processed/rds/SignificantCNVs_PicoPLEX.rds')

ordered_datax1= ordered_datax[,-which(colnames(ordered_datax)%in%c('generic_name_standardized', 'data.y',
                                                                   'shared_id', 
                                                                  'generic_name' ,  'Run',"Bp",
                                                                   "Library", "Isolation.Method" , 
                                                                  "File_name"))]
ordered_datax2= ordered_datax1[,c("shared_sample_names", "shared_ind_number", "shared_cell_number",
                                  "Sample",'id', "chr", "cn","cn_median",        
                                "start", "end", "width", "start_bin","end_bin", 
                                "cn_binsize")]

highlight_rows <- function(data) {
  lower_1_percentileq = 1.29
  upper_1_percentileq = 2.80
  return(ifelse((data$shared_ind_number<2 & data$cn < 2  & data$cn_median <= lower_1_percentileq), 'light blue',
         ifelse((data$shared_ind_number<2 & data$cn >= 3 & data$cn_median >= upper_1_percentileq), 'pink', NA)))
}

cell_names= unique(ordered_datax2$id)
for (i in cell_names) {
  print(i)
  xx = ordered_datax2[ordered_datax2$id == i, ]
  highlight_index = highlight_rows(xx)
  highlight_index2 =ggtexttable(xx,rows = NULL,
                                  theme = ttheme(base_size = 24, "minimal",
                                  colnames.style = colnames_style(size =24, fill = "white"),
                                  rownames_style(linewidth = 1.5),
                                  tbody.style = tbody_style(size =24,       fill = highlight_index)))
  saveRDS(highlight_index2, file= file.path('./data/processed/rds2',paste0(i, "_stat.rds")))
}
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
colnames(ordered_datax)
ordered_dataxn= ordered_datax[,-which(colnames(ordered_datax)%in%c('generic_name_standardized', 'data.y','shared_id', 
                                                                   'generic_name', "Bp",'version','datayy',"cn_mean",
                                                                   "File_name","shared_sample_names",  
                                                                   "shared_cell_number",
                                                                   'cn_binsize', 'start_bin', 'end_bin','generic_name'))]
colnames(ordered_dataxn)[which(colnames(ordered_dataxn)%in%'Sample')]='Individual'
signi= ordered_dataxn
qq= strsplit(signi$Individual, ' ')
signi$Brain_Region= sapply(qq, function(x) x[2])
signi$Brain_Region= gsub('CC', 'Cingulate Cortex', signi$Brain_Region)
signi$Brain_Region= gsub('FC', 'Frontal Cortex',   signi$Brain_Region)
signi[is.na(signi)] <- "NA"

signi$Samples= sapply(qq, function(x) x[1])
signix= signi[,  c("shared_ind_number", "Run","Library", "Isolation.Method",
                   "data", "Individual",'Brain_Region','Samples',"chr",   
                   "cn","cn_median", "start", "end", "width",'id')]
for (i in cell_names) {
  print(i)
  xx = signix[signix$id == i,]
  xx2= xx
  highlight_index = highlight_rows(xx2)
  highlight_index2 =ggtexttable(xx2, rows = NULL,
                                theme = ttheme(base_size = 24,"minimal",
                                               colnames.style = colnames_style(size= 24, fill = "white"),
                                               rownames_style(linewidth = 1.5),
                                               tbody.style = tbody_style(size = 24, fill = highlight_index)))
  saveRDS(highlight_index2, file= file.path('./data/processed/rds2',paste0(i, "_stat_presentation.rds")))
}
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
ordered_dataxn= ordered_datax[,-which(colnames(ordered_datax)%in%c('data.y','shared_id', 
                                                                   'generic_name', "Bp",'version','datayy',
                                                                   "cn_mean",
                                                                   "File_name","shared_sample_names",  
                                                                   "shared_cell_number",
                                                                   'cn_binsize', 'start_bin', 'end_bin',
                                                                   'generic_name',
                                                                   'Run','Isolation.Method','data'))]
colnames(ordered_dataxn)[which(colnames(ordered_dataxn)%in%'Sample')]='Individual'
signi= ordered_dataxn
qq= strsplit(signi$Individual, ' ')
signi$Brain_Region= sapply(qq, function(x) x[2])
signi$Brain_Region= gsub('CC', 'Cingulate Cortex', signi$Brain_Region)
signi$Brain_Region= gsub('FC', 'Frontal Cortex',   signi$Brain_Region)
signi[is.na(signi)] <- "NA"

signi$Samples= sapply(qq, function(x) x[1])
signix2= signi[,-which(colnames(signi)%in%c('Individual', 'Brain_Region'))]


signix3= signix2[,  c('Samples', "shared_ind_number", "generic_name_standardized","chr",   
                      "cn", "cn_median", "start", "end", "width",'id')]
res1= strsplit(signix3$id, delimx, perl = T)
signix3[,ncol(signix3)+1]=  sapply(res1, function(x) x[1])
head(signix3)
colnames(signix3)[ncol(signix3)]='ID'
signix3= signix3[,-which(colnames(signix3)%in%c('generic_name_standardized'))]

colnames(signix3) = c("samples","shared_ind_number", "chr", "cn", "cn_median", "start", 
                      "end", "width", "id","ID")

signix3= signix3[,  c('samples', "ID", "shared_ind_number","chr",   
                      "cn", "cn_median", "start", "end", "width",'id')]
signix3$chr= as.character(signix3$chr)
signix3= signix3[!(signix3$chr=='chrX' & signix3$cn > 2),]
signix3= signix3[!(signix3$chr=='chrY'),]

for (i in cell_names) {
  print(i)
  xx = signix3[signix3$id == i,]
  xx2= xx[,-which(colnames(xx)%in%c('id'))]
  xx3 <- xx2 %>%
    mutate(samples =  replace(samples, which(duplicated(samples)), ""))
  
  xx4 <- xx3 %>%
    mutate(ID =      replace(ID, which(duplicated(ID)), ""))
  highlight_index = highlight_rows(xx4)
  highlight_index2 =ggtexttable(xx4, rows = NULL,
                                theme = ttheme(base_size = 25,"minimal",
                                               colnames.style = colnames_style(size= 25, fill = "white"),
                                               rownames_style(linewidth = 1.5),
                                               tbody.style = tbody_style(size = 25, fill = highlight_index)))
  saveRDS(highlight_index2, file= file.path('./data/processed/rds3',paste0(i, "_paper.rds")))
}