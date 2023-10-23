#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Incorrect number of parameters"
    echo "Specify the peaks folder, and the non-B DNA annotations folder"
    exit
fi

PeaksFolder=$1
NonBDNAFolder=$2

echo "PeaksFolder: <$PeaksFolder>"
echo "NonBDNAFolder: <$NonBDNAFolder>"

cd $PeaksFolder

for folder in ATCC_0mM_S1_R1_001 ATCC_40mM_B_S5_R1_001 F_1_40mM_A_S9_R1_001 ATCC_0mM_S1_R2_001 ATCC_40mM_B_S5_R2_001 F_1_40mM_A_S9_R2_001 ATCC_20mM_A_S2_R1_001 F_1_0mM_S6_R1_001 F_1_40mM_B_S10_R1_001 ATCC_20mM_A_S2_R2_001 F_1_0mM_S6_R2_001 F_1_40mM_B_S10_R2_001 ATCC_20mM_B_S3_R1_001 F_1_20mM_A_S7_R1_001 H1299_40mM_20US1_R1 ATCC_20mM_B_S3_R2_001 F_1_20mM_A_S7_R2_001 H1299_40mM_9US1_R1 ATCC_40mM_A_S4_R1_001 F_1_20mM_B_S8_R1_001 Undetermined_S0_R1_001 ATCC_40mM_A_S4_R2_001 F_1_20mM_B_S8_R2_001 Undetermined_S0_R2_001
do
  for EXTSIZE in 25 35 50 75 100 150 200
  do
    cd $folder/extsize_${EXTSIZE}/random

    for chromosome in {1..22}
    do
      if [ -f chr${chromosome}.bed ]
      then
        bedtools intersect -a chr${chromosome}.bed -b ${NonBDNAFolder}/chr${chromosome}_all_merged.bed > chr${chromosome}_intersect.bed
      fi
    done

    for chromosome in "X" "Y"
    do
      if [ -f chr${chromosome}.bed ]
      then
        bedtools intersect -a chr${chromosome}.bed -b ${NonBDNAFolder}/chr${chromosome}_all_merged.bed > chr${chromosome}_intersect.bed
      fi
    done

    cd -
  done
done
