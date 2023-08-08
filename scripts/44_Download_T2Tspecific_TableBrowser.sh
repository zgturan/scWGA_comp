#!/bin/bash


# date: Jun 9, 2023
# by: zeliha gozde turan
# https://genome.ucsc.edu/cgi-bin/hgTables?hgsid=1644019928_nHYZhj3FL1O1CcJEOpzanexUpnm7&clade=mammal&org=Human&db=hs1&hgta_group=allTracks&hgta_track=hub_3671779_hgUnique&hgta_table=0&hgta_regionType=genome&position=chr9%3A145%2C458%2C455-145%2C495%2C201&hgta_outputType=primaryTable&hgta_outFileName=
# https://github.com/marbl/CHM13#downloads

sort -k1,1V -k2,2n t2t_specific.bed > t2t_specific_sorted.bed
