#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)<2) {
  stop("At least two arguments must be supplied: segment_ratios.txt and rowranges.txt
       The third argument will be used to set the output directory and will be the current working directory if missing
       E.g. Rscript --vanilla write_cn_segments.R segment_ratios.txt rowranges.txt outdir", call.=FALSE)
} else if (length(args)==2) {
  # default output folder is the current working dir
  args[3] = getwd()
}

### read exported data for testing purposes
# segment_ratios_file <- "/path_to_segment_ratios"
# rowranges_file <- "/path_to_rowranges"
# outdir <- "/path_to_outdir"

segment_ratios_file <- "/path_to_segment_ratios"
rowranges_file <- "/path_to_rowranges"
outdir <- "/path_to_outdir"

library(S4Vectors)

segment_ratios <- read.delim(file = segment_ratios_file, as.is = T)
rowranges_data <- read.delim(file = rowranges_file, as.is = T)

rleseg <- apply(X = segment_ratios, MARGIN = 2, FUN = Rle)
rleseg[[1]]
outls <- lapply(X = rleseg, rowr_df = rowranges_data, FUN = function(x, rowr_df) data.frame(chr = rowr_df[start(x), "seqnames"], 
                                                         start = rowr_df[start(x), "start"],
                                                         end = rowr_df[end(x), "end"],
                                                         ratio = runValue(x)))

mapply(cndata = outls, cellnames = names(outls), MoreArgs = list(outdir = outdir), 
       FUN = function(cndata, cellnames, outdir) {
         write.table(x = cndata, file = paste0(outdir, "/", cellnames, ".tsv"), sep = "\t", quote = F, col.names = T, row.names = F)}
       )

