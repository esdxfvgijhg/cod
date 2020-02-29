#!/usr/bin/python
import cv2
import numpy as np

face_cascade = cv2.CascadeClassifier("haar_cascade_files/haarcascade_frontalface_default.xml")  # Load the Haar cascade file
if face_cascade.empty():  # Check if the cascade file has been loaded correctly
    raise IOError("Unable to load the face cascade classifier xml file")
cap = cv2.VideoCapture(0)  # Initialize the video capture object
scaling_factor = 0.5  # Define the scaling factor
while True:  # Iterate until the user hits the 'Esc' key
    _, frame = cap.read()  # Capture the current frame
    frame = cv2.resize(frame, None, fx=scaling_factor, fy=scaling_factor, interpolation=cv2.INTER_AREA)  # Resize the frame
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)  # Convert to grayscale
    face_rects = face_cascade.detectMultiScale(gray, 1.3, 5)  # Run the face detector on the grayscale image
    for (x, y, w, h) in face_rects:  # Draw a rectangle around the face
        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 3)
    cv2.imshow("Face Detector", frame)  # Display the output
    c = cv2.waitKey(1)  # Check if the user hit the 'Esc' key
    if c == 27:
        break
cap.release()  # Release the video capture object
cv2.destroyAllWindows()  # Close all the windows
