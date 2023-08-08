source('./scripts/01_Setup.R')

# A treemap R script produced by the Revigo server at http://revigo.irb.hr/
# If you found Revigo useful in your work, please cite the following reference:
# Supek F et al. "REVIGO summarizes and visualizes long lists of Gene Ontology
# terms" PLoS ONE 2011. doi:10.1371/journal.pone.0021800

# author: Anton Kratz <anton.kratz@gmail.com>, RIKEN Omics Science Center, Functional Genomics Technology Team, Japan
# created: Fri, Nov 02, 2012  7:25:52 PM
# last change: Fri, Nov 09, 2012  3:20:01 PM

# -----------------------------------------------------------------------------
# If you don't have the treemap package installed, uncomment the following line:
# install.packages( "treemap" );
library(treemap) 								# treemap package by Martijn Tennekes

# Set the working directory if necessary
# setwd("C:/Users/username/workingdir");

# --------------------------------------------------------------------------
# Here is your data from Revigo. Scroll down for plot configuration options.
revigo.names <- c("term_ID","description","frequency","value","uniqueness","dispensability","representative");
revigo.data <- rbind(c("GO:0005575","cellular_component",100,2.129596094720973,1,-0,"cellular_component"),
                     c("GO:0005604","basement membrane",0.05149037249602265,1.465973893943865,0.9347713870675476,3.02E-05,"basement membrane"),
                     c("GO:0005886","plasma membrane",14.184672303876209,1.5559552040819238,0.9167355744322584,0.38923127,"basement membrane"),
                     c("GO:0045211","postsynaptic membrane",0.2039052260329109,1.4365189146055892,0.9283782234465566,0.23037776,"basement membrane"),
                     c("GO:0005622","intracellular anatomical structure",40.53151376821032,2.184422251675733,0.999854359280568,5.474E-05,"intracellular anatomical structure"),
                     c("GO:0017119","Golgi transport complex",0.0412852106642418,2.0560111249262283,0.6918025789021092,0,"Golgi transport complex"),
                     c("GO:0000178","exosome (RNase complex)",0.07602464775056147,1.6382721639824072,0.7051251238517678,0.21587622,"Golgi transport complex"),
                     c("GO:0005634","nucleus",12.339605699963672,1.747146969020107,0.6942054097968695,0.25424369,"Golgi transport complex"),
                     c("GO:0005635","nuclear envelope",0.36499827502301874,1.7746907182741372,0.7133921363253315,0.43451193,"Golgi transport complex"),
                     c("GO:0005643","nuclear pore",0.18202124653767038,1.8446639625349381,0.6198912315137075,0.6476886,"Golgi transport complex"),
                     c("GO:0031248","protein acetyltransferase complex",0.19188750560712717,1.4559319556497243,0.6226421642225396,0.4215998,"Golgi transport complex"),
                     c("GO:0043229","intracellular organelle",27.013577434711717,1.442492798094342,0.7140409950437965,0.54589579,"Golgi transport complex"),
                     c("GO:0043231","intracellular membrane-bounded organelle",20.560529937299183,1.3615107430453628,0.6776542956564812,0.67038262,"Golgi transport complex"),
                     c("GO:0071819","DUBm complex",0.007002721122628727,1.575118363368933,0.7285219675964382,0.18621948,"Golgi transport complex"),
                     c("GO:1902493","acetyltransferase complex",0.19202078197433325,1.4559319556497243,0.6881662168677944,0.62599003,"Golgi transport complex"),
                     c("GO:0110165","cellular anatomical entity",98.48275898834859,2.265200170411153,1,-0,"cellular anatomical entity"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="./results/Control_Brain_CC_Revigo_Main.pdf", width=16, height=9 ) # width and height are in inches
treemap(
  stuff,
  index = "representative",
  vSize = "value",
  type = "index",
  vColor = "representative",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  bg.labels = "#CCCCCCAA",   # define background color of group labels
  # "#CCCCCC00" is fully transparent, "#CCCCCCAA" is semi-transparent grey, NA is opaque
  position.legend = "none",
  title="Control Brain Cellular Component" ,
  fontsize.title = 24 ,
  fontsize.legend = 31,
  fontsize.labels = 23
)
dev.off()

