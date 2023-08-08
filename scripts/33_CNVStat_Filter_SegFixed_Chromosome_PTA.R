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
long_data76x=long_data76$value
long_data76x= reshape2::melt(long_data76x)

data= long_data76x$value

set.seed(1) 
mixture_model <- normalmixEM(data, k = 3)
library(mixtools)

component_near_2 <- which.min(abs(mixture_model$mu - 2))
lower_1_percentile <- qnorm(0.01, mixture_model$mu[component_near_2], mixture_model$sigma[component_near_2])
lower_1_percentile
# 0.9654979
upper_1_percentile <- qnorm(0.99, mixture_model$mu[component_near_2], mixture_model$sigma[component_near_2])
upper_1_percentile
# 3.529676
lower_5_percentile <- qnorm(0.05, mixture_model$mu[component_near_2], mixture_model$sigma[component_near_2])
lower_5_percentile
# 1.341081
upper_5_percentile <- qnorm(0.95, mixture_model$mu[component_near_2], mixture_model$sigma[component_near_2])
upper_5_percentile
# 3.154093

lower_1_percentileq=  1.29
upper_1_percentileq= 2.80
aahist=  ggplot(long_data76x, aes(x = value)) +
         geom_histogram(fill = "gray", bins= 100) +
         labs(x = "Median copy number value of segments", y = "Frequency of segments", 
         title = "PTA") +
         geom_vline(aes(xintercept = lower_1_percentileq), color = "dark red", linetype = "longdash", size =  0.5) +
         geom_vline(aes(xintercept = upper_1_percentileq), color = "dark red", linetype = "longdash", size =  0.5) +
         geom_text(aes(x = lower_1_percentileq, y = 13,  label = round(lower_1_percentileq, 2)), color = "dark red", size = 3.5) +
         geom_text(aes(x = upper_1_percentileq, y = 13,  label = sprintf("%.2f", upper_1_percentileq)), color = "dark red", size = 3.5) +
         scale_x_continuous(limits = c(0, 4)) +
         theme_pubr(base_size = 12) 

ggsave(aahist, filename = './results/PTA_48_101_500kb_liftalldisomicsegmentshigher5bins_smallerautos.png', 
       unit = 'cm', width = 16, height = 12)
ggsave(aahist, filename = './results/PTA_48_101_500kb_liftalldisomicsegmentshigher5bins_smallerautos.pdf', 
       unit = 'cm', width = 16, height = 12)

saveRDS(aahist, file = './data/processed/rds/PTA_48_101_500kb_liftalldisomicsegmentshigher5bins_smallerautos.rds' )
