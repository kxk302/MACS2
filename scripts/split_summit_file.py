import argparse
import os
from os import path

import pandas as pd


def split_summit_file(input_file, output_folder):
  df=pd.read_csv(input_file, sep="\t", comment="#")

  for idx in range(1,23,1):
    print(f"idx: {idx}")
    df_split = df[df.chr == "chr"+str(idx)]
    if df_split.shape[0] > 0:
      df_split.to_csv(path.join(output_folder, "chr"+str(idx)+".bed"), sep="\t", header=False, index=False)

  for idx in ["X", "Y"]:
    print(f"idx: {idx}")
    df_split = df[df.chr == "chr"+idx]
    if df_split.shape[0] > 0:
      df_split.to_csv(path.join(output_folder, "chr"+idx+".bed"), sep="\t", header=False, index=False)


if __name__ == "__main__":
  argParse = argparse.ArgumentParser("Split MACS summit file based on chromosome name")

  argParse.add_argument("-i", "--input_file", type=str, required=True)
  argParse.add_argument("-o", "--output_folder", type=str, required=True)

  args = argParse.parse_args()

  split_summit_file(args.input_file, args.output_folder)
