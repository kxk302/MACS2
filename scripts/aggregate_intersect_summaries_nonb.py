import argparse
import os
from pathlib import Path

import pandas as pd


def aggregate_intersect_reports_nonb(input_folder, extsize_list, output_file, non_b_dna):
  input_folder_path = Path(input_folder)

  columns = ["Sample_Name", "Window_Size", "Harmonic_Mean"]
  rows = []

  # For each folder in input_folder, and for each extsize subfolder
  # Open the "peaks_summary.txt" file and read the intersect ratio
  # harmonic mean from the last line of the file

  for ff in input_folder_path.glob("./*"):
    if not ff.is_dir():
      continue

    for extsize in extsize_list:
      subfolder = "extsize_" + str(extsize)
      summary_file_name = "peaks_summary_" + non_b_dna + ".txt"
      report_file = ff / subfolder / summary_file_name
      print(f"report_file: {report_file}")
      if not os.path.isfile(report_file):
        continue
      with open(report_file, "r") as fp:
        for line in fp:
          continue
        last_line = line.strip()
        # Handle empty files. They only have headers, and 
        # the first header is 'chromosome'
        if last_line.startswith('chromosome'):
          continue  
        harmonic_mean = last_line.split(":")[1].strip()
        rows.append([ff.parts[1], extsize, harmonic_mean])

  df=pd.DataFrame(rows, columns=columns)
  df.sort_values(by=columns[2], ascending=False, inplace=True)
  df.to_csv(output_file, index=False, sep="\t")


if __name__=="__main__":
  argParse = argparse.ArgumentParser("Aggregate repeats intersect with non-B DNA reports")

  argParse.add_argument("-i", "--input_folder", type=str, required=True)
  argParse.add_argument("-e", "--extsize", nargs="+", required=True)
  argParse.add_argument("-n", "--non_b_dna", type=str, required=True,
                        choices=["DR", "GQ", "IR", "MR", "STR"])
  argParse.add_argument("-o", "--output_file", type=str, required=True)

  args = argParse.parse_args()
  aggregate_intersect_reports_nonb(args.input_folder, args.extsize, 
                                   args.output_file, args.non_b_dna)
