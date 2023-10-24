#!/bin/bash

for NON_B in STR DR MR IR GQ
do
  python3 ./scripts/aggregate_intersect_summaries_nonb.py -i ./output -e 25 35 50 75 100 150 200 -n ${NON_B} -o ./output/random_intersect_summaries_${NON_B}.tsv -r random
done
