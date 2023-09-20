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

for folder in "20mM_A_S2_R1_001" "20mM_A_try25_S6_R1_001" "20mM_B_S3_R1_001" "40mM_A_S4_R1_001" "40mM_B_S5_R1_001"
do
  cd $folder

  for chromosome in {1..22}
  do
    if [ -f chr${chromosome}.bed ]
    then
      bedtools intersect -a chr${chromosome}.bed -b ${NonBDNAFolder}/chr${chromosome}_all_merged.bed > chr${chromosome}_intersect.bed
      echo "bedtools intersect -a chr${chromosome}.bed -b ${NonBDNAFolder}/chr${chromosome}_all_merged.bed > chr${chromosome}_intersect.bed"
    fi
  done
  for chromosome in "X" "Y"
  do
    if [ -f chr${chromosome}.bed ]
    then
      bedtools intersect -a chr${chromosome}.bed -b ${NonBDNAFolder}/chr${chromosome}_all_merged.bed > chr${chromosome}_intersect.bed
      echo "bedtools intersect -a chr${chromosome}.bed -b ${NonBDNAFolder}/chr${chromosome}_all_merged.bed > chr${chromosome}_intersect.bed"
    fi
  done
  
  cd -
done
