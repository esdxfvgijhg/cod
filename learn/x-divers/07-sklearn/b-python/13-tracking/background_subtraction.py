#!/usr/bin/python
import cv2
import numpy as np


def get_frame(cap, scaling_factor):  # Define a function to get the current frame from the webcam
    _, frame = cap.read()  # Read the current frame from the video capture object
    frame = cv2.resize(frame, None, fx=scaling_factor, fy=scaling_factor, interpolation=cv2.INTER_AREA)  # Resize the image
    return frame


if __name__ == "__main__":
    cap = cv2.VideoCapture(0)  # Define the video capture object
    bg_subtractor = cv2.createBackgroundSubtractorMOG2()  # Define the background subtractor object
    # will learn about the background. Higher value for # The learning rate refers to the rate at which your model # This factor controls the learning rate of the algorithm. # Define the number of previous frames to use to learn.
    history = 100  # play with this parameter to see how it affects the output. # ‘history’ indicates a slower learning rate. You can
    learning_rate = 1.0 / history  # Define the learning rate
    while True:  # until the user hits the 'Esc' key # Keep reading the frames from the webcam
        frame = get_frame(cap, 0.5)  # Grab the current frame
        mask = bg_subtractor.apply(frame, learningRate=learning_rate)  # Compute the mask
        mask = cv2.cvtColor(mask, cv2.COLOR_GRAY2BGR)  # Convert grayscale image to RGB color image
        cv2.imshow("Input", frame)  # Display the images
        cv2.imshow("Output", mask & frame)
        c = cv2.waitKey(10)  # Check if the user hit the 'Esc' key
        if c == 27:
            break
    cap.release()  # Release the video capture object
    cv2.destroyAllWindows()  # Close all the windows
