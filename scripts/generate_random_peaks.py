import argparse
import subprocess
from os import path
from pathlib import Path

import pandas as pd

def generate_random_peaks(input_file, genome_file, window_size, random_seed):
  df = pd.read_csv(input_file, sep="\t", comment="#")

  print(df.shape[0])
  print(df.head())

  number_of_peaks = df.shape[0]

  input_file_path = Path(input_file)
  input_file_name = input_file_path.stem
  input_file_folder = input_file_path.parent
  output_file = path.join(input_file_folder, input_file_name + "_random.bed")

  command = "bedtools random -l " + str(window_size) + " -n " + str(number_of_peaks) + " -seed " + str(random_seed) + " -g "  + genome_file
  print(f"command: {command}")

  fp = open(output_file, "w")
  process = subprocess.Popen(command.split(), stdout=fp)
  output, error = process.communicate()
  print(f"output: {output}")
  print(f"error: {error}")


if __name__=="__main__":
  argParse = argparse.ArgumentParser("Generat random peaks, with specific widths, for each chromosome to evaluate MACS peaks")

  argParse.add_argument("-i", "--input_file", type=str, required=True)
  argParse.add_argument("-w", "--window_size", type=int, required=True, choices=[25, 35, 50, 75, 100, 150, 200])
  argParse.add_argument("-g", "--genome_file", type=str, required=True)
  argParse.add_argument("-s", "--random_seed", type=int, required=True)

  args = argParse.parse_args()

  generate_random_peaks(args.input_file, args.genome_file, args.window_size, args.random_seed)
