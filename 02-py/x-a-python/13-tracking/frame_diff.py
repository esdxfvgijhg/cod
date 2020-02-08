#!/usr/bin/python
import cv2


def frame_diff(prev_frame, cur_frame, next_frame):  # Compute the frame differences
    diff_frames_1 = cv2.absdiff(next_frame, cur_frame)  # Difference between the current frame and the next frame
    diff_frames_2 = cv2.absdiff(cur_frame, prev_frame)  # Difference between the current frame and the previous frame
    return cv2.bitwise_and(diff_frames_1, diff_frames_2)


def get_frame(cap, scaling_factor):  # Define a function to get the current frame from the webcam
    _, frame = cap.read()  # Read the current frame from the video capture object
    frame = cv2.resize(frame, None, fx=scaling_factor, fy=scaling_factor, interpolation=cv2.INTER_AREA)  # Resize the image
    gray = cv2.cvtColor(frame, cv2.COLOR_RGB2GRAY)  # Convert to grayscale
    return gray


if __name__ == "__main__":
    cap = cv2.VideoCapture(0)  # Define the video capture object
    scaling_factor = 0.5  # Define the scaling factor for the images
    prev_frame = get_frame(cap, scaling_factor)  # Grab the current frame
    cur_frame = get_frame(cap, scaling_factor)  # Grab the next frame
    next_frame = get_frame(cap, scaling_factor)  # Grab the frame after that
    while True:  # until the user hits the 'Esc' key # Keep reading the frames from the webcam
        cv2.imshow("Object Movement", frame_diff(prev_frame, cur_frame, next_frame))  # Display the frame difference
        prev_frame = cur_frame  # Update the variables
        cur_frame = next_frame
        next_frame = get_frame(cap, scaling_factor)  # Grab the next frame
        key = cv2.waitKey(10)  # Check if the user hit the 'Esc' key
        if key == 27:
            break
    cv2.destroyAllWindows()  # Close all the windows
