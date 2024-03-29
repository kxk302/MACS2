import argparse
import pandas as pd
from matplotlib import pyplot as plt

import numpy as np

non_b_dna_dict = {
    "APR":"A-Phased Repeats",
    "STR": "Short Tandem Repeats",
    "DR": "Direct Repeats",
    "MR": "Mirror Repeats",
    "IR": "Inverted Repeats",
    "GQ": "G-Quadruplex",
    "Z": "Z DNA",
  }

def plot_intersect_ratio(intersect_ratio_file,
                         random_intersect_ratio_file,
                         output_file,
                         non_b_dna,
                         sample_id_file,
                         intersect_ratio_filter,
                         number_of_intersect_ratios):


  intersect_df = pd.read_csv(intersect_ratio_file, sep="\t")
  sample_id_df = pd.read_csv(sample_id_file, sep="\t")

  # Remove sample names starting with 'Undetermined'
  intersect_df = intersect_df[~intersect_df["Sample_Name"].astype(str).str.startswith("Undetermined")]

  # Remove sample names starting with 'H1299'
  intersect_df = intersect_df[~intersect_df["Sample_Name"].astype(str).str.startswith("H1299")]

  # Either filter the intersect ratio based on a filter value, or get
  # the top n rows (rows sorted ascendingly based on intersect ratio)
  if intersect_ratio_filter is not None:
    intersect_df = intersect_df[ intersect_df.Harmonic_Mean >= intersect_ratio_filter]
  if number_of_intersect_ratios is not None:
    intersect_df = intersect_df.head(number_of_intersect_ratios)

  random_df = pd.read_csv(random_intersect_ratio_file, sep="\t")

  all_df = pd.merge(intersect_df, random_df, how="inner", on=["Sample_Name", "Window_Size"])
  all_df = pd.merge(all_df, sample_id_df, how="inner", on=["Sample_Name"])

  all_df.sort_values(by=["Harmonic_Mean_x"], ascending=False, inplace=True)
  all_df.rename(columns={"Harmonic_Mean_x":"Harmonic_Mean",
                         "Harmonic_Mean_y":"Harmonic_Mean_Random"}, inplace=True)
  all_df["New_Sample_Name"] = "Sample " + all_df["ID"].astype(str) + " (win " + all_df["Window_Size"].astype(str) + ")"

  all_df.drop(columns=["Sample_Name", "Window_Size"], inplace=True)
  all_df.rename(columns={"New_Sample_Name":"Sample_Name"}, inplace=True)

  barWidth=0.1
  fig = plt.subplots(figsize =(8, 5.5))

  harmonic_mean = all_df["Harmonic_Mean"].tolist()
  harmonic_mean_radom = all_df["Harmonic_Mean_Random"].tolist()

  x1 = np.arange(all_df.shape[0])
  x2 = [x + barWidth for x in x1]

  plt.bar(x1, harmonic_mean, label="Sample")
  plt.bar(x2, harmonic_mean_radom, label="Random")

  plt.xlabel('Sample Name (Window Size)', fontweight ="bold", fontsize = 15)
  plt.ylabel('Non-B DNA Intersect Ratio', fontweight ="bold", fontsize = 15)
  plt.xticks(x1, all_df["Sample_Name"].tolist(), rotation=75, fontweight="bold", fontsize=7)

  plt.subplots_adjust(bottom=0.3)
  plt.legend()
  if non_b_dna is None:
    plt.title("All non-B DNA types", fontweight="bold", fontsize=20)
  else:
    plt.title(non_b_dna_dict[non_b_dna], fontweight="bold", fontsize=20)
  plt.savefig(output_file)


if __name__ == "__main__":

  argParse = argparse.ArgumentParser("Bar plot for non-B DNA intersect ratio of "
                                     "samples and non-B DNA intersect ratio of random "
                                     "intervals with the same window size")
  argParse.add_argument("-i", "--intersect_ratio_file", type=str, required=True)
  argParse.add_argument("-r", "--random_intersect_ratio_file", type=str, required=True)
  argParse.add_argument("-o", "--output_file", type=str, required=True)
  argParse.add_argument("-n", "--non_b_dna", type=str, required=False,
                        choices=["DR", "GQ", "IR", "MR", "STR"])
  argParse.add_argument("-d", "--sample_id_file", type=str, required=True)
  me_group=argParse.add_mutually_exclusive_group()
  me_group.add_argument("-f", "--intersect_ratio_filter", type=float, required=False)
  me_group.add_argument("-u", "--number_of_intersect_ratios", type=int, required=False)

  args = argParse.parse_args()
  plot_intersect_ratio(args.intersect_ratio_file,
                       args.random_intersect_ratio_file,
                       args.output_file,
                       args.non_b_dna,
                       args.sample_id_file,
                       args.intersect_ratio_filter,
                       args.number_of_intersect_ratios)
