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
revigo.data <- rbind(c("GO:0005575","cellular_component",100,2.4672456210075024,1,-0,"cellular_component"),
                     c("GO:0005622","intracellular anatomical structure",40.53151376821032,6.274905478918531,0.9998185478220228,0.0001026,"intracellular anatomical structure"),
                     c("GO:0031974","membrane-enclosed lumen",2.681726134581714,3.764471553092451,0.999889145649289,6.41E-05,"membrane-enclosed lumen"),
                     c("GO:0032153","cell division site",0.138230440169954,1.7931741239681502,0.9999213538593174,4.547E-05,"cell division site"),
                     c("GO:0032991","protein-containing complex",14.950577315143775,1.723538195826756,1,-0,"protein-containing complex"),
                     c("GO:0043005","neuron projection",0.251660052350957,1.5466816599529623,0.9999165046204556,4.831E-05,"neuron projection"),
                     c("GO:0043226","organelle",27.69475294750206,5.272458742971444,0.999833298206757,0.00021213,"organelle"),
                     c("GO:0070013","intracellular organelle lumen",2.68166520824242,3.764471553092451,0.5624416191370858,0,"intracellular organelle lumen"),
                     c("GO:0000932","P-body",0.07256707799561482,2.958607314841775,0.732471474012754,0.17613271,"intracellular organelle lumen"),
                     c("GO:0005737","cytoplasm",25.080076249313628,5.037630664329979,0.791770295809738,0.21474314,"intracellular organelle lumen"),
                     c("GO:0005739","mitochondrion",2.7614025547937224,2.0660068361687576,0.6509303396246295,0.28058401,"intracellular organelle lumen"),
                     c("GO:0005788","endoplasmic reticulum lumen",0.08664867816499004,1.563837352959244,0.6364885449552814,0.66011922,"intracellular organelle lumen"),
                     c("GO:0005819","spindle",0.26436319409380066,1.3334820194451191,0.70725244152356,0.38731473,"intracellular organelle lumen"),
                     c("GO:0005840","ribosome",3.532158825827589,1.4259687322722812,0.6185920124665725,0.503967,"intracellular organelle lumen"),
                     c("GO:0015934","large ribosomal subunit",0.5174778627954071,2.024108863598207,0.6318275596318786,0.34723224,"intracellular organelle lumen"),
                     c("GO:0031090","organelle membrane",4.853437882931562,1.85078088734462,0.6364447383084922,0.37235378,"intracellular organelle lumen"),
                     c("GO:0032588","trans-Golgi network membrane",0.011933946709254177,1.563837352959244,0.7315005925239466,0.36071612,"intracellular organelle lumen"),
                     c("GO:0043227","membrane-bounded organelle",21.025710153602915,3.5086383061657274,0.6126769490830901,0.64732516,"intracellular organelle lumen"),
                     c("GO:0043228","non-membrane-bounded organelle",9.556376284117798,2.0123337350737254,0.6560038053617882,0.50773832,"intracellular organelle lumen"),
                     c("GO:0043229","intracellular organelle",27.013577434711717,5.255707016877324,0.5806599619305886,0.42837084,"intracellular organelle lumen"),
                     c("GO:0043231","intracellular membrane-bounded organelle",20.560529937299183,3.5654310959658013,0.5464955407221445,0.64231502,"intracellular organelle lumen"),
                     c("GO:0044391","ribosomal subunit",0.9017783636860739,1.5072396109731625,0.6127642094789518,0.64681207,"intracellular organelle lumen"),
                     c("GO:0055037","recycling endosome",0.08132904716536399,2.1079053973095196,0.7331074919274694,0.17800333,"intracellular organelle lumen"),
                     c("GO:0070069","cytochrome complex",0.18875360702968103,1.3777859770337046,0.9043206113396784,0.27771709,"intracellular organelle lumen"),
                     c("GO:0098798","mitochondrial protein-containing complex",0.4666272168619737,2.305394801066431,0.5896234746310675,0.21260964,"intracellular organelle lumen"),
                     c("GO:0098803","respiratory chain complex",0.25836956546573236,1.5128616245228135,0.8592593443799516,0.28541525,"intracellular organelle lumen"),
                     c("GO:0070469","respirasome",0.4633524261249097,1.3851027839668655,0.9868820730954451,5.159E-05,"respirasome"),
                     c("GO:0110165","cellular anatomical entity",98.48275898834859,2.07727454200674,1,-0,"cellular anatomical entity"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="./results/MSA_Brain_CC_Revigo_Main.pdf", width=10, height=7) # width and height are in inches
treemap(
  stuff,
  index ="representative",
  vSize = "value",
  type = "index",
  vColor = "representative",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  bg.labels = "#CCCCCCAA",   # define background color of group labels
  # "#CCCCCC00" is fully transparent, "#CCCCCCAA" is semi-transparent grey, NA is opaque
  position.legend = "none",
  title="MSA Brain Cellular Component" ,
  fontsize.title = 24 ,
  fontsize.legend = 31,
  fontsize.labels = 23
)
dev.off()

