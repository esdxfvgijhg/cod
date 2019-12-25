import sys; sys.path.append('..')
from trends import *

import matplotlib.pyplot as plt
from .plot import *
from ipywidgets import IntSlider, interactive


def fit_interactive(df, model_class):
    X = df.rtt.fillna(method='ffill')[:,np.newaxis]
    def fn(Components):
        model = model_class.from_samples(X, Components)
        print('EM stopped after {} iterations'.format(model.n_iter_))
        print('Final log-likelihood = {}'.format(model.log_likelihood(X)))
        plt.figure(figsize=(16,2.5)); plt.grid(0)
        plot_rtt(df); plot_sequence(df.index, model.predict(X))
    slider = interactive(fn, Components=IntSlider(min=2, max=10, value=2, continuous_update=False))
    slider.children[-1].layout.height = '210px'
    return slider