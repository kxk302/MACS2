import argparse
from matplotlib import pyplot as plt
from pathlib import Path

import cv2


def group_plots(input_folder, output_file):

  plot_path = Path(input_folder)
  plot_names = list(plot_path.glob("./*.png"))

  image_list = []
  for plot_name in plot_names:
    image_list.append(cv2.imread(str(plot_name)))

  # create figure 
  fig = plt.figure(figsize=(25, 15)) 
  
  # setting values to rows and column variables 
  rows = 3
  columns = 2

  for idx in range(rows*columns):
    
    # Adds a subplot at the 1st position 
    ax1 = fig.add_subplot(rows, columns, idx+1)
    ax1.set_aspect("equal")
  
    # showing image 
    plt.imshow(image_list[idx]) 
    plt.axis('off')

  plt.subplots_adjust(wspace=0, hspace=0)
  plt.show()


if __name__ == "__main__":

  argParse = argparse.ArgumentParser("Group bar plot for non-B DNA intersect ratio of "
                                     "samples and non-B DNA intersct ratio of random "
                                     "intervals with the same window size")
  argParse.add_argument("-i", "--input_folder", type=str, required=True)
  argParse.add_argument("-o", "--output_file", type=str, required=True)

  args = argParse.parse_args()
  group_plots(args.input_folder, args.output_file)
