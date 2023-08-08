source('./scripts/01_Setup.R')
top=8

L2_hg38 <-readRDS("./data/processed/Pico_101_250kb/L2_4min_Exp1.7A_sn2_Fibr_CellRaft_v3_S32.bt2.hg38.sorted.dup_marked.bam.rds")
L2_lift<- readRDS("./data/processed/Pico_101_250kb_lift/L2_4min_Exp1.7A_sn2_Fibr_CellRaft_v3_S32.bt2.hg38.sorted.dup_marked_mapped_T2T.sorted_ilmn.pe.lifted.final.sorted.dup_marked.bam.rds")
L2_t2t<-  readRDS("./data/processed/Pico_101_250kb_t2t/L2_4min_Exp1.7A_sn2_Fibr_CellRaft_v3_S32.bt2.hg38.sorted.dup_marked_mapped_T2T.sorted.sorted.dup_marked.rds")
L2_hg38$labels$title <- 'L2-hg38'
L2_lift$labels$title <- 'L2-hg38-lift'
L2_t2t$labels$title <- 'L2-T2T'
first= ggarrange(ggarrange(L2_hg38,   L2_lift ,  L2_t2t, nrow = 3, ncol =1))


L5_hg38 <-readRDS("./data/processed/Pico_101_250kb/L5_Exp1.7A_sn1_Fibr_CellRaft_v3_S34.bt2.hg38.sorted.dup_marked.bam.rds")
L5_lift<- readRDS("./data/processed/Pico_101_250kb_lift/L5_Exp1.7A_sn1_Fibr_CellRaft_v3_S34.bt2.hg38.sorted.dup_marked_mapped_T2T.sorted_ilmn.pe.lifted.final.sorted.dup_marked.bam.rds")
L5_t2t<-  readRDS("./data/processed/Pico_101_250kb_t2t/L5_Exp1.7A_sn1_Fibr_CellRaft_v3_S34.bt2.hg38.sorted.dup_marked_mapped_T2T.sorted.sorted.dup_marked.rds")
L5_hg38$labels$title <- 'L5-hg38'
L5_lift$labels$title <- 'L5-hg38-lift'
L5_t2t$labels$title <- 'L5-T2T'
second= ggarrange(ggarrange(L5_hg38,   L5_lift ,  L5_t2t, nrow = 3, ncol =1))

L4_hg38 <-readRDS("./data/processed/Pico_101_250kb/L4_Exp1.7A_sn5_Fibr_CellRaft_v3_S33.bt2.hg38.sorted.dup_marked.bam.rds")
L4_lift<- readRDS("./data/processed/Pico_101_250kb_lift/L4_Exp1.7A_sn5_Fibr_CellRaft_v3_S33.bt2.hg38.sorted.dup_marked_mapped_T2T.sorted_ilmn.pe.lifted.final.sorted.dup_marked.bam.rds")
L4_t2t<-  readRDS("./data/processed/Pico_101_250kb_t2t/L4_Exp1.7A_sn5_Fibr_CellRaft_v3_S33.bt2.hg38.sorted.dup_marked_mapped_T2T.sorted.sorted.dup_marked.rds")
L4_hg38$labels$title <- 'L4-hg38'
L4_lift$labels$title <- 'L4-hg38-lift'
L4_t2t$labels$title <- 'L4-T2T'
third= ggarrange(ggarrange(L4_hg38,   L4_lift ,  L4_t2t, nrow = 3, ncol =1))

fourth= ggarrange(first,   second ,  third, nrow = 1, ncol =3,font.label = list(size = 56))

ggsave(fourth, filename = "./results/Fibr_jul13_2023.pdf",
       unit="cm", width = 330, height = 75, useDingbats = F, limitsize = FALSE)

ggsave(fourth, filename = "./results/Fibr_jul13_2023.png",
       unit="cm", width = 330, height = 75,limitsize = FALSE)

ggsave("./results/Fibr_jul13_2023.tiff", fourth, width = 140, height=30, dpi=150, units = "in", limitsize = FALSE)
