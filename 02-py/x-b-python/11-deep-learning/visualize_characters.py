#!/usr/bin/python
import os
import sys
import cv2
import numpy as np

input_file = "letter.data"  # Load input data
scaling_factor = 10  # Define visualization parameters
start_index = 6
end_index = -1
h, w = 16, 8
with open(input_file, "r") as f:  # Loop until you encounter the Esc key
    for line in f.readlines():
        data = np.array([255 * float(x) for x in line.split("\t")[start_index:end_index]])
        img = np.reshape(data, (h, w))
        img_scaled = cv2.resize(img, None, fx=scaling_factor, fy=scaling_factor)
        cv2.imshow("Image", img_scaled)
        c = cv2.waitKey()
        if c == 27:
            break
