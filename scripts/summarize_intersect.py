import argparse
import os
import statistics
from os import path

import pandas as pd


def summarize_peaks_intersect(peaks_folder, output_folder):

  with open(path.join(output_folder, "peaks_summary.txt"), "w") as fp:

    fp.write("\t".join(["chromosome", "peaks_length", "non_b_dna_intersect_length", "non_b_dna_intersect_ratio"]) + "\n")
    non_b_dna_intersect_ratio_list = []

    for idx in range(1,23,1):
      chromosome = "chr"+str(idx)
      peaks_file_path = path.join(peaks_folder, chromosome+".bed")
      if not os.path.isfile(peaks_file_path):
        continue
      df = pd.read_csv(peaks_file_path, sep="\t", usecols=[0,1,2], names=["chromosome", "start", "stop"])
      df["length"] = df["stop"] - df["start"] + 1 
      peaks_length = df["length"].sum()

      non_b_dna_intersect_file_path = path.join(peaks_folder, chromosome+"_intersect.bed")
      df = pd.read_csv(non_b_dna_intersect_file_path, sep="\t", usecols=[0,1,2], names=["chromosome", "start", "stop"])
      df["length"] = df["stop"] - df["start"] + 1 
      non_b_dna_intersect_length = df["length"].sum()

      non_b_dna_intersect_ratio = non_b_dna_intersect_length / peaks_length
      non_b_dna_intersect_ratio_list.append(non_b_dna_intersect_ratio)
      fp.write("\t".join([chromosome, str(peaks_length), str(non_b_dna_intersect_length), str(non_b_dna_intersect_ratio)]) + "\n")

    for idx in ["X", "Y"]:
      chromosome = "chr"+idx
      peaks_file_path = path.join(peaks_folder, chromosome+".bed")
      if not os.path.isfile(peaks_file_path):
        continue
      df = pd.read_csv(peaks_file_path, sep="\t", usecols=[0,1,2], names=["chromosome", "start", "stop"])
      df["length"] = df["stop"] - df["start"] + 1 
      peaks_length = df["length"].sum()

      non_b_dna_intersect_file_path = path.join(peaks_folder, chromosome+"_intersect.bed")
      df = pd.read_csv(non_b_dna_intersect_file_path, sep="\t", usecols=[0,1,2], names=["chromosome", "start", "stop"])
      df["length"] = df["stop"] - df["start"] + 1 
      non_b_dna_intersect_length = df["length"].sum()

      non_b_dna_intersect_ratio = non_b_dna_intersect_length / peaks_length
      non_b_dna_intersect_ratio_list.append(non_b_dna_intersect_ratio)
      fp.write("\t".join([chromosome, str(peaks_length), str(non_b_dna_intersect_length), str(non_b_dna_intersect_ratio)]) + "\n")

    fp.write("Harmonic mean of intersect ratio: " + str(statistics.harmonic_mean(non_b_dna_intersect_ratio_list)) + "\n")


if __name__ == "__main__":
  argParse = argparse.ArgumentParser("Divide the sum of peaks/non-B DNA intersect lengths by the sum of peaks lengths for each chromosome")

  argParse.add_argument("-i", "--peaks_folder", type=str, required=True)
  argParse.add_argument("-o", "--output_folder", type=str, required=True)

  args = argParse.parse_args()

  summarize_peaks_intersect(args.peaks_folder, args.output_folder)