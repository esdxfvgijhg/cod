#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix
from sklearn.metrics import classification_report

true_labels = [2, 0, 0, 2, 4, 4, 1, 0, 3, 3, 3]  # Define sample labels
pred_labels = [2, 1, 0, 2, 4, 3, 1, 0, 1, 3, 3]
confusion_mat = confusion_matrix(true_labels, pred_labels)  # Create confusion matrix
plt.imshow(confusion_mat, interpolation="nearest", cmap=plt.cm.gray)  # Visualize confusion matrix
plt.title("Confusion matrix")
plt.colorbar()
ticks = np.arange(5)
plt.xticks(ticks, ticks)
plt.yticks(ticks, ticks)
plt.ylabel("True labels")
plt.xlabel("Predicted labels")
plt.show()
targets = ["Class-0", "Class-1", "Class-2", "Class-3", "Class-4"]  # Classification report
print("\n", classification_report(true_labels, pred_labels, target_names=targets))
