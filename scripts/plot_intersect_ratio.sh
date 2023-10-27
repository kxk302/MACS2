#!/bin/bash

number_of_intersect_ratios=10

python3 ./scripts/plot_intersect_ratio.py -i ./output/intersect_summaries.tsv -r ./output/random_intersect_summaries.tsv -u ${number_of_intersect_ratios} -o ./output/intersect_ratio.png -d ./input/Sample_ID.tsv
