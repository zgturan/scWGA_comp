source('./scripts/01_Setup.R')
setwd("./data/processed/rds")
aa= grep("_gc_plot",list.files(), val=T)
aa2= aa[aa%in%c("dMDA_101_500kb_gc_plot.rds",
                "Pico_76_500kb_gc_plot.rds", 
                "Pico_101_500kb_gc_plot.rds",
                "PTA_48_500kb_gc_plot.rds",
                "PTA_101_500kb_gc_plot.rds")]
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
all3_dmda <- melt(all2, id.vars = c("GC_Content", "Log_Normalized_Read_Counts", "Fitted_Values","data"))
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

cbp3= c(cbp1, cbp1, cbp1)
first=      ggplot(all3_dmda, aes(x=GC_Content, y=Log_Normalized_Read_Counts, color=factor(value))) +
            geom_line(aes(y= Fitted_Values), size = 2.6) +
            facet_wrap(~data)+
            theme_pubr(base_size = 44) +
            labs(title="GC Content vs. Bin Counts") +
            xlim(c(min(.3, min(all3_dmda$GC_Content)), max(.6, max(all3_dmda$GC_Content)))) +
            xlab("GC content") +
            ylab("Normalized Read Counts (log scale)") +
            scale_color_manual(values = cbp3[1:unique(length(unique(all3_dmda$value)))], name="value", guide="none")+
            theme(strip.background = element_rect(fill='white',color='black', size = 1),
                  plot.margin = margin(3, 0.1, 0.1, 3,"cm")) 
ggsave(first, filename= './results/GC_500kb_brain_jul17_2023.pdf',
       unit="cm", width = 28, height = 10, useDingbats = F, limitsize = FALSE)
ggsave(first, filename = './results/GC_500kb_brain_jul17_2023.png',
       unit="cm", width = 28, height = 10, limitsize = FALSE)
saveRDS(first, file = './data/processed/rds/GC_500kb_brain.rds')
