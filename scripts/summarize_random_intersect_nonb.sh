#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Incorrect number of parameters"
    echo "Specify the peaks folder"
    exit
fi

PeaksFolder=$1

echo "PeaksFolder: <$PeaksFolder>"

for folder in ATCC_0mM_S1_R1_001 ATCC_40mM_B_S5_R1_001 F_1_40mM_A_S9_R1_001 ATCC_0mM_S1_R2_001 ATCC_40mM_B_S5_R2_001 F_1_40mM_A_S9_R2_001 ATCC_20mM_A_S2_R1_001 F_1_0mM_S6_R1_001 F_1_40mM_B_S10_R1_001 ATCC_20mM_A_S2_R2_001 F_1_0mM_S6_R2_001 F_1_40mM_B_S10_R2_001 ATCC_20mM_B_S3_R1_001 F_1_20mM_A_S7_R1_001 H1299_40mM_20US1_R1 ATCC_20mM_B_S3_R2_001 F_1_20mM_A_S7_R2_001 H1299_40mM_9US1_R1 ATCC_40mM_A_S4_R1_001 F_1_20mM_B_S8_R1_001 Undetermined_S0_R1_001 ATCC_40mM_A_S4_R2_001 F_1_20mM_B_S8_R2_001 Undetermined_S0_R2_001 20mM_A_S2_R1_001 20mM_A_try25_S6_R1_001 20mM_B_S3_R1_001 40mM_A_S4_R1_001 40mM_B_S5_R1_001
do
  for extsize in 25 35 50 75 100 150 200
  do
    for non_b in DR GQ IR MR STR
    do
      echo "$folder $extsize $non_b"
      python3 ./scripts/summarize_intersect_nonb.py -i ${PeaksFolder}/${folder}/extsize_${extsize}/random -o ${PeaksFolder}/${folder}/extsize_${extsize}/random -n ${non_b} 
    done
  done
done
