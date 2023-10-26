#!/bin/bash

number_of_intersect_ratios=10

non_b="DR"
filter=0.25
python3 ./scripts/plot_intersect_ratio.py -i ./output/intersect_summaries_${non_b}.tsv -r ./output/random_intersect_summaries_${non_b}.tsv -o ./output/intersect_ratio_${non_b}.png -n ${non_b} -u ${number_of_intersect_ratios}

non_b="GQ"
filter=0.02
python3 ./scripts/plot_intersect_ratio.py -i ./output/intersect_summaries_${non_b}.tsv -r ./output/random_intersect_summaries_${non_b}.tsv -o ./output/intersect_ratio_${non_b}.png -n ${non_b} -u ${number_of_intersect_ratios}

non_b="IR"
filter=0.04
python3 ./scripts/plot_intersect_ratio.py -i ./output/intersect_summaries_${non_b}.tsv -r ./output/random_intersect_summaries_${non_b}.tsv -o ./output/intersect_ratio_${non_b}.png -n ${non_b} -u ${number_of_intersect_ratios}

non_b="MR"
filter=0.30
python3 ./scripts/plot_intersect_ratio.py -i ./output/intersect_summaries_${non_b}.tsv -r ./output/random_intersect_summaries_${non_b}.tsv -o ./output/intersect_ratio_${non_b}.png -n ${non_b} -u ${number_of_intersect_ratios}

non_b="STR"
filter=0.30
python3 ./scripts/plot_intersect_ratio.py -i ./output/intersect_summaries_${non_b}.tsv -r ./output/random_intersect_summaries_${non_b}.tsv -o ./output/intersect_ratio_${non_b}.png -n ${non_b} -u ${number_of_intersect_ratios}
