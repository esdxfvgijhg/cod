#!/usr/bin/python
import cv2
import numpy as np

face_cascade = cv2.CascadeClassifier("cascade_files/haarcascade_frontalface_alt.xml")  # Load face, eye, and nose cascade files
eye_cascade = cv2.CascadeClassifier("cascade_files/haarcascade_eye.xml")
nose_cascade = cv2.CascadeClassifier("cascade_files/haarcascade_mcs_nose.xml")
if face_cascade.empty():  # Check if face cascade file has been loaded
    raise IOError("Unable to load the face cascade classifier xml file")
if eye_cascade.empty():  # Check if eye cascade file has been loaded
    raise IOError("Unable to load the eye cascade classifier xml file")
if nose_cascade.empty():  # Check if nose cascade file has been loaded
    raise IOError("Unable to load the nose cascade classifier xml file")
cap = cv2.VideoCapture(0)  # Initialize video capture object and define scaling factor
scaling_factor = 0.5
while True:
    ret, frame = cap.read()  # Read current frame, resize it, and convert it to grayscale
    frame = cv2.resize(frame, None, fx=scaling_factor, fy=scaling_factor, interpolation=cv2.INTER_AREA)
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, 1.3, 5)  # Run face detector on the grayscale image
    for (x, y, w, h) in faces:  # Run eye and nose detectors within each face rectangle
        roi_gray = gray[y : y + h, x : x + w]  # Grab the current ROI in both color and grayscale images
        roi_color = frame[y : y + h, x : x + w]
        eye_rects = eye_cascade.detectMultiScale(roi_gray)  # Run eye detector in the grayscale ROI
        nose_rects = nose_cascade.detectMultiScale(roi_gray, 1.3, 5)  # Run nose detector in the grayscale ROI
        for (x_eye, y_eye, w_eye, h_eye) in eye_rects:  # Draw green circles around the eyes
            center = (int(x_eye + 0.5 * w_eye), int(y_eye + 0.5 * h_eye))
            radius = int(0.3 * (w_eye + h_eye))
            color = (0, 255, 0)
            thickness = 3
            cv2.circle(roi_color, center, radius, color, thickness)
        for (x_nose, y_nose, w_nose, h_nose) in nose_rects:
            cv2.rectangle(roi_color, (x_nose, y_nose), (x_nose + w_nose, y_nose + h_nose), (0, 255, 0), 3)
            break
    cv2.imshow("Eye and nose detector", frame)  # Display the image
    c = cv2.waitKey(1)  # Check if Esc key has been pressed
    if c == 27:
        break
cap.release()  # Release video capture object and close all windows
cv2.destroyAllWindows()
