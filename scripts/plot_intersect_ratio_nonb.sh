#!/bin/bash

non_b="DR"
filter=0.25
python3 ./scripts/plot_intersect_ratio.py -i ./output/intersect_summaries_${non_b}.tsv -r ./output/random_intersect_summaries_${non_b}.tsv -f ${filter} -o ./output/intersect_ratio_${non_b}.png -n ${non_b}

non_b="GQ"
filter=0.02
python3 ./scripts/plot_intersect_ratio.py -i ./output/intersect_summaries_${non_b}.tsv -r ./output/random_intersect_summaries_${non_b}.tsv -f ${filter} -o ./output/intersect_ratio_${non_b}.png -n ${non_b}

non_b="IR"
filter=0.04
python3 ./scripts/plot_intersect_ratio.py -i ./output/intersect_summaries_${non_b}.tsv -r ./output/random_intersect_summaries_${non_b}.tsv -f ${filter} -o ./output/intersect_ratio_${non_b}.png -n ${non_b}

non_b="MR"
filter=0.30
python3 ./scripts/plot_intersect_ratio.py -i ./output/intersect_summaries_${non_b}.tsv -r ./output/random_intersect_summaries_${non_b}.tsv -f ${filter} -o ./output/intersect_ratio_${non_b}.png -n ${non_b}

non_b="STR"
filter=0.30
python3 ./scripts/plot_intersect_ratio.py -i ./output/intersect_summaries_${non_b}.tsv -r ./output/random_intersect_summaries_${non_b}.tsv -f ${filter} -o ./output/intersect_ratio_${non_b}.png -n ${non_b}
