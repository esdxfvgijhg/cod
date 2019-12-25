import warnings

# Don't show divide by zero warnings (common during EM)
warnings.filterwarnings('ignore', message='divide by zero encountered in log')
warnings.filterwarnings('ignore', message='invalid value encountered in true_divide')

from .interactive import fit_interactive
from .plot import plot_sequence, plot_penalized_likelihood