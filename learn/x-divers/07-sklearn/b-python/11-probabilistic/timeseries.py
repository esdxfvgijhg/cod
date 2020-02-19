#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd


def read_data(input_file, index):
    input_data = np.loadtxt(input_file, delimiter=",")  # Read the data from the input file
    to_date = lambda x, y: str(int(x)) + "-" + str(int(y))  # Lambda function to convert strings to Pandas date format
    start = to_date(input_data[0, 0], input_data[0, 1])  # Extract the start date
    if input_data[-1, 1] == 12:  # Extract the end date
        year = input_data[-1, 0] + 1
        month = 1
    else:
        year = input_data[-1, 0]
        month = input_data[-1, 1] + 1
    end = to_date(year, month)
    date_indices = pd.date_range(start, end, freq="M")  # Create a date list with a monthly frequency
    output = pd.Series(input_data[:, index], index=date_indices)  # Add timestamps to the input data to create time-series data
    return output


if __name__ == "__main__":
    input_file = "data_2D.txt"  # Input filename
    indices = [2, 3]  # into time-series data # Specify the columns that need to be converted
    for index in indices:  # Iterate through the columns and plot the data
        timeseries = read_data(input_file, index)  # Convert the column to timeseries format
        plt.figure()  # Plot the data
        timeseries.plot()
        plt.title("Dimension " + str(index - 1))
    plt.show()
