#!/bin/bash

for name in 20mM_A_S2_R1_001 20mM_A_try25_S6_R1_001 20mM_B_S3_R1_001 40mM_A_S4_R1_001 40mM_B_S5_R1_001
do
  python3 ./scripts/split_summit_file.py -i /Users/kxk302/workspace/MACS2/output/${name}/${name}_peaks.xls -o /Users/kxk302/workspace/MACS2/output/${name}
done

