1. Follow the steps 1 to 6 and 10 to 11 in README.txt

2. For each chromosome, find the intersection between chromosome peaks and each non-b DNA annotations
   (STR, DR, MR, IR, GQ) by running the following command:

   ./scripts/intersect_random_peaks_nonb.sh <PeaksFolder> <NonBDNAFolder>

   This shell script creates a "<NonBDNAType>_intersect.bed" file for each chromosome in the same random folder
   as the peaks file. <PeaksFolder> parameter value is "./output". <NonBDNAFolder> parameter value is:

   /Users/kxk302/workspace/Quadron_Docker/output/hg19/nBMST_plus_Quadron

   The shell script finds the intersect in <EXTSIZE> subfolders 25, 35, 50, 75, 100, 150, and 200.

3. For each chromosome and each non-b DNA annotations (STR, DR, MR, IR, GQ), summarize the intersect files
   by dividing the sum of the lengths of the intersect intervals by the sum of the length of the peak
   intervals, by running the following command:

   ./scripts/summarize_intersect_nonb.sh <PeaksFolder>

   <PeaksFolder> parameter value is "./output". This shell scripts calls ./scripts/summarize_intersect.py for
   each folder. For each chromosome and each non-B DNA annotation, it divides the sum of peaks/non-B DNA intersect
   lengths by the sum of the peaks lengths, and writes them to a "peaks_summary_<NonBDNAType>.txt" file in the same
   folder. The last line of the txt file calculates the harmonic mean of the intersect ratios for all chromosomes.

4. Aggregate intersect summaries for each non-B DNA annotation by running the following command:

   ./scripts/aggregate_intersect_summaries_nonb.sh

   This script calls ./scripts/aggregate_intersect_summaries_nonb.py, that reads the last line of the
   'peaks_summary_<NonBDNAType>.txt' file in each folder to get the Harmonic mean value of the intersect ratio
   between peaks and each non-B DNA annotation, and writes the Harmonic mean value to a file named 
   './output/intersect_summaries_<NonBDNAType>.tsv. The folder names in this file are sorted based the value of
   the Harmonic mean, in descending order.

5. For each chromosome in each folder and EXTSIZE subfolder, and for each non-B DNA type, find the intersection
   between the chromosome random intervals and non-b DNA annotations, by running thefollowing command:

   ./scripts/intersect_random_peaks_nonb.sh <PeaksFolder> <NonBDNAFolder>

   This shell script creates a "<NonBDNAType>_intersect.bed" file for each chromosome and non-B DNA type in the
   same random folder as the .bed file. <PeaksFolder> parameter value is "./output". As for
   <NonBDNAFolder> parameter value, set it to './nonb' and copy the non-B DNA Annotations files
   from 'Non-B-DNA-Annotations' collection in Galaxy history below:

   https://usegalaxy.org/u/kaivan/h/pdal-seq-non-b-dna-annotations

6. For each chromosome in the random folder and EXTSIZE subfolder, and for each non-B DNA type, summarize the
   intersect files by dividing the sum of the length of intersect intervals by the sum of the length of random
   intervals, by running the following command:

   ./scripts/summarize_random_intersect_nonb.sh <PeaksFolder>

   <PeaksFolder> parameter value is "./output". This shell scripts calls ./scripts/summarize_intersect_nonb.py
   for each folder. For each chromosome and nob-B DNA type, it divides the sum of random/non-B DNA intersect
   intervals lengths by the sum of the random intervals lengths, and writes them to a "peaks_summary_<NonBDNAType>.txt"
   file in the same folder. The last line of the .txt file calculates the harmonic mean of the intersect ratios for
   all chromosomes.

7. Aggregate random intersect summaries, for each non-B DNA type, by running the following command:

  ./scripts/aggregate_random_intersect_summaries_nonb.sh

  This script calls ./scripts/aggregate_intersect_summaries_nonb.py, that reads the last line of
  'peaks_summary_<NonBDNAType>.txt' file in each random folder to get the Harmonic mean value of intersect ratio
  between random intervals and each non-B DNA type, and writes the Harmonic mean value to a file named
  './output/random_intersect_summaries_<NonBDNAType>.tsv. The folder names in this file are sorted based the value
  of the Harmonic mean, in descending order.

8. For each non-B DNA type, plot the samples with best intersect ratio in a bar plot by running the following command:

   ./scripts/plot_intersect_ratio_nonb.sh

   The shell script calls ./scripts/plot_intersect_ratio.pyi for each non-B DNA type. Intersect summaries
   (./output/intersect_summaries_<NonBDNAType>.tsv) and random intersect summaries
   (./output/random_intersect_summaries_<NonBDNAType>.tsv) are passed in as input. We also pass a filter value,
   such that rows in intersect_summaries_<NonBDNAType>.tsv whose harmonic mean is less than the filter value are
   ignored. The  bar plot for each no-B DNA type is saved separately as an .png file.
