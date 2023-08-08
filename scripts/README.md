## scWGA_comparison pipeline

![Bioinformatics pipeline](/scripts/pipeline.png)

## 00_Setup.sh
Create folders and subfolders for the project

## 01_Setup.R
Install required libraries, set colors for amplification methods, diagnoses and brain regions 

## 02_SampleInfo.R
Read excel file to extract sample information

## 03_PrepareRData.R
Save outputs of Ginkgo as rds file for downstream analyses

## 04_ConfidenceScore.R
The confidence score was calculated across autosomes as described in Perez-Rodriguez et al. 2019.

## 05_Preseq.R & 22_Preseq.R
preseq was run across cells and results were gathered into rds file

## 06_SegFixed.R
Each cell's genome-wide copy number profile multiply with the normalized and segmented counts to calculate cell and CN spefic statistics in the downstream analyses

## 07_CNVStat_Filter_SegFixed.R & 08_CNVStat_Filter_SegFixed_T2T.R
Each Ginkgo predicted CNV in **CNV1** file was used to calculate CNV's median

## 09_LorenzCurve.R & 10_GC_Content.R & 11_MAD.R & 20_LorenzCurve_Figure.R & 21_GC_Content_Figure.R
* Median absolute deviation (MAD), GC content and Lorenz curve with a variable bin size of 500 kb for the hg38 genome was calculated locally across autosomes by adapting and using Ginkgo's scripts
* 20_LorenzCurve_Figure.R, 21_GC_Content_Figure.R: Ginkgo adapted scripts were used to plot Lorenz and GC content figures

## 12_Confid_VariableSize_hg38.R & 14_Confid_VariableSize_liftover.R & 16_Confid_VariableSize_t2t.R & 18_Confid_500kb_hg38.R
* The results of the confidence score were saved into one rds file:
  * 12_Confid_VariableSize_hg38.R: hg38 confidence score results for PicoPLEX (250 kb), PTA (500 kb) and dMDA (5 Mb)
  * 14_Confid_VariableSize_liftover: Liftover T2T to hg38 confidence score results for PicoPLEX (250 kb), PTA (500 kb) and dMDA (5 Mb)
  * 16_Confid_VariableSize_t2t.R: T2T confidence score results for PicoPLEX (250 kb), PTA (500 kb) and dMDA (5 Mb)
  * 18_Confid_500kb_hg38.R: hg38 confidence score results for 500kb for PicoPLEX, PTA and dMDA

## 13_MAD_VariableSize_hg38.R & 15_MAD_VariableSize_liftover.R & 17_MAD_VariableSize_t2t.R & 19_MAD_500kb_hg38.R
* The results of the MAD were saved into one rds file:
  * 13_MAD_VariableSize_hg38.R: hg38 MAD results for PicoPLEX (250 kb), PTA (500 kb) and dMDA (5 Mb)
  * 15_MAD_VariableSize_liftover.R: Liftover T2T to hg38 MAD results for PicoPLEX (250 kb), PTA (500 kb) and dMDA (5 Mb)
  * 17_MAD_VariableSize_t2t.R: T2T MAD results for PicoPLEX (250 kb), PTA (500 kb) and dMDA (5 Mb)
  * 19_MAD_500kb_hg38.R: hg38 MAD results for 500kb for PicoPLEX, PTA and dMDA

## 23_NumberofReads.R
The number of reads for different genome assemblies saved into rds file

## 24_CNV1.R
Ginkgo predicted CNV in **CNV1** files saved into rds file for different genome assemblies

## 25_WriteXLSX2.R
Statistics about each cell were saved into excel file

## 26_EliminateCells.R
Cells having high MAD scores (>0.3) and having low confidence scores (<0.7) were excluded from the analyses.

## 27_Figures_CN_plots_EachCell.R
CN profile of each cell was plotted using this script

## 28_GatherCNStat.R & 29_GatherSigniCells.R
Cells passing QC and CN related statistics were gathered into rds file. 

## 30_Diploid_SegFixed.R
Median CN of diploid segments across autosomes was calculated 

## 31_Male_Median.R
Median of chromosome X across males

