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
revigo.data <- rbind(c("GO:0001227","DNA-binding transcription repressor activity, RNA polymerase II-specific",0.033530001996326414,3.338187314462739,0.9721353270025234,-0,"DNA-binding transcription repressor activity, RNA polymerase II-specific"),
                     c("GO:0001217","DNA-binding transcription repressor activity",0.03446169363450838,3.338187314462739,0.9721337898837477,0.61204711,"DNA-binding transcription repressor activity, RNA polymerase II-specific"),
                     c("GO:0002020","protease binding",0.017154567969683735,1.645891560852599,0.9525676323647443,0.03025715,"protease binding"),
                     c("GO:0019955","cytokine binding",0.02772191260274761,1.6252516539898962,0.9516269890136355,0.33565813,"protease binding"),
                     c("GO:0042379","chemokine receptor binding",0.045127111071591404,1.39577394691553,0.9506690009356794,0.3560842,"protease binding"),
                     c("GO:0050431","transforming growth factor beta binding",0.002667035420409779,1.4282911681913124,0.9560780911398924,0.29473343,"protease binding"),
                     c("GO:0003674","molecular_function",100,1.8041003475907662,1,-0,"molecular_function"),
                     c("GO:0003735","structural constituent of ribosome",2.2675249562595297,2.27083521030723,1,-0,"structural constituent of ribosome"),
                     c("GO:0003824","catalytic activity",62.825165830214615,5.52432881167557,1,-0,"catalytic activity"),
                     c("GO:0004402","histone acetyltransferase activity",0.06964258783182388,2.378823718224965,0.8068042702833296,0.02321421,"histone acetyltransferase activity"),
                     c("GO:0003756","protein disulfide isomerase activity",0.03262282855914923,1.3655227298392685,0.9096930409847945,0.25740994,"histone acetyltransferase activity"),
                     c("GO:0004252","serine-type endopeptidase activity",0.9229250192004755,1.8297382846050425,0.734563777524846,0.32938043,"histone acetyltransferase activity"),
                     c("GO:0016410","N-acyltransferase activity",0.3304917283217695,1.85078088734462,0.8385545826954911,0.5762811,"histone acetyltransferase activity"),
                     c("GO:0016747","acyltransferase activity, transferring groups other than amino-acyl groups",2.1837653331380595,1.6382721639824072,0.8197931715308426,0.68346529,"histone acetyltransferase activity"),
                     c("GO:0004623","phospholipase A2 activity",0.049183511215605866,3.812479279163537,0.8083159922175353,0,"phospholipase A2 activity"),
                     c("GO:0003924","GTPase activity",1.2935721122789765,2.164943898279884,0.754040951298587,0.20308061,"phospholipase A2 activity"),
                     c("GO:0016298","lipase activity",0.29804052716965374,2.9546770212133424,0.7989451518568773,0.52444297,"phospholipase A2 activity"),
                     c("GO:0016788","hydrolase activity, acting on ester bonds",4.984901691821251,1.3615107430453628,0.7740200436258898,0.34306986,"phospholipase A2 activity"),
                     c("GO:0016810","hydrolase activity, acting on carbon-nitrogen (but not peptide) bonds",1.6839699783891129,1.6695862266508092,0.8001671387212791,0.28818188,"phospholipase A2 activity"),
                     c("GO:0016817","hydrolase activity, acting on acid anhydrides",5.110987902610654,1.8013429130455774,0.7733465783416692,0.40684337,"phospholipase A2 activity"),
                     c("GO:0017171","serine hydrolase activity",1.3332452857492805,1.6108339156354676,0.8050690623301667,0.28921806,"phospholipase A2 activity"),
                     c("GO:0019104","DNA N-glycosylase activity",0.20096479665802752,1.47755576649368,0.8375509932536211,0.23015604,"phospholipase A2 activity"),
                     c("GO:0019239","deaminase activity",0.24424486992059152,1.5800442515102422,0.8347043148889632,0.234488,"phospholipase A2 activity"),
                     c("GO:0052689","carboxylic ester hydrolase activity",0.6408049772165979,3.2006594505464183,0.7852387606394119,0.44985298,"phospholipase A2 activity"),
                     c("GO:0005549","odorant binding",0.051101379383091554,3.2168113089247425,0.9910739859443625,-0,"odorant binding"),
                     c("GO:0015216","purine nucleotide transmembrane transporter activity",0.03523265484388117,1.744727494896694,0.9856249905035603,0.0061281,"purine nucleotide transmembrane transporter activity"),
                     c("GO:0042910","xenobiotic transmembrane transporter activity",0.1732101931206069,1.5985994592184558,0.9855317898010951,0.30591935,"purine nucleotide transmembrane transporter activity"),
                     c("GO:0016787","hydrolase activity",21.340557702986732,3.1493537648169334,0.9332802269201649,0.04657372,"hydrolase activity"),
                     c("GO:0016740","transferase activity",21.216634542374862,2.0447934624580584,0.9333419896847676,0.11166207,"hydrolase activity"),
                     c("GO:0016877","ligase activity, forming carbon-sulfur bonds",0.2806898135919317,2.2676062401770314,0.9613191261885566,0.02629,"ligase activity, forming carbon-sulfur bonds"),
                     c("GO:0030695","GTPase regulator activity",0.7096466371489321,1.8728952016351923,0.8610672743046835,-0,"GTPase regulator activity"),
                     c("GO:0033218","amide binding",0.4051823413160237,1.4294570601181025,0.9898723353735336,0.05245335,"amide binding"),
                     c("GO:0051536","iron-sulfur cluster binding",2.0964614678491196,1.490797477668897,0.9888280478746263,0.04296316,"iron-sulfur cluster binding"),
                     c("GO:0140096","catalytic activity, acting on a protein",10.957502765653073,2.2992962828549808,0.939846917830693,0.09201678,"catalytic activity, acting on a protein"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );
# by default, outputs to a PDF file
pdf( file="./results/MSA_Brain_MF_Revigo_Main.pdf", 
     width=10, height=7) # width and height are in inches
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
  title="MSA Brain Molecular Function", #Customize your title
  fontsize.title = 24 ,
  fontsize.legend = 31,
  fontsize.labels = 23
)
dev.off()


