source('./scripts/01_Setup.R')

Pico <- readRDS("./results/article_figures/Pico_Segment_Median.rds")
PTA <- readRDS("./results/article_figures/PTA_Segment_Median.rds")
aahist2= ggarrange(Pico, PTA, labels = c('A','B'))

ggsave(aahist2, filename = './results/PTA_Pico_segmentvalue.png', 
       unit = 'cm', width = 20, height = 9)
ggsave(aahist2, filename = './results/PTA_Pico_segmentvalue.pdf', 
       unit = 'cm', width = 20, height = 9)

ggsave(aahist2, filename = './results/article_figures/PTA_Pico_segmentvalue.png', 
       unit = 'cm', width = 20, height = 9)
ggsave(aahist2, filename = './results/article_figures/PTA_Pico_segmentvalue.pdf', 
       unit = 'cm', width = 20, height = 9)

