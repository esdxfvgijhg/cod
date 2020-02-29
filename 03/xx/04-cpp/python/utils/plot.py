import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns

from matplotlib.ticker import MaxNLocator


def plot_sequence(index, seq, ax=None):
    # Reindex sequence
    mapping = {y: x for x, y in enumerate(np.unique(seq))}
    seq = [mapping[x] for x in seq]
    if ax is None:
        ax = plt.gca()
    ax.grid(0)
    palette = sns.husl_palette(np.max(seq)+1, l=0.7, s=.9)
    last_idx, last_state = index[0], seq[0]
    for idx, state in zip(index[1:], seq[1:]):
        if (state != last_state) or (idx == index[-1]):
            ax.axvspan(last_idx, idx, alpha=0.3, color=palette[last_state])
            last_idx, last_state = idx, state


def plot_penalized_likelihood(stats, figsize=(14,4)):
    fig, axes = plt.subplots(ncols=2, figsize=figsize)
    axes[0].plot(stats.log_likelihood)
    axes[0].set_xlabel('Number of components')
    axes[0].set_ylabel('Log-Likelihood')
    axes[0].xaxis.set_major_locator(MaxNLocator(integer=True))
    axes[1].plot(stats.aic, label='AIC')
    axes[1].plot(stats.bic, label='BIC')
    axes[1].scatter(stats.aic.idxmin(), stats.aic.min(), marker='*')
    axes[1].scatter(stats.bic.idxmin(), stats.bic.min(), marker='*')
    axes[1].set_xlabel('Number of components')
    axes[1].set_ylabel('Penalized Log-Likelihood')
    axes[1].xaxis.set_major_locator(MaxNLocator(integer=True))
    axes[1].legend()