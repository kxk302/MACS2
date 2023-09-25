#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Incorrect number of parameters"
    echo "Specify the peaks folder, and extsize for MACS2"
    exit
fi

PeaksFolder=$1
EXTSIZE=$2

echo "PeaksFolder: <$PeaksFolder>"
echo "EXTSIZE: <$EXTSIZE>"

for folder in "20mM_A_S2_R1_001" "20mM_A_try25_S6_R1_001" "20mM_B_S3_R1_001" "40mM_A_S4_R1_001" "40mM_B_S5_R1_001"
do
  python3 ./scripts/summarize_intersect.py -i $PeaksFolder/$folder/extsize_$EXTSIZE -o $PeaksFolder/$folder/extsize_$EXTSIZE
done
