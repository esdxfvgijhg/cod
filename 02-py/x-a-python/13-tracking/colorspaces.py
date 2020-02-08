#!/usr/bin/python
import cv2
import numpy as np


def get_frame(cap, scaling_factor):  # Define a function to get the current frame from the webcam
    _, frame = cap.read()  # Read the current frame from the video capture object
    frame = cv2.resize(frame, None, fx=scaling_factor, fy=scaling_factor, interpolation=cv2.INTER_AREA)  # Resize the image
    return frame


if __name__ == "__main__":
    cap = cv2.VideoCapture(0)  # Define the video capture object
    scaling_factor = 0.5  # Define the scaling factor for the images
    while True:  # until the user hits the 'Esc' key # Keep reading the frames from the webcam
        frame = get_frame(cap, scaling_factor)  # Grab the current frame
        hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)  # Convert the image to HSV colorspace
        lower = np.array([0, 70, 60])  # Define range of skin color in HSV
        upper = np.array([50, 150, 255])
        mask = cv2.inRange(hsv, lower, upper)  # Threshold the HSV image to get only skin color
        img_bitwise_and = cv2.bitwise_and(frame, frame, mask=mask)  # Bitwise-AND between the mask and original image
        img_median_blurred = cv2.medianBlur(img_bitwise_and, 5)  # Run median blurring
        cv2.imshow("Input", frame)  # Display the input and output
        cv2.imshow("Output", img_median_blurred)
        c = cv2.waitKey(5)  # Check if the user hit the 'Esc' key
        if c == 27:
            break
    cv2.destroyAllWindows()  # Close all the windows
