import argparse
from pathlib import Path

import pandas as pd


def aggregate_intersect_summaries(input_folder, extsize_list, output_file, random_subfolder):
  input_folder_path = Path(input_folder)

  columns = ["Sample_Name", "Window_Size", "Harmonic_Mean"]
  rows = []

  # For each folder in input_folder, and for each extsize subfolder
  # Open the "peaks_summary.txt" file and read the intersect ratio
  # harmonic mean from the last line of the file

  for ff in input_folder_path.glob("./*"):
    if not ff.is_dir():
      continue

    # Skip 'random' folder
    if ff.name.endswith('random'):
      continue

    for extsize in extsize_list:
      subfolder = "extsize_" + str(extsize)
      if random_subfolder is None:
        report_file = ff / subfolder / "peaks_summary.txt"
      else:
        report_file = ff / subfolder / random_subfolder / "peaks_summary.txt"
      print(f"report_file: {report_file}")
      with open(report_file, "r") as fp:
        for line in fp:
          continue
        last_line = line.strip()
        harmonic_mean = last_line.split(":")[1].strip()
        rows.append([ff.parts[1], extsize, harmonic_mean])

  df=pd.DataFrame(rows, columns=columns)
  df.sort_values(by=columns[2], ascending=False, inplace=True)
  df.to_csv(output_file, index=False, sep="\t")


if __name__=="__main__":
  argParse = argparse.ArgumentParser("Aggregate repeats intersect with non-B DNA reports")

  argParse.add_argument("-i", "--input_folder", type=str, required=True)
  argParse.add_argument("-e", "--extsize", nargs="+", required=True)
  argParse.add_argument("-o", "--output_file", type=str, required=True)
  argParse.add_argument("-r", "--random_subfolder", type=str, required=False)

  args = argParse.parse_args()
  aggregate_intersect_summaries(args.input_folder, args.extsize, args.output_file, args.random_subfolder)
