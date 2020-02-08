#!/usr/bin/python
import cv2

cap = cv2.VideoCapture(0)  # Initialize video capture object
scaling_factor = 0.5  # Define the image size scaling factor
while True:  # Loop until you hit the Esc key
    ret, frame = cap.read()  # Capture the current frame
    frame = cv2.resize(frame, None, fx=scaling_factor, fy=scaling_factor, interpolation=cv2.INTER_AREA)  # Resize the frame
    cv2.imshow("Webcam", frame)  # Display the image
    c = cv2.waitKey(1)  # Detect if the Esc key has been pressed
    if c == 27:
        break
cap.release()  # Release the video capture object
cv2.destroyAllWindows()  # Close all active windows
