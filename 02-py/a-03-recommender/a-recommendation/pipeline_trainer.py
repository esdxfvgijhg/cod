#!/usr/bin/python
from sklearn.datasets import samples_generator
from sklearn.feature_selection import SelectKBest, f_regression
from sklearn.pipeline import Pipeline
from sklearn.ensemble import ExtraTreesClassifier

X, y = samples_generator.make_classification(n_samples=150, n_features=25, n_classes=3, n_informative=6, n_redundant=0, random_state=7)  # Generate data
k_best_selector = SelectKBest(f_regression, k=9)  # Select top K features
classifier = ExtraTreesClassifier(n_estimators=60, max_depth=4)  # Initialize Extremely Random Forests classifier
processor_pipeline = Pipeline([("selector", k_best_selector), ("erf", classifier)])  # Construct the pipeline
processor_pipeline.set_params(selector__k=7, erf__n_estimators=30)  # Set the parameters
processor_pipeline.fit(X, y)  # Training the pipeline
output = processor_pipeline.predict(X)  # Predict outputs for the input data
print("\nPredicted output:\n", output)
print("\nScore:", processor_pipeline.score(X, y))  # Print scores
status = processor_pipeline.named_steps["selector"].get_support()  # Print the features chosen by the pipeline selector
selected = [i for i, x in enumerate(status) if x]  # Extract and print indices of selected features
print("\nIndices of selected features:", ", ".join([str(x) for x in selected]))
