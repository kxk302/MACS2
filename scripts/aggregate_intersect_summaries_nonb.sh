#!/bin/bash

for EXTSIZE in 25 35 50 75 100 150 200
do
  for NON_B in STR DR MR IR GQ
  do
    python3 ./scripts/aggregate_intersect_summaries_nonb.py -i ./output -e ${EXTSIZE} -n ${NON_B} -o ./output/intersect_summaries_${NON_B}.tsv
  done
done
