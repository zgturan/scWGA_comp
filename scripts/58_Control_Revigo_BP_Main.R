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


revigo.names <-    c("term_ID",     "description","frequency",        "value",   "uniqueness","dispensability","representative");
revigo.names <- c("term_ID","description","frequency","value","uniqueness","dispensability","representative");
revigo.data <- rbind(c("GO:0002376","immune system process",0.5358776487042264,2.6556077263148894,1,-0,"immune system process"),
                     c("GO:0006955","immune response",0.4007316001004773,3.039053804266169,0.9140064983638263,0,"immune response"),
                     c("GO:0006281","DNA repair",2.426023079968835,1.8416375079047504,0.8004198285678519,0.3544894,"immune response"),
                     c("GO:0007264","small GTPase mediated signal transduction",0.33345626897253483,1.47755576649368,0.7940570365187575,0.48915419,"immune response"),
                     c("GO:0007265","Ras protein signal transduction",0.07726717799377551,1.6903698325741012,0.806192019271808,0.25817055,"immune response"),
                     c("GO:0008543","fibroblast growth factor receptor signaling pathway",0.015942384163760915,1.6497519816658373,0.8374665400001603,0.28973436,"immune response"),
                     c("GO:0009607","response to biotic stimulus",0.9004935786085602,1.6270879970298935,0.907715714023832,0.38854044,"immune response"),
                     c("GO:0051707","response to other organism",0.8494965758965254,1.6270879970298935,0.8923285577504224,0.38587153,"immune response"),
                     c("GO:0007020","microtubule nucleation",0.048715242742007586,2.317854923626168,0.8956768872749641,-0,"microtubule nucleation"),
                     c("GO:0007416","synapse assembly",0.015649680260900294,1.7594507517174003,0.9187085147411734,0.43513606,"microtubule nucleation"),
                     c("GO:0046847","filopodium assembly",0.0031133051486084327,1.575118363368933,0.935292146036021,0.3961094,"microtubule nucleation"),
                     c("GO:0048285","organelle fission",0.21729938606686847,1.3726341434072673,0.9223318643516392,0.46831524,"microtubule nucleation"),
                     c("GO:0009101","glycoprotein biosynthetic process",0.659718009059984,2.166215625343521,0.8784437663576974,-0,"glycoprotein biosynthetic process"),
                     c("GO:0006401","RNA catabolic process",0.4362086435994703,1.7746907182741372,0.9079504328729334,0.58858632,"glycoprotein biosynthetic process"),
                     c("GO:0009057","macromolecule catabolic process",2.3186905544982737,1.6716203965612624,0.9174183750253616,0.13452019,"glycoprotein biosynthetic process"),
                     c("GO:0009100","glycoprotein metabolic process",0.6877410815781743,2.243363891754152,0.8996729512911203,0.51399979,"glycoprotein biosynthetic process"),
                     c("GO:0019538","protein metabolic process",18.67385374490695,1.7695510786217261,0.9036958004513653,0.25167311,"glycoprotein biosynthetic process"),
                     c("GO:0032446","protein modification by small protein conjugation",0.9153483016787367,1.7166987712964503,0.8739115671919762,0.49823803,"glycoprotein biosynthetic process"),
                     c("GO:0036211","protein modification process",8.416557700986466,1.785156151952302,0.8602690020797131,0.57642514,"glycoprotein biosynthetic process"),
                     c("GO:0043412","macromolecule modification",10.822311035682203,1.6716203965612624,0.9260547008826231,0.30290027,"glycoprotein biosynthetic process"),
                     c("GO:0043413","macromolecule glycosylation",0.6284419318031838,1.7721132953863266,0.8770505223770042,0.41856831,"glycoprotein biosynthetic process"),
                     c("GO:0070647","protein modification by small protein conjugation or removal",1.2214999531673756,1.9665762445130504,0.8813799014914112,0.28955242,"glycoprotein biosynthetic process"),
                     c("GO:0009987","cellular process",79.12519251933975,1.9318141382538383,1,-0,"cellular process"),
                     c("GO:0030003","intracellular monoatomic cation homeostasis",0.3083269736758076,1.6420651529995463,0.9087782114756388,-0,"intracellular monoatomic cation homeostasis"),
                     c("GO:0035725","sodium ion transmembrane transport",0.2632073322859856,2.162411561764489,0.9313328240859813,0.00720518,"sodium ion transmembrane transport"),
                     c("GO:0006814","sodium ion transport",0.39320112696324494,1.8601209135987635,0.935111788461634,0.660625,"sodium ion transmembrane transport"),
                     c("GO:0015849","organic acid transport",0.8505343442793949,1.3946949538588904,0.9368790195556729,0.32880685,"sodium ion transmembrane transport"),
                     c("GO:0017038","protein import",0.050498075604885916,1.5257837359237447,0.9196030445272049,0.57270971,"sodium ion transmembrane transport"),
                     c("GO:0033036","macromolecule localization",3.705455122637613,1.91721462968355,0.9339912733197905,0.40011679,"sodium ion transmembrane transport"),
                     c("GO:0070727","cellular macromolecule localization",3.0483781010648037,1.8860566476931633,0.8984922233229048,0.28791154,"sodium ion transmembrane transport"),
                     c("GO:1990542","mitochondrial transmembrane transport",0.07024228432512059,1.586700235918748,0.9476478182793602,0.26197608,"sodium ion transmembrane transport"),
                     c("GO:0043170","macromolecule metabolic process",38.34861513800723,1.826813731587726,0.9626822073304836,0.07265528,"macromolecule metabolic process"),
                     c("GO:0044089","positive regulation of cellular component biogenesis",0.07295644778801,2.4056074496245734,0.8249309029991975,-0,"positive regulation of cellular component biogenesis"),
                     c("GO:0002682","regulation of immune system process",0.29494907484279137,1.6270879970298935,0.8877033495654263,0.18786555,"positive regulation of cellular component biogenesis"),
                     c("GO:0030336","negative regulation of cell migration",0.03537725807756334,2.3861581781239307,0.85201737712621,0.1667814,"positive regulation of cellular component biogenesis"),
                     c("GO:0031398","positive regulation of protein ubiquitination",0.0402201771976209,1.4168012260313771,0.8485565171052754,0.50523879,"positive regulation of cellular component biogenesis"),
                     c("GO:0050803","regulation of synapse structure or activity",0.04135773100192014,1.8860566476931633,0.8956662947376174,0.4914468,"positive regulation of cellular component biogenesis"),
                     c("GO:0050807","regulation of synapse organization",0.040213524836192255,2.0268721464003012,0.853143752272328,0.16820213,"positive regulation of cellular component biogenesis"),
                     c("GO:0051056","regulation of small GTPase mediated signal transduction",0.13655634922662307,2.219682687859849,0.8332753700046207,0.18308231,"positive regulation of cellular component biogenesis"),
                     c("GO:0051130","positive regulation of cellular component organization",0.17586182672780454,1.6252516539898962,0.7941904473526233,0.67749815,"positive regulation of cellular component biogenesis"),
                     c("GO:0051962","positive regulation of nervous system development",0.03540386752327795,2.3353580244438743,0.8179420897638742,0.50099056,"positive regulation of cellular component biogenesis"),
                     c("GO:0070507","regulation of microtubule cytoskeleton organization",0.057163741756393716,1.3777859770337046,0.8587765383183835,0.69475255,"positive regulation of cellular component biogenesis"),
                     c("GO:1905475","regulation of protein localization to membrane",0.02743433853175465,1.465973893943865,0.8988085467489408,0.16403194,"positive regulation of cellular component biogenesis"),
                     c("GO:0044419","biological process involved in interspecies interaction between organisms",1.0299086178415269,1.6270879970298935,1,-0,"biological process involved in interspecies interaction between organisms"),
                     c("GO:0050673","epithelial cell proliferation",0.02707843719532185,1.3705904008972811,0.995346521779398,0.00617078,"epithelial cell proliferation"),
                     c("GO:0070085","glycosylation",0.6831509521924055,1.5421181032660076,0.9853856911956906,0.02944709,"glycosylation"),
                     c("GO:1903047","mitotic cell cycle process",0.28673673465912236,1.6777807052660807,0.9544789902057288,0.00828805,"mitotic cell cycle process"),
                     c("GO:0000278","mitotic cell cycle",0.3418448967340631,1.6777807052660807,0.9609642960824236,0.68460816,"mitotic cell cycle process"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="./results/Control_Brain_BP_Revigo_Main.pdf", width=16, height=9) # width and height are in inches
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
  title="Control Brain Biological Process", #Customize your title
  fontsize.title = 24 ,
  fontsize.legend = 31,
  fontsize.labels = 23)
dev.off()

