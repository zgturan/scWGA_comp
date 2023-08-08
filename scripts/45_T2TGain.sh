#!/bin/bash

file_lift=$(ls | grep _lift.bed$)

for i in $file_lift
do
    filename="${i%_lift.bed}"
    bedtools intersect -a $filename"_t2t.bed" -b $filename"_lift.bed" -v > output/${filename}_t2t_specific.bed
    awk -F '\t' -v OFS='\t' '{$2 = $2-1}1' output/${filename}_t2t_specific.bed > output/${filename}_t2t_specific_0based.bed
    bedtools intersect -a output/${filename}_t2t_specific_0based.bed -b output/t2t_specific_sorted.bed -f 0.50 -wo  | cut -f 1-3 > output2/${i}_overlapping_t2t.bed


done   
