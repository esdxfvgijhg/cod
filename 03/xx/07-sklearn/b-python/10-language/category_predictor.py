#!/usr/bin/python
from sklearn.datasets import fetch_20newsgroups
from sklearn.naive_bayes import MultinomialNB
from sklearn.feature_extraction.text import TfidfTransformer
from sklearn.feature_extraction.text import CountVectorizer

category_map = {"talk.politics.misc": "Politics", "rec.autos": "Autos", "rec.sport.hockey": "Hockey", "sci.electronics": "Electronics", "sci.med": "Medicine"}  # Define the category map
training_data = fetch_20newsgroups(subset="train", categories=category_map.keys(), shuffle=True, random_state=5)  # Get the training dataset
count_vectorizer = CountVectorizer()  # Build a count vectorizer and extract term counts
train_tc = count_vectorizer.fit_transform(training_data.data)
print("\nDimensions of training data:", train_tc.shape)
tfidf = TfidfTransformer()  # Create the tf-idf transformer
train_tfidf = tfidf.fit_transform(train_tc)
input_data = ["You need to be careful with cars when you are driving on slippery roads", "A lot of devices can be operated wirelessly", "Players need to be careful when they are close to goal posts", "Political debates help us understand the perspectives of both sides"]  # Define test data
classifier = MultinomialNB().fit(train_tfidf, training_data.target)  # Train a Multinomial Naive Bayes classifier
input_tc = count_vectorizer.transform(input_data)  # Transform input data using count vectorizer
input_tfidf = tfidf.transform(input_tc)  # Transform vectorized data using tfidf transformer
predictions = classifier.predict(input_tfidf)  # Predict the output categories
for sent, category in zip(input_data, predictions):  # Print the outputs
    print("\nInput:", sent, "\nPredicted category:", category_map[training_data.target_names[category]])
