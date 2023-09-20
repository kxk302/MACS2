#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Incorrect number of parameters"
    echo "Specify the peaks folder"
    exit
fi

PeaksFolder=$1

echo "PeaksFolder: <$PeaksFolder>"

for folder in "20mM_A_S2_R1_001" "20mM_A_try25_S6_R1_001" "20mM_B_S3_R1_001" "40mM_A_S4_R1_001" "40mM_B_S5_R1_001"
do
  python3 ./scripts/summarize_intersect.py -i $PeaksFolder/$folder -o $PeaksFolder/$folder
done
