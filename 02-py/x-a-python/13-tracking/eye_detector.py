#!/usr/bin/python
import cv2
import numpy as np

face_cascade = cv2.CascadeClassifier("haar_cascade_files/haarcascade_frontalface_default.xml")  # Load the Haar cascade files for face and eye
eye_cascade = cv2.CascadeClassifier("haar_cascade_files/haarcascade_eye.xml")
if face_cascade.empty():  # Check if the face cascade file has been loaded correctly
    raise IOError("Unable to load the face cascade classifier xml file")
if eye_cascade.empty():  # Check if the eye cascade file has been loaded correctly
    raise IOError("Unable to load the eye cascade classifier xml file")
cap = cv2.VideoCapture(0)  # Initialize the video capture object
ds_factor = 0.5  # Define the scaling factor
while True:  # Iterate until the user hits the 'Esc' key
    _, frame = cap.read()  # Capture the current frame
    frame = cv2.resize(frame, None, fx=ds_factor, fy=ds_factor, interpolation=cv2.INTER_AREA)  # Resize the frame
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)  # Convert to grayscale
    faces = face_cascade.detectMultiScale(gray, 1.3, 5)  # Run the face detector on the grayscale image
    for (x, y, w, h) in faces:  # For each face that's detected, run the eye detector
        roi_gray = gray[y : y + h, x : x + w]  # Extract the grayscale face ROI
        roi_color = frame[y : y + h, x : x + w]  # Extract the color face ROI
        eyes = eye_cascade.detectMultiScale(roi_gray)  # Run the eye detector on the grayscale ROI
        for (x_eye, y_eye, w_eye, h_eye) in eyes:  # Draw circles around the eyes
            center = (int(x_eye + 0.5 * w_eye), int(y_eye + 0.5 * h_eye))
            radius = int(0.3 * (w_eye + h_eye))
            color = (0, 255, 0)
            thickness = 3
            cv2.circle(roi_color, center, radius, color, thickness)
    cv2.imshow("Eye Detector", frame)  # Display the output
    c = cv2.waitKey(1)  # Check if the user hit the 'Esc' key
    if c == 27:
        break
cap.release()  # Release the video capture object
cv2.destroyAllWindows()  # Close all the windows
