#!/usr/bin/python
import cv2
import numpy as np


class ObjectTracker(object):  # Define a class to handle object tracking related functionality
    def __init__(self, scaling_factor=0.5):
        self.cap = cv2.VideoCapture(0)  # Initialize the video capture object
        _, self.frame = self.cap.read()  # Capture the frame from the webcam
        self.scaling_factor = scaling_factor  # Scaling factor for the captured frame
        self.frame = cv2.resize(self.frame, None, fx=self.scaling_factor, fy=self.scaling_factor, interpolation=cv2.INTER_AREA)  # Resize the frame
        cv2.namedWindow("Object Tracker")  # Create a window to display the frame
        cv2.setMouseCallback("Object Tracker", self.mouse_event)  # Set the mouse callback function to track the mouse
        self.selection = None  # Initialize variable related to rectangular region selection
        self.drag_start = None  # Initialize variable related to starting position
        self.tracking_state = 0  # Initialize variable related to the state of tracking

    def mouse_event(self, event, x, y, flags, param):  # Define a method to track the mouse events
        x, y = np.int16([x, y])  # Convert x and y coordinates into 16-bit numpy integers
        if event == cv2.EVENT_LBUTTONDOWN:  # Check if a mouse button down event has occurred
            self.drag_start = (x, y)
            self.tracking_state = 0
        if self.drag_start:  # Check if the user has started selecting the region
            if flags & cv2.EVENT_FLAG_LBUTTON:
                h, w = self.frame.shape[:2]  # Extract the dimensions of the frame
                xi, yi = self.drag_start  # Get the initial position
                x0, y0 = np.maximum(0, np.minimum([xi, yi], [x, y]))  # Get the max and min values
                x1, y1 = np.minimum([w, h], np.maximum([xi, yi], [x, y]))
                self.selection = None  # Reset the selection variable
                if x1 - x0 > 0 and y1 - y0 > 0:  # Finalize the rectangular selection
                    self.selection = (x0, y0, x1, y1)
            else:
                self.drag_start = None  # If the selection is done, start tracking
                if self.selection is not None:
                    self.tracking_state = 1

    def start_tracking(self):  # Method to start tracking the object
        while True:  # Iterate until the user presses the Esc key
            _, self.frame = self.cap.read()  # Capture the frame from webcam
            self.frame = cv2.resize(self.frame, None, fx=self.scaling_factor, fy=self.scaling_factor, interpolation=cv2.INTER_AREA)  # Resize the input frame
            vis = self.frame.copy()  # Create a copy of the frame
            hsv = cv2.cvtColor(self.frame, cv2.COLOR_BGR2HSV)  # Convert the frame to HSV colorspace
            mask = cv2.inRange(hsv, np.array((0.0, 60.0, 32.0)), np.array((180.0, 255.0, 255.0)))  # Create the mask based on predefined thresholds
            if self.selection:  # Check if the user has selected the region
                x0, y0, x1, y1 = self.selection  # Extract the coordinates of the selected rectangle
                self.track_window = (x0, y0, x1 - x0, y1 - y0)  # Extract the tracking window
                hsv_roi = hsv[y0:y1, x0:x1]  # Extract the regions of interest
                mask_roi = mask[y0:y1, x0:x1]
                hist = cv2.calcHist([hsv_roi], [0], mask_roi, [16], [0, 180])  # interest in the HSV image using the mask # Compute the histogram of the region of
                cv2.normalize(hist, hist, 0, 255, cv2.NORM_MINMAX)  # Normalize and reshape the histogram
                self.hist = hist.reshape(-1)
                vis_roi = vis[y0:y1, x0:x1]  # Extract the region of interest from the frame
                cv2.bitwise_not(vis_roi, vis_roi)  # Compute the image negative (for display only)
                vis[mask == 0] = 0
            if self.tracking_state == 1:  # Check if the system in the "tracking" mode
                self.selection = None  # Reset the selection variable
                hsv_backproj = cv2.calcBackProject([hsv], [0], self.hist, [0, 180], 1)  # Compute the histogram back projection
                hsv_backproj &= mask  # backprojection and the mask # Compute bitwise AND between histogram
                term_crit = (cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_COUNT, 10, 1)  # Define termination criteria for the tracker
                track_box, self.track_window = cv2.CamShift(hsv_backproj, self.track_window, term_crit)  # Apply CAMShift on 'hsv_backproj'
                cv2.ellipse(vis, track_box, (0, 255, 0), 2)  # Draw an ellipse around the object
            cv2.imshow("Object Tracker", vis)  # Show the output live video
            c = cv2.waitKey(5)  # Stop if the user hits the 'Esc' key
            if c == 27:
                break
        cv2.destroyAllWindows()  # Close all the windows


if __name__ == "__main__":
    ObjectTracker().start_tracking()  # Start the tracker
