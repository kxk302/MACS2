#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Incorrect number of parameters"
    echo "Specify the extsize for MACS2"
    exit
fi

EXTSIZE=${1:-200}

# Shift size is -(extsize/2)
SHIFT=$((-EXTSIZE / 2))

echo "SHIFT: ${SHIFT}"
echo "EXTSIZE: ${EXTSIZE}"

for name in ATCC_0mM_S1_R1_001 ATCC_40mM_B_S5_R1_001 F_1_40mM_A_S9_R1_001 ATCC_0mM_S1_R2_001 ATCC_40mM_B_S5_R2_001 F_1_40mM_A_S9_R2_001 ATCC_20mM_A_S2_R1_001 F_1_0mM_S6_R1_001 F_1_40mM_B_S10_R1_001 ATCC_20mM_A_S2_R2_001 F_1_0mM_S6_R2_001 F_1_40mM_B_S10_R2_001 ATCC_20mM_B_S3_R1_001 F_1_20mM_A_S7_R1_001 H1299_40mM_20US1_R1 ATCC_20mM_B_S3_R2_001 F_1_20mM_A_S7_R2_001 H1299_40mM_9US1_R1 ATCC_40mM_A_S4_R1_001 F_1_20mM_B_S8_R1_001 Undetermined_S0_R1_001 ATCC_40mM_A_S4_R2_001 F_1_20mM_B_S8_R2_001 Undetermined_S0_R2_001
do
  mkdir -p ./output/${name}/extsize_${EXTSIZE}
  macs2 callpeak -t ./input/${name}_peak.bed -f BED -n ${name} --outdir ./output/${name}/extsize_${EXTSIZE} --nomodel --shift ${SHIFT} --extsize ${EXTSIZE};
done
