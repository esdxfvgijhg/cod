#!/usr/bin/python
import os
import cv2
import numpy as np
from sklearn import preprocessing


class LabelEncoder(object):  # Class to handle tasks related to label encoding
    def encode_labels(self, label_words):  # Method to encode labels from words to numbers
        self.le = preprocessing.LabelEncoder()
        self.le.fit(label_words)

    def word_to_num(self, label_word):  # Convert input label from word to number
        return int(self.le.transform([label_word])[0])

    def num_to_word(self, label_num):  # Convert input label from number to word
        return self.le.inverse_transform([label_num])[0]


def get_images_and_labels(input_path):  # Extract images and labels from input path
    label_words = []
    for root, dirs, files in os.walk(input_path):  # Iterate through the input path and append files
        for filename in (x for x in files if x.endswith(".jpg")):
            filepath = os.path.join(root, filename)
            label_words.append(filepath.split("/")[-2])
    images = []  # Initialize variables
    le = LabelEncoder()
    le.encode_labels(label_words)
    labels = []
    for root, dirs, files in os.walk(input_path):  # Parse the input directory
        for filename in (x for x in files if x.endswith(".jpg")):
            filepath = os.path.join(root, filename)
            image = cv2.imread(filepath, 0)  # Read the image in grayscale format
            name = filepath.split("/")[-2]  # Extract the label
            faces = faceCascade.detectMultiScale(image, 1.1, 2, minSize=(100, 100))  # Perform face detection
            for (x, y, w, h) in faces:  # Iterate through face rectangles
                images.append(image[y : y + h, x : x + w])
                labels.append(le.word_to_num(name))
    return images, labels, le


if __name__ == "__main__":
    cascade_path = "cascade_files/haarcascade_frontalface_alt.xml"
    path_train = "faces_dataset/train"
    path_test = "faces_dataset/test"
    faceCascade = cv2.CascadeClassifier(cascade_path)  # Load face cascade file
    recognizer = cv2.face.createLBPHFaceRecognizer()  # Initialize Local Binary Patterns Histogram face recognizer
    images, labels, le = get_images_and_labels(path_train)  # Extract images, labels, and label encoder from training dataset
    print "\nTraining..."  # Train the face recognizer
    recognizer.train(images, np.array(labels))
    print "\nPerforming prediction on test images..."  # Test the recognizer on unknown images
    stop_flag = False
    for root, dirs, files in os.walk(path_test):
        for filename in (x for x in files if x.endswith(".jpg")):
            filepath = os.path.join(root, filename)
            predict_image = cv2.imread(filepath, 0)  # Read the image
            faces = faceCascade.detectMultiScale(predict_image, 1.1, 2, minSize=(100, 100))  # Detect faces
            for (x, y, w, h) in faces:  # Iterate through face rectangles
                predicted_index, conf = recognizer.predict(predict_image[y : y + h, x : x + w])  # Predict the output
                predicted_person = le.num_to_word(predicted_index)  # Convert to word label
                cv2.putText(predict_image, "Prediction: " + predicted_person, (10, 60), cv2.FONT_HERSHEY_SIMPLEX, 2, (255, 255, 255), 6)  # Overlay text on the output image and display it
                cv2.imshow("Recognizing face", predict_image)
            c = cv2.waitKey(0)
            if c == 27:
                stop_flag = True
                break
        if stop_flag:
            break
