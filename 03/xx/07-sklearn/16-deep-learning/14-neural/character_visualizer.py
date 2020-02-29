#!/usr/bin/python
import os
import sys
import cv2
import numpy as np

input_file = "letter.data"  # Define the input file
img_resize_factor = 12  # Define the visualization parameters
start = 6
end = -1
height, width = 16, 8
with open(input_file, "r") as f:  # Iterate until the user presses the Esc key
    for line in f.readlines():
        data = np.array([255 * float(x) for x in line.split("\t")[start:end]])  # Read the data
        img = np.reshape(data, (height, width))  # Reshape the data into a 2D image
        img_scaled = cv2.resize(img, None, fx=img_resize_factor, fy=img_resize_factor)  # Scale the image
        cv2.imshow("Image", img_scaled)  # Display the image
        c = cv2.waitKey()  # Check if the user pressed the Esc key
        if c == 27:
            break
