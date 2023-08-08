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
revigo.data <- rbind(c("GO:0000003","reproduction",0.6834968749866953,1.453457336521869,1,     -0,          "reproduction"),
                     c("GO:0002376","immune system process",0.5358776487042264,1.5272435506827877,1,-0,"immune system process"),
                     c("GO:0006278","RNA-templated DNA biosynthetic process",0.17524980947636867,3.3675427078152755,0.8957443763740794,-0,"RNA-templated DNA biosynthetic process"),
                     c("GO:0000712","resolution of meiotic recombination intermediates",0.006818670464366759,3.237321436272564,0.8015952673352374,0.33644896,"RNA-templated DNA biosynthetic process"),
                     c("GO:0006163","purine nucleotide metabolic process",2.4640513040757157,1.3089185078770316,0.872322843934801,0.37209794,"RNA-templated DNA biosynthetic process"),
                     c("GO:0006259","DNA metabolic process",5.803533415077551,3.4100503986742923,0.9004175606463791,0.35755874,"RNA-templated DNA biosynthetic process"),
                     c("GO:0006281","DNA repair",2.426023079968835,1.3458234581220394,0.7746795229785673,0.68588719,"RNA-templated DNA biosynthetic process"),
                     c("GO:0006308","DNA catabolic process",0.08871256583176869,2.0491485411114536,0.9091803525269757,0.40099392,"RNA-templated DNA biosynthetic process"),
                     c("GO:0006310","DNA recombination",1.6570433606239807,1.3736596326249577,0.8825928192083918,0.6008612,"RNA-templated DNA biosynthetic process"),
                     c("GO:0006633","fatty acid biosynthetic process",0.7436109390366955,2.703334809738469,0.8984395706959868,0.18970126,"RNA-templated DNA biosynthetic process"),
                     c("GO:0018023","peptidyl-lysine trimethylation",0.009433048505826405,1.3655227298392685,0.9517452994607678,0.59032953,"RNA-templated DNA biosynthetic process"),
                     c("GO:0019538","protein metabolic process",18.67385374490695,1.6179829574251317,0.9232165365431828,0.31635035,"RNA-templated DNA biosynthetic process"),
                     c("GO:0019637","organophosphate metabolic process",5.94718450776783,1.665546248849069,0.9358939536355693,0.53944659,"RNA-templated DNA biosynthetic process"),
                     c("GO:0031123","RNA 3'-end processing",0.21355410658253823,1.856985199745905,0.9272472175979439,0.24824213,"RNA-templated DNA biosynthetic process"),
                     c("GO:0032446","protein modification by small protein conjugation",0.9153483016787367,2.0301183562535,0.9312649229539421,0.10704365,"RNA-templated DNA biosynthetic process"),
                     c("GO:0032787","monocarboxylic acid metabolic process",2.668208950140285,1.5003129173815961,0.9210447271664339,0.52552928,"RNA-templated DNA biosynthetic process"),
                     c("GO:0035825","homologous recombination",0.04754110094985078,2.496209316942819,0.9069466312344537,0.4676474,"RNA-templated DNA biosynthetic process"),
                     c("GO:0043412","macromolecule modification",10.822311035682203,1.350665141287858,0.940652777940873,0.17084959,"RNA-templated DNA biosynthetic process"),
                     c("GO:0043966","histone H3 acetylation",0.007024893668654924,1.47755576649368,0.9525886319257523,0.31796989,"RNA-templated DNA biosynthetic process"),
                     c("GO:0046390","ribose phosphate biosynthetic process",2.0360150864913424,1.30189945437661,0.9268945294821425,0.69875462,"RNA-templated DNA biosynthetic process"),
                     c("GO:0051293","establishment of spindle localization",0.016131976464477456,1.3777859770337046,0.8780359359780914,0.50039091,"RNA-templated DNA biosynthetic process"),
                     c("GO:0051304","chromosome separation",0.029553115646779832,2.3429441471428962,0.8978448066868502,0.62095059,"RNA-templated DNA biosynthetic process"),
                     c("GO:0071897","DNA biosynthetic process",0.8023612689938224,1.3851027839668655,0.8807428503267978,0.48003487,"RNA-templated DNA biosynthetic process"),
                     c("GO:0072521","purine-containing compound metabolic process",2.595262480894418,1.344861565188618,0.9211815126218899,0.20203443,"RNA-templated DNA biosynthetic process"),
                     c("GO:0080111","DNA demethylation",0.030271570681074084,2.258060922270801,0.9066493137645493,0.37115567,"RNA-templated DNA biosynthetic process"),
                     c("GO:0090305","nucleic acid phosphodiester bond hydrolysis",0.9538554958084802,2.8416375079047502,0.9189176624080689,0.24378069,"RNA-templated DNA biosynthetic process"),
                     c("GO:0006629","lipid metabolic process",4.558650411488468,1.7721132953863266,0.9650828305100417,0.05988858,"lipid metabolic process"),
                     c("GO:0006955","immune response",0.4007316001004773,3.175223537524454,0.889427735179435,-0,"immune response"),
                     c("GO:0002440","production of molecular mediator of immune response",0.005531438527922888,2.1542819820333414,0.9378111762789334,0.67888797,"immune response"),
                     c("GO:0007165","signal transduction",8.135788134528843,1.3045183235098026,0.710116279542978,0.65912233,"immune response"),
                     c("GO:0007166","cell surface receptor signaling pathway",1.1935334257213288,1.537602002101044,0.758669032498432,0.45086056,"immune response"),
                     c("GO:0007215","glutamate receptor signaling pathway",0.06996288514511727,1.4621809049267258,0.8035873484884865,0.59426043,"immune response"),
                     c("GO:0009607","response to biotic stimulus",0.9004935786085602,1.4762535331884354,0.9153075415002065,0.32014576,"immune response"),
                     c("GO:0009617","response to bacterium",0.14606922606959327,2.1084625423274357,0.9034583503144417,0.27181592,"immune response"),
                     c("GO:0009755","hormone-mediated signaling pathway",0.30407278854218556,1.7189666327522726,0.7776596696497261,0.28942852,"immune response"),
                     c("GO:0035235","ionotropic glutamate receptor signaling pathway",0.05753294781568382,1.465973893943865,0.8062038452163843,0.34772777,"immune response"),
                     c("GO:0060326","cell chemotaxis",0.06977661902511506,1.344861565188618,0.8960092624952517,0.60530592,"immune response"),
                     c("GO:0070887","cellular response to chemical stimulus",1.7854239576547926,1.30189945437661,0.8891819793073014,0.65568609,"immune response"),
                     c("GO:0007134","meiotic telophase I",18.419760480396288,1.85078088734462,0.9154254445102785,-0,"meiotic telophase I"),
                     c("GO:0007154","cell communication",8.661893464294382,1.4559319556497243,0.9901028689284319,0.01248577,"cell communication"),
                     c("GO:0007600","sensory perception",0.5816725047790565,3.661543506395395,0.9494219524676893,0,"sensory perception"),
                     c("GO:0008152","metabolic process",65.3565173451011,2.3306831194338877,1,-0,"metabolic process"),
                     c("GO:0008219","cell death",0.29675851715138435,1.9065783148377649,0.993155963650231,0.00872565,"cell death"),
                     c("GO:0009306","protein secretion",0.3514475804563201,1.350665141287858,0.9543000005498165,0.00885941,"protein secretion"),
                     c("GO:0070585","protein localization to mitochondrion",0.09740054985758624,1.3316140833099999,0.962625670869959,0.53799466,"protein secretion"),
                     c("GO:0071692","protein localization to extracellular region",0.35270820294704935,1.330683119433888,0.9594314795943439,0.59926987,"protein secretion"),
                     c("GO:0012501","programmed cell death",0.29206860234418575,1.8664610916297826,0.9803354638912577,0.00871326,"programmed cell death"),
                     c("GO:0032196","transposition",0.4594752776961755,3.237321436272564,0.9928743989102775,0.00833383,"transposition"),
                     c("GO:0032501","multicellular organismal process",2.367239488204565,1.9030899869919435,1,-0,"multicellular organismal process"),
                     c("GO:0042129","regulation of T cell proliferation",0.025761269632449048,2.8927900303521317,0.7838829711365535,-0,"regulation of T cell proliferation"),
                     c("GO:0002718","regulation of cytokine production involved in immune response",0.014275967625883965,1.744727494896694,0.813370967441982,0.67867771,"regulation of T cell proliferation"),
                     c("GO:0010821","regulation of mitochondrion organization",0.023080367976702897,1.3655227298392685,0.8775019431604423,0.1520652,"regulation of T cell proliferation"),
                     c("GO:0016441","post-transcriptional gene silencing",0.023812127733854455,1.4145392704914994,0.7680832418977422,0.5945232,"regulation of T cell proliferation"),
                     c("GO:0022408","negative regulation of cell-cell adhesion",0.026646033702459562,2.130181792020672,0.7564218750147245,0.15979936,"regulation of T cell proliferation"),
                     c("GO:0023052","signaling",8.271383217529026,1.5734887386354248,0.8102488677636791,0.37633115,"regulation of T cell proliferation"),
                     c("GO:0031399","regulation of protein modification process",0.3689898575436714,1.3467874862246563,0.8156563449447303,0.3894696,"regulation of T cell proliferation"),
                     c("GO:0031570","DNA integrity checkpoint signaling",0.0759466842501884,1.7619538968712045,0.6932556277185145,0.50452802,"regulation of T cell proliferation"),
                     c("GO:0035194","ncRNA-mediated post-transcriptional gene silencing",0.021011483572392596,1.4145392704914994,0.7655526466720061,0.43334136,"regulation of T cell proliferation"),
                     c("GO:0042981","regulation of apoptotic process",0.3296910324039186,2.1643094285075746,0.8517639997805431,0.2097112,"regulation of T cell proliferation"),
                     c("GO:0043067","regulation of programmed cell death",0.3423804118290694,2.2873502983727887,0.8513191058323266,0.2220954,"regulation of T cell proliferation"),
                     c("GO:0044092","negative regulation of molecular function",0.2735683852111087,2.5686362358410126,0.8177710697044653,0.15941842,"regulation of T cell proliferation"),
                     c("GO:0045892","negative regulation of DNA-templated transcription",0.7269401212964974,1.5718652059712113,0.6915549415683886,0.64230582,"regulation of T cell proliferation"),
                     c("GO:0045937","positive regulation of phosphate metabolic process",0.12809787167009395,1.595166283380062,0.8033413446577391,0.62943825,"regulation of T cell proliferation"),
                     c("GO:0048167","regulation of synaptic plasticity",0.0204061186823854,1.869666231504994,0.8784766153704255,0.15094795,"regulation of T cell proliferation"),
                     c("GO:0048519","negative regulation of biological process",2.4504871391226972,1.6882461389442456,0.8321614257763043,0.25582376,"regulation of T cell proliferation"),
                     c("GO:0048584","positive regulation of response to stimulus",0.44559845175601054,2.279840696594043,0.8396469260439624,0.19958054,"regulation of T cell proliferation"),
                     c("GO:0050708","regulation of protein secretion",0.03401019780397566,1.465973893943865,0.8743275264959397,0.1626072,"regulation of T cell proliferation"),
                     c("GO:0050794","regulation of cellular process",20.405819326121108,1.4236586497942072,0.7904196405298057,0.57175041,"regulation of T cell proliferation"),
                     c("GO:0051174","regulation of phosphorus metabolic process",0.3615691483700118,1.4473317838878068,0.825098319870864,0.22390954,"regulation of T cell proliferation"),
                     c("GO:0051246","regulation of protein metabolic process",2.1120748608858175,1.3098039199714864,0.8028341405370504,0.3739127,"regulation of T cell proliferation"),
                     c("GO:0090630","activation of GTPase activity",0.020662234597388442,1.9871627752948278,0.8407571975338988,0.6629334,"regulation of T cell proliferation"),
                     c("GO:0044237","cellular metabolic process",49.22533251163365,2.669586226650809,0.956860292138271,0.07761228,"cellular metabolic process"),
                     c("GO:0006807","nitrogen compound metabolic process",48.837649518475466,1.832682665251824,0.9632847026895436,0.20673508,"cellular metabolic process"),
                     c("GO:0044238","primary metabolic process",54.063119334849006,2.474955192963155,0.9621052510231137,0.22260991,"cellular metabolic process"),
                     c("GO:0071704","organic substance metabolic process",58.926970110141816,1.7772835288524167,0.9610776221962499,0.25761802,"cellular metabolic process"),
                     c("GO:1901564","organonitrogen compound metabolic process",29.993834591427927,1.7011469235902934,0.9444249919549597,0.15404898,"cellular metabolic process"),
                     c("GO:0044419","biological process involved in interspecies interaction between organisms",1.0299086178415269,1.47755576649368,1,-0,"biological process involved in interspecies interaction between organisms"),
                     c("GO:0044848","biological phase",18.41976048039629,1.8386319977650252,1,-0,"biological phase"),
                     c("GO:0045165","cell fate commitment",0.06706910792365431,1.3851027839668655,0.9857683097382179,0.00715927,"cell fate commitment"),
                     c("GO:0050896","response to stimulus",14.674014998147983,2.1191864077192086,1,-0,"response to stimulus"),
                     c("GO:0070988","demethylation",0.0856558057553038,1.6439741428068773,0.9863951818155369,0.02197627,"demethylation"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;
stuff$value <- as.numeric( as.character(stuff$value) );
stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="./results/MSA_Brain_BP_Revigo.pdf", width=16, height=9) # width and height are in inches
treemap(
  stuff,
  index = c("representative","description"),
  vSize = "value",
  type = "categorical",
  vColor = "representative",
  inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
  bg.labels = "#CCCCCCAA",   # define background color of group labels
  # "#CCCCCC00" is fully transparent, "#CCCCCCAA" is semi-transparent grey, NA is opaque
  position.legend = "none",
  title="MSA Brain Biological Process", #Customize your title
  fontsize.title = 24 ,
  fontsize.legend = 31,
  fontsize.labels = 23)
  dev.off()

  # by default, outputs to a PDF file
  png( file="./results/MSA_Brain_BP_Revigo.png", width=1600, height=900) # width and height are in inches
  treemap(
    stuff,
    index = c("representative","description"),
    vSize = "value",
    type = "categorical",
    vColor = "representative",
    inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
    lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
    bg.labels = "#CCCCCCAA",   # define background color of group labels
    # "#CCCCCC00" is fully transparent, "#CCCCCCAA" is semi-transparent grey, NA is opaque
    position.legend = "none",
    title="MSA Brain Biological Process", #Customize your title
    fontsize.title = 24 ,
    fontsize.legend = 31,
    fontsize.labels = 23)
  dev.off()