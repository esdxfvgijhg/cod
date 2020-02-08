#!/usr/bin/python
from sklearn.datasets import samples_generator
from sklearn.ensemble import RandomForestClassifier
from sklearn.feature_selection import SelectKBest, f_regression
from sklearn.pipeline import Pipeline

X, y = samples_generator.make_classification(n_informative=4, n_features=20, n_redundant=0, random_state=5)  # generate sample data
selector_k_best = SelectKBest(f_regression, k=10)  # Feature selector
classifier = RandomForestClassifier(n_estimators=50, max_depth=4)  # Random forest classifier
pipeline_classifier = Pipeline([("selector", selector_k_best), ("rf", classifier)])  # Build the machine learning pipeline
# Forest Classifier to 25, we can do it as shown below # feature selector and set 'n_estimators' in the Random # earlier. For example, if we want to set 'k' to 6 in the # We can set the parameters using the names we assigned
pipeline_classifier.set_params(selector__k=6, rf__n_estimators=25)
pipeline_classifier.fit(X, y)  # Training the classifier
prediction = pipeline_classifier.predict(X)  # Predict the output
print "\nPredictions:\n", prediction
print "\nScore:", pipeline_classifier.score(X, y)  # Print score
features_status = pipeline_classifier.named_steps["selector"].get_support()  # Print the selected features chosen by the selector
selected_features = []
for count, item in enumerate(features_status):
    if item:
        selected_features.append(count)
print "\nSelected features (0-indexed):", ", ".join([str(x) for x in selected_features])
