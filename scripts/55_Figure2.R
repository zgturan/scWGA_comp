source('./scripts/01_Setup.R')


top=8
L11 <- readRDS("./data/processed/Pico_101_500kb/L11_Exp1.8.1B_sn3_10_FC_CellRaft_v3_S38.bt2.hg38.sorted.dup_marked.bam.rds") 
L11$labels$title <- 'Control'
L11$labels$x <- NULL

A29 <- readRDS("./data/processed/Pico_76_500kb/A29_v2_Exp9.1_sn10_06_CC_S29_R.bowtie.hg38.sorted_dup_marked.bam.rds") 
A29$labels$title <- 'MSA-1'
A29$labels$x <- NULL
# A29 + theme(plot.margin = margin(10, 0.1, 0.1, 0.1, "cm"))


A1 <- readRDS("./data/processed/PTA_101_500kb/A1_PTA_Exp8.2_sn18_10_FC_S1_R.bowtie.hg38.sorted_dup_marked.bam.rds") 
A1$labels$title <- NULL
A1$labels$x <- NULL

A4 <- readRDS("./data/processed/PTA_101_500kb/A4_PTA_Exp9.2_sn_2_06_CC_S4_R.bowtie.hg38.sorted_dup_marked.bam.rds") 
A4$labels$title <- NULL
A4$labels$x <- NULL

A62 <-   readRDS("./data/processed/dMDA_101_500kb/A62_Exp8_3_sn1_P67_10_dMDA_S16_R.bowtie.hg38.sorted.bam.dup_marked.rds") 
A62$labels$title <- NULL

A36 <- readRDS("./data/processed/dMDA_101_500kb/A36_dMDA_Exp6.2_sn7_06_CC_S35_R.bowtie.hg38.sorted_dup_marked.rds") 
A36$labels$title <- NULL

GC_500kb_brain <- readRDS("./data/processed/rds/GC_500kb_brain.rds")
Lorenz_curve_500kb_brain <- readRDS("./data/processed/rds/Lorenz_curve_500kb_brain.rds")

first= ggarrange(L11, A29, A1, A4, A62, A36, Lorenz_curve_500kb_brain, GC_500kb_brain,
                  nrow = 4, ncol = 2, heights = c(1, 1, 1, 1.5),
                 widths = c(1, 1, 1, 1),font.label = list(size = 56))

ggsave(first, filename = "./results/Figure2_jul13_2023.pdf",
       unit="cm", width = 180, height = 90, useDingbats = F, limitsize = FALSE)

ggsave(first, filename = "./results/Figure2_jul13_2023.png",
       unit="cm", width = 180, height = 90, limitsize = FALSE)