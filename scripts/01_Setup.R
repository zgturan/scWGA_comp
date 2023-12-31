suppressPackageStartupMessages(library(rrvgo))
suppressPackageStartupMessages(library(org.Hs.eg.db))
suppressPackageStartupMessages(library(mgsub))
suppressPackageStartupMessages(library(ggforce))
suppressPackageStartupMessages(library(ggpubr))
suppressPackageStartupMessages(library(ggridges))
suppressPackageStartupMessages(library(ggrepel))
suppressPackageStartupMessages(library(igraph))
suppressPackageStartupMessages(library(patchwork))
suppressPackageStartupMessages(library(readxl))
suppressPackageStartupMessages(library(unikn))     
suppressPackageStartupMessages(library(gridExtra))
suppressPackageStartupMessages(library(grid))
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(inline)) 
suppressPackageStartupMessages(library(kableExtra))
suppressPackageStartupMessages(library(GenomicRanges))
suppressPackageStartupMessages(library(biomaRt))
suppressPackageStartupMessages(library(RSQLite))
suppressPackageStartupMessages(library(wesanderson))
suppressPackageStartupMessages(library(ctc))
suppressPackageStartupMessages(library(gplots))  # Visual plotting of tables
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(nortest))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(devtools))
suppressPackageStartupMessages(library(bedr))
suppressPackageStartupMessages(library(rtracklayer))
suppressPackageStartupMessages(library(broom))
suppressPackageStartupMessages(library(reshape2))
suppressPackageStartupMessages(library(gridBase))
suppressPackageStartupMessages(library(formattable))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(openxlsx))
suppressPackageStartupMessages(library(MASS))
suppressPackageStartupMessages(library(ggfortify))
suppressPackageStartupMessages(library(pals))
suppressPackageStartupMessages(library(viridis)) 
suppressPackageStartupMessages(library(scales))
suppressPackageStartupMessages(library(tilingArray))
suppressPackageStartupMessages(library(effsize))
suppressPackageStartupMessages(library(nlme))
suppressPackageStartupMessages(library(broom.mixed))
suppressPackageStartupMessages(library(tidytext))
suppressPackageStartupMessages(library(qpcR))
suppressPackageStartupMessages(library(cluster))    # clustering algorithms
suppressPackageStartupMessages(library(UpSetR))
suppressPackageStartupMessages(library(RColorBrewer))
suppressPackageStartupMessages(library(ezfun))
suppressPackageStartupMessages(library(pheatmap))
suppressPackageStartupMessages(library(R.filesets))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(cowplot))
suppressPackageStartupMessages(library(colorspace))
suppressPackageStartupMessages(library(ggimage))    
suppressPackageStartupMessages(library(ggstatsplot)) 
suppressPackageStartupMessages(library(PMCMRplus))
suppressPackageStartupMessages(library(mixtools))

theme_set(theme_pubr(base_size = 12, legend = 'top'))

pntnorm <- (1/0.352777778)

ampmethod <- setNames(c("#0078bf" ,'#f08122', '#5c2161'), c('PTA','dMDA','PicoPLEX'))
diagnoses <- setNames(c('#4b4b45', '#a61f56'), c('Control', 'MSA'))
brain_reg <- setNames(c('#edae49','#66a182'), c('Cingulate Cortex', 'Frontal Cortex'))

standardize_name <- function(name) {
  return(gsub('[^0-9a-zA-Z]+', '_', name))}
