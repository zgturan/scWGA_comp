#set threads
library(BiocParallel)
register(MulticoreParam(progressbar = T, workers = 8), default = T)
BiocParallel::bpparam()

# Load library
library(copykit)

# Run pre-processing module.
#Bin size (resolution) can be “50kb,” “110kb,” “195kb,” “220kb,” “280kb,” “500kb,” “1Mb,” “2.8Mb”
name_data <- runVarbin("/path_to_dup_marked_bam_files",
                       alpha = 1e-2,
                       merge_levels_alpha = 1e-05,
                       remove_Y = TRUE,
                       is_paired_end = TRUE,
                       resolution = "220" )


# Mark euploid cells if they exist
name_data <- findAneuploidCells(name_data)

# Mark low-quality cells for filtering
name_data <- findOutliers(name_data)

#set ploidy
name_data <- calcInteger(name_data, method = 'fixed', ploidy_value = 2)

#segmentation ratio plot, CNV profiles
plotRatio(name_data)




#Make segment and rowrange files:
#1. use segment_ratio from data set generted by copykit pipeline. Load file to see that it's generated:
name_data@assays@data@listData[["segment_ratios"]]

#2. obtain genomic segements by the function "rowrange"
rowrange <- rowRanges(name_data)

#3. obtain csv files
write.table(name_data@assays@data@listData[["segment_ratios"]], file = "segment_ratios.csv",
  sep = "\t", row.names = F) 

write.table(rowrange, file = "rowrange.csv",
            sep = "\t", row.names = F) 

#make CNV file
#4. run write_cn_segments.R script in terminal (not console/not r script)
##script --vanilla write_cn_segments.R segment_ratios.txt rowranges.txt outdir







