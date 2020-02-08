#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation


def tracker(cur_num):
    cur_index = cur_num % num_points  # Get the current index
    datapoints["color"][:, 3] = 1.0  # Set the color of the datapoints
    datapoints["size"] += datapoints["growth"]  # Update the size of the circles
    datapoints["position"][cur_index] = np.random.uniform(0, 1, 2)  # Update the position of the oldest datapoint
    datapoints["size"][cur_index] = 7
    datapoints["color"][cur_index] = (0, 0, 0, 1)
    datapoints["growth"][cur_index] = np.random.uniform(40, 150)
    scatter_plot.set_edgecolors(datapoints["color"])  # Update the parameters of the scatter plot
    scatter_plot.set_sizes(datapoints["size"])
    scatter_plot.set_offsets(datapoints["position"])


if __name__ == "__main__":
    fig = plt.figure(figsize=(9, 7), facecolor=(0, 0.9, 0.9))  # Create a figure
    ax = fig.add_axes([0, 0, 1, 1], frameon=False)
    ax.set_xlim(0, 1), ax.set_xticks([])
    ax.set_ylim(0, 1), ax.set_yticks([])
    # and with random growth rates. # Create and initialize the datapoints in random positions
    num_points = 20
    datapoints = np.zeros(num_points, dtype=[("position", float, 2), ("size", float, 1), ("growth", float, 1), ("color", float, 4)])
    datapoints["position"] = np.random.uniform(0, 1, (num_points, 2))
    datapoints["growth"] = np.random.uniform(40, 150, num_points)
    scatter_plot = ax.scatter(datapoints["position"][:, 0], datapoints["position"][:, 1], s=datapoints["size"], lw=0.7, edgecolors=datapoints["color"], facecolors="none")  # Construct the scatter plot that will be updated every frame
    animation = FuncAnimation(fig, tracker, interval=10)  # Start the animation using the 'tracker' function
    plt.show()
