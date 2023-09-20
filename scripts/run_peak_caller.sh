#!/bin/bash

SHIFT=${1:--100}
EXTSIZE=${1:-200}

echo "SHIFT: ${SHIFT}"
echo "EXTSIZE: ${EXTSIZE}"

for name in 20mM_A_S2_R1_001 20mM_A_try25_S6_R1_001 20mM_B_S3_R1_001 40mM_A_S4_R1_001 40mM_B_S5_R1_001
do
  macs2 callpeak -t ./input/${name}_BigWigs_as_Histogram_peak.bed -f BED -n ${name} --outdir ./output/${name} --nomodel --shift ${SHIFT} --extsize ${EXTSIZE};
done

