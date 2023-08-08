source('./scripts/01_Setup.R')

all2= readRDS("./data/processed/rds/SignificantCells.rds")
picocells_passing_mad_conf= all2$id
Pico_76 <- readRDS("./data/processed/rds/PTA_48_500kb_lift_SegFixed_cnv_stat_genome.rds")
Pico_76x= Pico_76[Pico_76$id%in%picocells_passing_mad_conf,]
Pico_76x= Pico_76x[!Pico_76x$chr%in%c('chrX','chrY'),]
results <- readRDS("./data/processed/rds/PTA_48_500kb_lift_diploidregions.rds")
resultsx= results[results$Count < 58,]
resultsx2= resultsx[resultsx$Count > 5,'Medians']
Pico_76x2= Pico_76x[Pico_76x$cn_binsize>5,'cn_median']
############
Pico_101 <- readRDS("./data/processed/rds/PTA_101_500kb_lift_SegFixed_cnv_stat_genome.rds")
Pico_101x= Pico_101[Pico_101$id%in%picocells_passing_mad_conf,]
Pico_101x= Pico_101x[!Pico_101x$chr%in%c('chrX','chrY'),]
resultsa <- readRDS("./data/processed/rds/PTA_101_500kb_lift_diploidregions.rds")
resultsa= resultsa[resultsa$Count < 58,]
resultsa2= resultsa[resultsa$Count > 5,'Medians']
Pico_101x2= Pico_101x[Pico_101x$cn_binsize>5,'cn_median']
long_data76= data.frame(c(resultsx2, Pico_76x2, resultsa2, Pico_101x2))
long_data76=reshape2::melt(long_data76)
long_data76[,1]= as.character(long_data76[,1])
long_data76[,1]= rep('disomic', rep(length(long_data76[,1])))
colnames(long_data76)=NULL
ordered_data_male_pico <- readRDS("./data/processed/rds/ordered_data_male_pta_wholechrX.rds")

ordered_data_male_pico[,1]= rep('mono', rep(length(ordered_data_male_pico[,1])))
colnames(ordered_data_male_pico)=NULL
aaa= data.frame(rbindlist(list(long_data76, ordered_data_male_pico)))
long_data76x= reshape2::melt(aaa)
long_data76x$V1=as.factor(long_data76x$V1)
lower_1_percentileq= 1.29
upper_1_percentileq=2.80

aahist= ggplot(long_data76x, aes(x = value, fill = V1)) +
        geom_histogram(bins = 100, alpha = 0.5) +
        labs(x = "Median copy number value of segments", y = "Frequency of segments", title = "PTA") +
        geom_vline(aes(xintercept = 1.29), color = "dark blue", linetype = "longdash", size = 0.5) +
        geom_vline(aes(xintercept = 2.80), color = "dark red", linetype = "longdash", size = 0.5) +
      scale_x_continuous(limits = c(0.9, 6),breaks =c(1,2,3,4,5,6)) +
  scale_y_continuous(limits = c(0, 40)) +
  scale_fill_manual(values=c("gray","dark blue"), guide="none") +
  geom_rug(aes(color = V1)) +
  scale_color_manual(values=c("gray","dark blue"), guide="none") +
  theme_pubr(base_size = 12) 
saveRDS(aahist, file = './results/article_figures/PTA_Segment_Median.rds')
ggsave(aahist, filename = './results/article_figures/PTA_Segment_Median.png', 
       unit = 'cm', width = 16, height = 12)
ggsave(aahist, filename = './results/article_figures/PTA_Segment_Median.pdf', 
       unit = 'cm', width = 16, height = 12)


aahist2= ggplot(long_data76x, aes(x = value, fill = V1)) +
  geom_histogram(bins = 100, alpha = 0.5) +
  labs(x = "Median copy number value of segments", y = "Frequency of segments",  title = "PTA") +
  geom_vline(aes(xintercept = 1.29), color = "dark blue", linetype = "longdash", size = 0.5) +
  geom_vline(aes(xintercept = 2.80), color = "dark red", linetype = "longdash", size = 0.5) +
  scale_fill_manual(values=c("gray", "dark blue"), guide="none") +
  geom_rug(aes(color = V1)) +
  scale_color_manual(values=c("gray","dark blue"), guide="none") +
  theme_pubr(base_size = 12) 
ggsave(aahist2, filename = './results/article_figures/PTA_Segment_Median_Range.png', 
       unit = 'cm', width = 16, height = 12)
ggsave(aahist2, filename = './results/article_figures/PTA_Segment_Median_Range.pdf', 
       unit = 'cm', width = 16, height = 12)