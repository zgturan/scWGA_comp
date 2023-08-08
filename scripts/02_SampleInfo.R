# by: Zeliha Gozde Turan
# date: Feb 25, 2023

source('./scripts/01_Setup.R')
sample_infA= data.frame(read_xlsx('./data/processed/txt/Christos_Brain_dataset_manifest.xlsx', sheet = 1))
write.table(sample_infA, file = "./data/processed/txt/SampleInfo.tsv", row.names=FALSE, sep="\t")
saveRDS(sample_infA, file = "./data/processed/rds/SampleInfo.rds")
