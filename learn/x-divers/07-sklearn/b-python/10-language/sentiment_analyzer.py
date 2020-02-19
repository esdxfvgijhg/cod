#!/usr/bin/python
from nltk.corpus import movie_reviews
from nltk.classify import NaiveBayesClassifier
from nltk.classify.util import accuracy as nltk_accuracy


def extract_features(words):  # Extract features from the input list of words
    return dict([(word, True) for word in words])


if __name__ == "__main__":
    fileids_pos = movie_reviews.fileids("pos")  # Load the reviews from the corpus
    fileids_neg = movie_reviews.fileids("neg")
    features_pos = [(extract_features(movie_reviews.words(fileids=[f])), "Positive") for f in fileids_pos]  # Extract the features from the reviews
    features_neg = [(extract_features(movie_reviews.words(fileids=[f])), "Negative") for f in fileids_neg]
    threshold = 0.8  # Define the train and test split (80% and 20%)
    num_pos = int(threshold * len(features_pos))
    num_neg = int(threshold * len(features_neg))
    features_train = features_pos[:num_pos] + features_neg[:num_neg]  # Create training and training datasets
    features_test = features_pos[num_pos:] + features_neg[num_neg:]
    print("\nNumber of training datapoints:", len(features_train))  # Print the number of datapoints used
    print("Number of test datapoints:", len(features_test))
    classifier = NaiveBayesClassifier.train(features_train)  # Train a Naive Bayes classifier
    print("\nAccuracy of the classifier:", nltk_accuracy(classifier, features_test))
    N = 15
    print("\nTop " + str(N) + " most informative words:")
    for i, item in enumerate(classifier.most_informative_features()):
        print(str(i + 1) + ". " + item[0])
        if i == N - 1:
            break
    input_reviews = ["The costumes in this movie were great", "I think the story was terrible and the characters were very weak", "People say that the director of the movie is amazing", "This is such an idiotic movie. I will not recommend it to anyone."]  # Test input movie reviews
    print("\nMovie review predictions:")
    for review in input_reviews:
        print("\nReview:", review)
        probabilities = classifier.prob_classify(extract_features(review.split()))  # Compute the probabilities
        predicted_sentiment = probabilities.max()  # Pick the maximum value
        print("Predicted sentiment:", predicted_sentiment)  # Print outputs
        print("Probability:", round(probabilities.prob(predicted_sentiment), 2))
