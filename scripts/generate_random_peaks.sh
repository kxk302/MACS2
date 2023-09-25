#!/bin/bash

MACS2_folder="/Users/kxk302/workspace/MACS2"
SEED=1234

for folder in "20mM_A_S2_R1_001" "20mM_A_try25_S6_R1_001" "20mM_B_S3_R1_001" "40mM_A_S4_R1_001" "40mM_B_S5_R1_001"
do
  for extsize in "25" "35" "50" "75" "100" "150" "200"
  do
    python3 ./scripts/generate_random_peaks.py -i ${MACS2_folder}/output/${folder}/extsize_${extsize}/${folder}_peaks.xls -w ${extsize} -s ${SEED} -g ${MACS2_folder}/input/human.hg19.genome
  done
done


