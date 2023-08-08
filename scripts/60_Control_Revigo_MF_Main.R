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
revigo.data <- rbind(c("GO:0001671","ATPase activator activity",0.0341266115541096,1.705533773838407,1,-0,"ATPase activator activity"),
                     c("GO:0005048","signal sequence binding",0.049864572354627774,1.5497508916806388,0.9673353717977522,0.03288828,"signal sequence binding"),
                     c("GO:0005544","calcium-dependent phospholipid binding",0.06450738684359872,1.5497508916806388,0.8461131029593991,-0,"calcium-dependent phospholipid binding"),
                     c("GO:0008143","poly(A) binding",0.0117496667704059,1.4168012260313771,0.9600340674209648,0.02998868,"poly(A) binding"),
                     c("GO:0035639","purine ribonucleoside triphosphate binding",15.371222998377657,1.3142582613977363,0.9429806624428634,0.10174656,"poly(A) binding"),
                     c("GO:0015035","protein-disulfide reductase activity",0.18792111372348003,1.4168012260313771,0.9828952708525827,0.0357295,"protein-disulfide reductase activity"),
                     c("GO:0016874","ligase activity",3.3525752174818915,1.5497508916806388,0.9794303491284091,0.03520688,"ligase activity"),
                     c("GO:0046527","glucosyltransferase activity",0.16278723344901566,3.764471553092451,0.8736326218606122,0,"glucosyltransferase activity"),
                     c("GO:0016758","hexosyltransferase activity",0.9260824186409812,1.826813731587726,0.8716122551229445,0.65606103,"glucosyltransferase activity"),
                     c("GO:0051018","protein kinase A binding",0.010529205209278646,1.4168012260313771,0.9703625206515164,0.02978941,"protein kinase A binding"),
                     c("GO:0140326","ATPase-coupled intramembrane lipid transporter activity",0.049145371791820644,1.3279021420642825,1,-0,"ATPase-coupled intramembrane lipid transporter activity"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );
# by default, outputs to a PDF file
pdf( file="./results/Control_Brain_MF_Revigo_Main.pdf", width=16, height=9 ) # width and height are in inches
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
  title="Control Brain Molecular Function", #Customize your title
  fontsize.title = 24 ,
  fontsize.legend = 31,
  fontsize.labels = 23
)
dev.off()


