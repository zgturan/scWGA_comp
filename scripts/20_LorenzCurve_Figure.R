source('./scripts/01_Setup.R')
setwd("./data/processed/rds")

aa= grep("_lorenz",list.files(), val=T)
aa2= aa[aa%in%c("dMDA_101_500kb_lorenz.rds",
                "Pico_76_500kb_lorenz.rds", 
                "Pico_101_500kb_lorenz.rds",
                "PTA_48_500kb_lorenz.rds",
                "PTA_101_500kb_lorenz.rds")]
for (i in 1:length(aa2)){
  fname = file.path('./data/processed/rds/',aa2[i])
  readRDS(fname)}
all = lapply(aa2, function(x) readRDS(x))
all2= data.table::rbindlist(all)
all2= data.frame(all2)
qq= strsplit(all2$cellID,'_')
qq2= sapply(qq, function(x) x[[1]])
all2$data=qq2
all2$data= gsub('Pico', 'PicoPLEX', all2$data) 
saveRDS(all2, file = './data/processed/rds/gini_input.rds')

all3_dmda <- melt(all2, id.vars = c("CumulativeFractionOfGenome", "CumulativeFractionOfTotalReads", "data"))
all3_dmda$data = factor(all3_dmda$data, levels = c('PicoPLEX', 'PTA', 'dMDA'))
cbp1 <- c(
  '#4F6980', "#1B9E77" ,"#D95F02", "#7570B3", "#E7298A" ,
  "#66A61E", "#E6AB02", "#A6761D", "#666666", '#849DB1',
  '#A2CEAA','#638B66','#BFBB60',  '#F47942',
  '#FBB04E', '#B9AA97','#7E756D', '#B9AA97',
  '#C799BC', '#B173A0','#F498B6','#8074A8',
  '#C6C1F0','#C46487', '#9B93C9','#795FAF', '#4A66AC', '#629DD1',
  '#297FD5','#7F8FA9', '#FEC306', '#A6B727', '#D092A7',
  '#EFA86E','#6C3921','#C43D31','#6D9A58','#8E0152','#40004B',
  '#B35806','#7570B3', "#D55E00")

cbp3= c(cbp1,cbp1,cbp1)
first=      ggplot(all3_dmda, aes(x=CumulativeFractionOfGenome, y=CumulativeFractionOfTotalReads, 
                                  color=factor(value))) +
            geom_line(size = 2.3) +
            facet_wrap(~data)+
            theme_pubr(base_size = 44) +
            labs(title="Lorenz Curve of Coverage Uniformity") +
            geom_abline(intercept = 0, slope = 1, colour = "black", size = 0.5) +
            scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.1)) +
            scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = 0.1)) +
            xlab("Cumulative Fraction of Genome") +
            ylab("Cumulative Fraction of Total Reads") +
            scale_color_manual(values = cbp3[1:unique(length(unique(all3_dmda$value)))], name="value", guide="none")+
            theme(strip.background = element_rect(fill='white',color='black', size = 1),
            plot.margin = margin(3, 0.1, 0.1, 3,"cm")) 
     
ggsave(first, filename= './results/Lorenz_curve_500kb_brain_jul13_2023.pdf',
             unit="cm", width = 28, height = 10, useDingbats = F, limitsize = FALSE)
     
ggsave(first, filename = './results/Lorenz_curve_500kb_brain_jul13_2023.png',
             unit="cm", width = 28, height = 10, limitsize = FALSE)
saveRDS(first, file = './data/processed/rds/Lorenz_curve_500kb_brain.rds')
