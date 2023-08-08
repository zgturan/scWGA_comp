source('./scripts/01_Setup.R')

SignificantCNVs <- readRDS("./data/processed/rds/WriteTable_SignificantCNVs.rds")

msa= SignificantCNVs[SignificantCNVs$Samples%in%c( "Control"),]
dim(msa)
# 6 15

########################################
ensembl = useEnsembl(biomart="ensembl", dataset="hsapiens_gene_ensembl")
genes_df <- getBM(attributes=c('ensembl_gene_id','hgnc_symbol','chromosome_name','start_position','end_position'), 
                  mart = ensembl)
regions_df=     msa[,c('chr','start','end')]
regions_df$chr= gsub('chr', '', regions_df$chr)

regions_gr <- makeGRangesFromDataFrame(regions_df, keep.extra.columns=TRUE, seqnames.field="chr", 
                                       start.field="start", end.field="end")
genes_gr <- makeGRangesFromDataFrame(genes_df, keep.extra.columns=TRUE, seqnames.field="chromosome_name", 
                                     start.field="start_position", end.field="end_position")
overlaps <- findOverlaps(regions_gr, genes_gr)
overlapping_regions_gr <- regions_gr[queryHits(overlaps)]
overlapping_genes_gr <- genes_gr[subjectHits(overlaps)]
within_idx <- findOverlaps(overlapping_genes_gr, overlapping_regions_gr, type = "within")
complete_genes_gr <- overlapping_genes_gr[queryHits(within_idx)]
complete_genes_df <- as.data.frame(complete_genes_gr)
complete_genes_df$ensembl_gene_id <- mcols(complete_genes_gr)$ensembl_gene_id
complete_genes_df$hgnc_symbol <- mcols(complete_genes_gr)$hgnc_symbol
qq= complete_genes_df[!duplicated(complete_genes_df),]
unique_ids = unique(complete_genes_df$ensembl_gene_id)
write.table(unique_ids, file = "./data/processed/txt/Control.txt", sep = "\t", quote=F,
            row.names = F, col.names = F)

