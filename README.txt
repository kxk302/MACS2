1. There are the following 5 files for PDAL-seq experiment:

   20mM_A_S2_R1_001.fasta.gz
   20mM_A_try25_S6_R1_001.fasta.gz
   20mM_B_S3_R1_001.fasta.gz
   40mM_A_S4_R1_001.fasta.gz
   40mM_B_S5_R1_001.fasta.gz

2. There are the following Galaxy histories, one for each fasta file. Each file is mapped to hg19
   using BWA-MEM (Creates a .bam file), the .bam file is filtered based on mapping quality >= 30
   (Creates another .bam file ), .bam file's intervals that intersect with a black listed region 
   are removed, .bam file is converted to .bigwig, and .bigwig is converted to histogram format.
     

   https://usegalaxy.eu/u/kaivan/h/20mmas2r1001
   https://usegalaxy.eu/u/kaivan/h/20mmatry25s6r1001
   https://usegalaxy.eu/u/kaivan/h/20mmbs3r1001
   https://usegalaxy.eu/u/kaivan/h/40mmas4r1001
   https://usegalaxy.eu/u/kaivan/h/40mmbs5r1001

3. Download bigwig-to-histogram files from Galaxy histories into ./input folder:

   20mM_A_S2_R1_001_BigWigs_as_Histogram.tabular
   20mM_A_try25_S6_R1_001_BigWigs_as_Histogram.tabular
   20mM_B_S3_R1_001_bigWigs_as_Histogram.tabular
   40mM_A_S4_R1_001_BigWigs_as_Histogram.tabular
   40mM_B_S5_R1_001_bigWigs_as_Histogram.tabular

4. For each chromosome in each bigwig-to-histogram file, deduct the number of reads from the maximum 
   value for the number of reads, so we can find valleys by peak calling. Add as a new column to 
   bigwig-to-histogram files by activating the venv and running the following command:

   . ./venv/bin/activate;./scripts/add_peak_column.sh;

   This generates the following 5 bed files:
  
   20mM_A_S2_R1_001_BigWigs_as_Histogram_peak.bed
   20mM_A_try25_S6_R1_001_BigWigs_as_Histogram_peak.bed
   20mM_B_S3_R1_001_bigWigs_as_Histogram_peak.bed
   40mM_A_S4_R1_001_BigWigs_as_Histogram_peak.bed
   40mM_B_S5_R1_001_bigWigs_as_Histogram_peak.bed

5. Do MACS2 peak calling by running the following command:

   ./scripts/run_peak_caller.sh <EXTSIZE>

   Must pass "extsize" input parameter needed by MACS2. For each .bed file, this generates a folder in
   ./output folder (e.g., for "20mM_A_S2_R1_001_BigWigs_as_Histogram_peak.bed" it creates a
   "./output/20mM_A_S2_R1_001/<EXTSIZE>" folder). In each folder, 3 files are created. E.g., in
   "./output/20mM_A_S2_R1_001/<EXTSIZE>" folder, the following files are created:

   20mM_A_S2_R1_001_peaks.xls: a tabular file which contains information about called peaks
   20mM_A_S2_R1_001_peaks.narrowPeak: contains the peak locations together with peak summit, p-value, and q-value
   20mM_A_S2_R1_001_summits.bed: contains the peak summits locations for every peak

6. 20mM_A_S2_R1_001_peaks.xls file contains information about called peaks for all chromosomes. Split the .xls file
   for each chromosome by running the following command:

   ./scripts/split_peaks_file.sh <EXTSIZE>

   This shell script calls ./scripts/split_peaks_file.py for each .xls file, and generates 24 files
   (chromosomes 1 to 22, X and Y), in the same folder as the .xls file.

7. For each chromosome, find the intersection between chromosome peaks and chromosome non-b DNA annotations,
   by running thefollowing command:

   ./scripts/intersect_peaks.sh <PeaksFolder> <NonBDNAFolder> <EXTSIZE>

   This shell script creates a "_intersect.bed" file for each chromosome in the same folder as the .xls file.
   <PeaksFolder> parameter value is "./output". <NonBDNAFolder> parameter value is:

   /Users/kxk302/workspace/Quadron_Docker/output/hg19/nBMST_plus_Quadron

8. For each chromosome, summarize the intersect files by dividing the sum of the length of intersect intervals
   by the sum of the length of peak intervals, by running the following command:

   ./scripts/summarize_intersect.sh <PeaksFolder> <EXTSIZE>

   <PeaksFolder> parameter value is "./output". This shell scripts calls ./scripts/summarize_intersect.py for
   each folder. For each chromosome, it divides the sum of peaks/non-B DNA intersect lengths by the sum of peaks
   lengths, and writes them to a "peaks_summary.txt" file in the same folder. The last line of the txt file
   calculates the harmonic mean of the ratios for all chromosomes.
