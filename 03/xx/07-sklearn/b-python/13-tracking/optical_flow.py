#!/usr/bin/python
import cv2
import numpy as np


def start_tracking():  # Define a function to track the object
    cap = cv2.VideoCapture(0)  # Initialize the video capture object
    scaling_factor = 0.5  # Define the scaling factor for the frames
    num_frames_to_track = 5  # Number of frames to track
    num_frames_jump = 2  # Skipping factor
    tracking_paths = []  # Initialize variables
    frame_index = 0
    tracking_params = dict(winSize=(11, 11), maxLevel=2, criteria=(cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_COUNT, 10, 0.03))  # Define tracking parameters
    while True:  # Iterate until the user hits the 'Esc' key
        _, frame = cap.read()  # Capture the current frame
        frame = cv2.resize(frame, None, fx=scaling_factor, fy=scaling_factor, interpolation=cv2.INTER_AREA)  # Resize the frame
        frame_gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)  # Convert to grayscale
        output_img = frame.copy()  # Create a copy of the frame
        if len(tracking_paths) > 0:
            prev_img, current_img = prev_gray, frame_gray  # Get images
            feature_points_0 = np.float32([tp[-1] for tp in tracking_paths]).reshape(-1, 1, 2)  # Organize the feature points
            feature_points_1, _, _ = cv2.calcOpticalFlowPyrLK(prev_img, current_img, feature_points_0, None, **tracking_params)  # Compute optical flow
            feature_points_0_rev, _, _ = cv2.calcOpticalFlowPyrLK(current_img, prev_img, feature_points_1, None, **tracking_params)  # Compute reverse optical flow
            diff_feature_points = abs(feature_points_0 - feature_points_0_rev).reshape(-1, 2).max(-1)  # reverse optical flow # Compute the difference between forward and
            good_points = diff_feature_points < 1  # Extract the good points
            new_tracking_paths = []  # Initialize variable
            for tp, (x, y), good_points_flag in zip(tracking_paths, feature_points_1.reshape(-1, 2), good_points):  # Iterate through all the good feature points
                if not good_points_flag:  # If the flag is not true, then continue
                    continue
                tp.append((x, y))  # its length greater than the threshold # Append the X and Y coordinates and check if
                if len(tp) > num_frames_to_track:
                    del tp[0]
                new_tracking_paths.append(tp)
                cv2.circle(output_img, (x, y), 3, (0, 255, 0), -1)  # Draw a circle around the feature points
            tracking_paths = new_tracking_paths  # Update the tracking paths
            cv2.polylines(output_img, [np.int32(tp) for tp in tracking_paths], False, (0, 150, 0))  # Draw lines
        if not frame_index % num_frames_jump:  # right number of frames # Go into this 'if' condition after skipping the
            mask = np.zeros_like(frame_gray)  # Create a mask and draw the circles
            mask[:] = 255
            for x, y in [np.int32(tp[-1]) for tp in tracking_paths]:
                cv2.circle(mask, (x, y), 6, 0, -1)
            feature_points = cv2.goodFeaturesToTrack(frame_gray, mask=mask, maxCorners=500, qualityLevel=0.3, minDistance=7, blockSize=7)  # Compute good features to track
            if feature_points is not None:  # to the tracking paths # Check if feature points exist. If so, append them
                for x, y in np.float32(feature_points).reshape(-1, 2):
                    tracking_paths.append([(x, y)])
        frame_index += 1  # Update variables
        prev_gray = frame_gray
        cv2.imshow("Optical Flow", output_img)  # Display output
        c = cv2.waitKey(1)  # Check if the user hit the 'Esc' key
        if c == 27:
            break


if __name__ == "__main__":
    start_tracking()  # Start the tracker
    cv2.destroyAllWindows()  # Close all the windows
