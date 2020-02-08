#!/usr/bin/python
import sys
import cv2
import numpy as np

input_file = sys.argv[1]  # Load input image -- 'sunrise.jpg'
img = cv2.imread(input_file)
img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)  # Convert it to grayscale
cv2.imshow("Input grayscale image", img_gray)
img_gray_histeq = cv2.equalizeHist(img_gray)  # Equalize the histogram
cv2.imshow("Histogram equalized - grayscale", img_gray_histeq)
img_yuv = cv2.cvtColor(img, cv2.COLOR_BGR2YUV)  # Histogram equalization of color images
img_yuv[:, :, 0] = cv2.equalizeHist(img_yuv[:, :, 0])
img_histeq = cv2.cvtColor(img_yuv, cv2.COLOR_YUV2BGR)
cv2.imshow("Input color image", img)
cv2.imshow("Histogram equalized - color", img_histeq)
cv2.waitKey()
