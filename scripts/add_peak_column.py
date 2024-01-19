import argparse
import os
import pathlib

import pandas as pd


def add_peak_column(input_folder, output_folder):
  files = os.listdir(input_folder)
  for file in files:
    file_path = os.path.join(input_folder, file)
    file_name = pathlib.Path(file_path).stem
    file_extension = pathlib.Path(file_path).suffix
    
    # Ignore any directories. We only process files in input_folder
    if not os.path.isfile(file_path):
      continue

    # Ignore any file that is NOT .tabular
    if file_extension != ".tabular":
      continue

    print(f"{file_path} is a file")

    df = pd.read_csv(file_path, sep="\t", names=["chromosome", "start", "stop", "number_of_reads"])

    df_max_number_of_read = pd.DataFrame(df.groupby(["chromosome"])["number_of_reads"].max())
    df_max_number_of_read.rename(columns={'number_of_reads': 'max_number_of_reads'}, inplace=True)
    
    print(df_max_number_of_read.head(20))

    df_merged = pd.merge(df, df_max_number_of_read, on="chromosome", how="inner")
    df_merged["peak_number_of_reads"] = df_merged["max_number_of_reads"] - df_merged["number_of_reads"]
    print(df_merged.head(20))

    df_merged.to_csv(os.path.join(output_folder, file_name + "_peak.bed"), sep="\t",
                     columns=["chromosome", "start", "stop", "peak_number_of_reads"],
                     header=False, index=False)


if __name__ == "__main__":
  argParse = argparse.ArgumentParser("For each chromosome, deduct the number of reads from the maximum value of\
                                      the number of reads, so we can find valleys by peak calling")

  argParse.add_argument("-i", "--input_folder", type=str, required=True)
  argParse.add_argument("-o", "--output_folder", type=str, required=True)

  args = argParse.parse_args()

  add_peak_column(args.input_folder, args.output_folder)
