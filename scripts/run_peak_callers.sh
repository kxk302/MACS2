#!/bin/bash

# The default value makes sure the script runs correctly for the initial experiment
# The list of directories can be overriden by specifying it as 1st command line argument 
DIR_NAMES=${1:-"ATCC_0mM_S1_R1_001 ATCC_40mM_B_S5_R1_001 F_1_40mM_A_S9_R1_001 ATCC_0mM_S1_R2_001 ATCC_40mM_B_S5_R2_001 F_1_40mM_A_S9_R2_001 ATCC_20mM_A_S2_R1_001 F_1_0mM_S6_R1_001 F_1_40mM_B_S10_R1_001 ATCC_20mM_A_S2_R2_001 F_1_0mM_S6_R2_001 F_1_40mM_B_S10_R2_001 ATCC_20mM_B_S3_R1_001 F_1_20mM_A_S7_R1_001 H1299_40mM_20US1_R1 ATCC_20mM_B_S3_R2_001 F_1_20mM_A_S7_R2_001 H1299_40mM_9US1_R1 ATCC_40mM_A_S4_R1_001 F_1_20mM_B_S8_R1_001 Undetermined_S0_R1_001 ATCC_40mM_A_S4_R2_001 F_1_20mM_B_S8_R2_001 Undetermined_S0_R2_001"}

EXTSIZES="25 35 50 75 100 150 200"

for extsize in ${EXTSIZES}
do
  echo "extsize: ${extsize}"
  echo "DIR_NAMES: ${DIR_NAMES}"
  ./scripts/run_peak_caller.sh ${extsize} "${DIR_NAMES}"
done
