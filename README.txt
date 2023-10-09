1. There are the following 24 files for PDAL-seq experiment:

   ATCC_0mM_S1_R1_001.fastq
   ATCC_0mM_S1_R2_001.fastq
   ATCC_20mM_A_S2_R1_001.fastq
   ATCC_20mM_A_S2_R2_001.fastq
   ATCC_20mM_B_S3_R1_001.fastq
   ATCC_20mM_B_S3_R2_001.fastq
   ATCC_40mM_A_S4_R1_001.fastq
   ATCC_40mM_A_S4_R2_001.fastq
   ATCC_40mM_B_S5_R1_001.fastq
   ATCC_40mM_B_S5_R2_001.fastq
   F_1_0mM_S6_R1_001.fastq
   F_1_0mM_S6_R2_001.fastq
   F_1_20mM_A_S7_R1_001.fastq
   F_1_20mM_A_S7_R2_001.fastq
   F_1_20mM_B_S8_R1_001.fastq
   F_1_20mM_B_S8_R2_001.fastq
   F_1_40mM_A_S9_R1_001.fastq
   F_1_40mM_A_S9_R2_001.fastq
   F_1_40mM_B_S10_R1_001.fastq
   F_1_40mM_B_S10_R2_001.fastq
   H1299_40mM_20US1_R1.fastq
   H1299_40mM_9US1_R1.fastq
   Undetermined_S0_R1_001.fastq
   Undetermined_S0_R2_001.fastq

2. In the Galaxy history listed below, each fastq file is mapped to hg19 using BWA-MEM (Creates
   a .bam file), the .bam file is filtered based on mapping quality >= 30 (Creates another .bam
   file), .bam file's intervals that intersect with a black listed region are removed, and .bam
   file is converted to .bigwig.

   https://usegalaxy.org/u/kaivan/h/pdal-seq-workflow

3. In the Galaxy history listed below, .bigwig is converted to histogram format.

   https://usegalaxy.org/u/kaivan/h/pdal-seq-histogram

4. Download bigwig-to-histogram tabular files from Galaxy history in step 3 into ./input folder:

5. For each chromosome in each bigwig-to-histogram file, deduct the number of reads from the maximum
   value for the number of reads, so we can find valleys by peak calling. Add as a new column to 
   bigwig-to-histogram files by activating the venv and running the following command:

   . ./venv/bin/activate;./scripts/add_peak_column.sh;

   This shell script creates a "_peak.bed" file for each tabular file in ./input folder

5. Do MACS2 peak calling by running the following command:

   ./scripts/run_peak_caller.sh <EXTSIZE>

   Must pass "extsize" input parameter needed by MACS2. For each .bed file, this generates a folder in
   ./output folder (e.g., for "ATCC_0mM_S1_R1_001_peak.bed" and extsize 25 it creates a
   "./output/ATCC_0mM_S1_R1_001/extsize_25" folder). In each folder, 3 files are created. E.g., in
   "./output/ATCC_0mM_S1_R1_001/extsize_25" folder, the following files are created:

   ATCC_0mM_S1_R1_001_peaks.xls: a tabular file which contains information about called peaks
   ATCC_0mM_S1_R1_001_peaks.narrowPeak: contains the peak locations together with peak summit, p-value, and q-value
   ATCC_0mM_S1_R1_001_summits.bed: contains the peak summits locations for every peak

   Run run_peak_caller.sh with <EXTSIZE> set to 25, 35, 50, 75, 100, 150, and 200.

6. ATCC_0mM_S1_R1_001_peaks.xls file contains information about called peaks for all chromosomes. Save the summit
   information for each chromosome by running the following command:

   ./scripts/split_peaks_file.sh <EXTSIZE>

   This shell script calls ./scripts/split_peaks_file.py for each "_peaks.xls" file, and generates 24 files
   (chromosomes 1 to 22, X and Y), in the same folder as the "_peaks.xls" file.

   Run split_peaks_file.sh with <EXTSIZE> set to 25, 35, 50, 75, 100, 150, and 200.

7. For each chromosome, find the intersection between chromosome peaks and chromosome non-b DNA annotations,
   by running thefollowing command:

   ./scripts/intersect_peaks.sh <PeaksFolder> <NonBDNAFolder>

   This shell script creates a "_intersect.bed" file for each chromosome in the same folder as the peaks file.
   <PeaksFolder> parameter value is "./output". <NonBDNAFolder> parameter value is:

   /Users/kxk302/workspace/Quadron_Docker/output/hg19/nBMST_plus_Quadron

   The shell script finds the intersect in <EXTSIZE> folders 25, 35, 50, 75, 100, 150, and 200.

8. For each chromosome, summarize the intersect files by dividing the sum of the length of intersect intervals
   by the sum of the length of peak intervals, by running the following command:

   ./scripts/summarize_intersect.sh <PeaksFolder> <EXTSIZE>

   <PeaksFolder> parameter value is "./output". This shell scripts calls ./scripts/summarize_intersect.py for
   each folder. For each chromosome, it divides the sum of peaks/non-B DNA intersect lengths by the sum of peaks
   lengths, and writes them to a "peaks_summary.txt" file in the same folder. The last line of the txt file
   calculates the harmonic mean of the ratios for all chromosomes.
