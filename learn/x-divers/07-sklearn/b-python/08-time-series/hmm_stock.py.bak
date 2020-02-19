#!/usr/bin/python
import datetime
import numpy as np
import matplotlib.pyplot as plt
from hmmlearn.hmm import GaussianHMM

try:
    from matplotlib.finance import quotes_historical_yahoo_ochl
except ImportError:
    from matplotlib.finance import quotes_historical_yahoo as quotes_historical_yahoo_ochl
quotes = quotes_historical_yahoo_ochl("INTC", datetime.date(1994, 4, 5), datetime.date(2015, 7, 3))  # Get quotes from Yahoo finance
dates = np.array([quote[0] for quote in quotes], dtype=np.int)  # Extract the required values
closing_values = np.array([quote[2] for quote in quotes])
volume_of_shares = np.array([quote[5] for quote in quotes])[1:]
diff_percentage = 100.0 * np.diff(closing_values) / closing_values[:-1]  # Take diff of closing values and computing rate of change
dates = dates[1:]
X = np.column_stack([diff_percentage, volume_of_shares])  # Stack the percentage diff and volume values column-wise for training
print "\nTraining HMM...."  # Create and train Gaussian HMM
model = GaussianHMM(n_components=5, covariance_type="diag", n_iter=1000)
model.fit(X)
num_samples = 500  # Generate data using model
samples, _ = model.sample(num_samples)
plt.plot(np.arange(num_samples), samples[:, 0], c="black")
plt.show()
