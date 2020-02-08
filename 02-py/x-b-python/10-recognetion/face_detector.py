#!/usr/bin/python
import cv2
import numpy as np

face_cascade = cv2.CascadeClassifier("cascade_files/haarcascade_frontalface_alt.xml")  # Load the face cascade file
if face_cascade.empty():  # Check if the face cascade file has been loaded
    raise IOError("Unable to load the face cascade classifier xml file")
cap = cv2.VideoCapture(0)  # Initialize the video capture object
scaling_factor = 0.5  # Define the scaling factor
while True:  # Loop until you hit the Esc key
    ret, frame = cap.read()  # Capture the current frame and resize it
    frame = cv2.resize(frame, None, fx=scaling_factor, fy=scaling_factor, interpolation=cv2.INTER_AREA)
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)  # Convert to grayscale
    face_rects = face_cascade.detectMultiScale(gray, 1.3, 5)  # Run the face detector on the grayscale image
    for (x, y, w, h) in face_rects:  # Draw rectangles on the image
        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 3)
    cv2.imshow("Face Detector", frame)  # Display the image
    c = cv2.waitKey(1)  # Check if Esc key has been pressed
    if c == 27:
        break
cap.release()  # Release the video capture object and close all windows
cv2.destroyAllWindows()
