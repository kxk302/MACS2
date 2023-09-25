#!/bin/bash

MACS2_folder="/Users/kxk302/workspace/MACS2"

for name in 20mM_A_S2_R1_001 20mM_A_try25_S6_R1_001 20mM_B_S3_R1_001 40mM_A_S4_R1_001 40mM_B_S5_R1_001
do
  for extsize in 25 35 50 75 100 150 200
  do
    python3 ./scripts/split_peaks_file.py -i ${MACS2_folder}/output/${name}/extsize_${extsize}/${name}_peaks_random.bed -o ${MACS2_folder}/output/${name}/extsize_${extsize}/random/
  done
done

