#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Incorrect number of parameters"
    echo "Specify the bigwig-to-histogram folder, and the output folder"
    exit
fi

HistogramFolder=${1:-"./input"}
OutputFolder=${2:-"./input"}

echo "HistogramFolder: <$HistogramFolder>"
echo "OutputFolder: <$OutputFolder>"

python3 ./scripts/add_peak_column.py -i ${HistogramFolder} -o ${OutputFolder};