## 32_CNVStat_Filter_SegFixed_Chromosome_PicoPLEX.R & 33_CNVStat_Filter_SegFixed_Chromosome_PTA.R &  36_CNVStat_Filter_SegFixed_Chromosome_PicoPLEX_Male.R & 37_CNVStat_Filter_SegFixed_Chromosome_PTA_Male.R & 38_PicoPLEX_PTA_Male.R
We plotted the distribution of the segments CN values on a histogram, from which we set thresholds of 1.29 for a loss and 2.80 for a gain. By using these thresholds, we showed that the median CN of chromosome X in males (n=11; mean=1.11) is below 1.29 and that the CN of fibroblasts is above 2.80 (n=2; mean=4.14). We applied the same threshold values to PTA data and found that the median CN of chromosome X in males (n=5; mean=1.23) falls below 1.29.

## 34_RemoveCommanCNVs_PicoPLEX.R & 35_RemoveCommanCNVs_PTA.R
To identify common CNVs shared among multiple cells, we consider two CNVs as shared if their start and end positions are within 2.5Mb of each other for PicoPLEX cells, and within 5Mb for PTA cells. We removed these calls from downstream analyses, as they could result from either dry lab/wet lab artifacts or germline mutations.

## 39_Figures_CNStats_For_EachCell_PicoPLEX_paper.R & 40_Figures_CNStats_For_EachCell_PTA_paper.R
CN plot of QC passing cells were plotted

## 41_Write_Table.R
Statistics about significant CNs was saved into excel file

## 42_CNV_percell.R
* How to interpret this table: In the first row (PTA/06CC_MSA1), the initial total number of cells for analysis is 13. After applying the MAD  (<=0.3) and confidence score (>=0.7) filters, 5 cells passed these criteria. Out of these 5 cells, 4 have at least one CNV. The total number of identified CNVs is 8, with an equal number of losses and gains - 4 each.

| Sample                    | # of cells | # of cells passing QC | # of cells with at least one CNV | # number of CNVs | # of losses | # of gains |
|---------------------------|------------|-----------------------|----------------------------------|------------------|-------------|------------|
| PTA/06CC_MSA1        | 13         | 5                     | 4                                | 8                | 4           | 4          |
| PTA/10FC_Control     | 12         | 6                     | 2                                | 2                | 0           | 2          |
| PicoPLEX/06CC_MSA1   | 15         | 11                    | 3                                | 21               | 6           | 15         |
| PicoPLEX/10FC_Control | 7          | 4                     | 1                                | 4                | 2           | 2          |
| PicoPLEX/01CC_MSA2   | 12         | 8                     | 3                                | 4                | 1           | 3          |

## 43_T2T_SpecificGains.R
* For these analyses, we used samples that were aligned to T2T and lifted over to hg38, passing both the MAD (<= 0.3) and confidence score (>=0.7) filters. There are 25 PicoPLEX cells and 14 PTA cells. One PicoPLEX cell ("A24_v2_Exp9_1_sn5_sample1_06_CC_S24_R") was excluded from the analyses due to the absence of a T2T version.
* Using the Ginkgo reported CNV1 file, gains (CN > 2) were saved into the text files for both T2T and liftover versions. These text files are located in the following directory: ./data/processed/t2t_gains/
* The T2T profile of each cell is indicated with a '_t2t.bed' extension, and the liftover profile of the same cell is indicated by a '_lift.bed' extension.

## 44_Download_T2Tspecific_TableBrowser.sh
T2T specific genomic regions was downloaded from the UCSC Table Browser and then sorted.

## 45_T2TGain.sh
* bedtools subtract (v2.30.0) was used to remove intervals in the T2T gains (CN > 2) overlapping with intervals in the lifted-over version. 
* 1-based coordinates were converted into 0-based.
* If the T2T-specific gains for each cell showed a minimum of 50% overlap with the bed file obtained from the UCSC Table Browser, those positions were kept for the analysis (using Bedtools v2.30.0 with the intersect -f 0.50 -wo).

## 47_WriteTableSignificantCNVs_MSA.R & 48_WriteTableSignificantCNVs_MSA_PANTHER_BP.R & 49_MSA_Revigo_BP.R & 50_MSA_Revigo_BP_Main.R
A list of genes covered by significant CNVs was separately identified for MSA patients and controls using the Ensembl BioMart package. The gene lists were submitted to PANTHER to identify statistical overrepresentations in any GO categories. The remaining analyses were conducted as described in Perez-Rodriguez et al. 2019.

## 64_Copykit_Script.R & 65_write_cn_segments.R
CopyKit was run by  Caoimhe Morley and Ida Bomann. DNAcopy alpha parameter: 0.01

## 66_Samplot.sh
Samplot was run by Christos Proukakis.
