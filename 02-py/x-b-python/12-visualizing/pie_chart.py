#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt

data = {"Apple": 26, "Mango": 17, "Pineapple": 21, "Banana": 29, "Banana2": 79, "Strawberry": 11}  # Labels and corresponding values in counter clockwise direction
colors = ["orange", "lightgreen", "lightblue", "gold", "cyan", "red"]  # List of corresponding colors
explode = (0, 0, 0, 0, 0, 0)  # Needed if we want to highlight a section
plt.pie(data.values(), explode=explode, labels=data.keys(), colors=colors, autopct="%1.1f%%", shadow=False, startangle=90)  # Plot the pie chart
plt.axis("equal")  # Aspect ratio of the pie chart, 'equal' indicates tht we want it to be a circle
plt.show()
