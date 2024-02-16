#!/bin/bash

number_of_intersect_ratios=${1:-"10"}

INPUT_DIR=${2:-"./input"}

OUTPUT_DIR=${3:-"./output"}

python3 ./scripts/plot_intersect_ratio.py -i ${OUTPUT_DIR}/intersect_summaries.tsv -r ${OUTPUT_DIR}/random_intersect_summaries.tsv -u ${number_of_intersect_ratios} -o ${OUTPUT_DIR}/intersect_ratio.png -d ${INPUT_DIR}/Sample_ID.tsv
