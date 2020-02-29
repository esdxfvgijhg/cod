#!/usr/bin/python
import numpy as np #!/usr/bin/python
import matplotlib.pyplot as plt
from sklearn import model_selection
def load_data(input_file):  # Load multivar data in the input file
    X = []
    with open(input_file, "r") as f:
        for line in f.readlines():
            data = [float(x) for x in line.split(",")]
            X.append(data)
    return np.array(X)
def plot_classifier(classifier, X, y, title="Classifier boundaries", annotate=False):  # Plot the classifier boundaries on input data
    x_min, x_max = min(X[:, 0]) - 1.0, max(X[:, 0]) + 1.0  # define ranges to plot the figure
    y_min, y_max = min(X[:, 1]) - 1.0, max(X[:, 1]) + 1.0
    step_size = 0.01  # denotes the step size that will be used in the mesh grid
    x_values, y_values = np.meshgrid(np.arange(x_min, x_max, step_size), np.arange(y_min, y_max, step_size))  # define the mesh grid
    mesh_output = classifier.predict(np.c_[x_values.ravel(), y_values.ravel()])  # compute the classifier output
    mesh_output = mesh_output.reshape(x_values.shape)  # reshape the array
    plt.figure()  # Plot the output using a colored plot
    plt.title(title)  # Set the title
    plt.pcolormesh(x_values, y_values, mesh_output, cmap=plt.cm.Set1)  # here: http://matplotlib.org/examples/color/colormaps_reference.html # choose a color scheme you can find all the options
    plt.scatter(X[:, 0], X[:, 1], c=y, edgecolors="black", linewidth=2, cmap=plt.cm.Set1)  # Overlay the training points on the plot
    plt.xlim(x_values.min(), x_values.max())  # specify the boundaries of the figure
    plt.ylim(y_values.min(), y_values.max())
    plt.xticks(())  # specify the ticks on the X and Y axes
    plt.yticks(())
    if annotate:
        for x, y in zip(X[:, 0], X[:, 1]):
            plt.annotate("(" + str(round(x, 1)) + "," + str(round(y, 1)) + ")", xy=(x, y), xytext=(-15, 15), textcoords="offset points", horizontalalignment="right", verticalalignment="bottom", bbox=dict(boxstyle="round,pad=0.6", fc="white", alpha=0.8), arrowprops=dict(arrowstyle="-", connectionstyle="arc3,rad=0"))  # http://matplotlib.org/api/text_api.html#matplotlib.text.Annotation # Full documentation of the function available here:
def print_accuracy_report(classifier, X, y, num_validations=5):  # Print performance metrics
    accuracy = model_selection.cross_val_score(classifier, X, y, scoring="accuracy", cv=num_validations)
    print("Accuracy: " + str(round(100 * accuracy.mean(), 2)) + "%")
    f1 = model_selection.cross_val_score(classifier, X, y, scoring="f1_weighted", cv=num_validations)
    print("F1: " + str(round(100 * f1.mean(), 2)) + "%")
    precision = model_selection.cross_val_score(classifier, X, y, scoring="precision_weighted", cv=num_validations)
    print("Precision: " + str(round(100 * precision.mean(), 2)) + "%")
    recall = model_selection.cross_val_score(classifier, X, y, scoring="recall_weighted", cv=num_validations)
    print("Recall: " + str(round(100 * recall.mean(), 2)) + "%")
