#!/bin/bash

EXTSIZES=${1:-"25 35 50 75 100 150 200"}
INPUT_DIR=${2:-"./output"}
OUTPUT_DIR=${3:-"./output"}

python3 ./scripts/aggregate_intersect_summaries.py -i ${INPUT_DIR} -e ${EXTSIZES} -o ${OUTPUT_DIR}/random_intersect_summaries.tsv -r random

