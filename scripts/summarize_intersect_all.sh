#!/bin/bash

for extsize in 25 35 50 75 100 150 200
do
  ./scripts/run_peak_caller.sh $extsize;
  ./scripts/split_peaks_file.sh $extsize;
  ./scripts/intersect_peaks.sh ./output/ /Users/kxk302/workspace/Quadron_Docker/output/hg19/nBMST_plus_Quadron $extsize;
  ./scripts/summarize_intersect.sh ./output/ $extsize;
done
