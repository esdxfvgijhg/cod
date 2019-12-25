"""
Uniformize sklearn and hmmlearn interfaces.
"""

import hmmlearn.hmm
import sklearn.mixture
import numpy as np


class BayesianGaussianMixture(sklearn.mixture.BayesianGaussianMixture):
    
    @classmethod
    def from_samples(cls, X, n_components_max):
        model = cls(n_components=n_components_max, n_init=3, init_params='kmeans')
        return model.fit(X)

    def log_likelihood(self, X):
        return np.sum(self.score_samples(X))

    def n_states(self, X):
        return len(set(self.predict(X)))
    
    
class GaussianMixture(sklearn.mixture.GaussianMixture):

    @classmethod
    def from_samples(cls, X, n_components):
        model = cls(n_components=n_components, n_init=3, init_params='kmeans')
        return model.fit(X)

    def log_likelihood(self, X):
        return np.sum(self.score_samples(X))


class GaussianHMM(hmmlearn.hmm.GaussianHMM):
    
    @classmethod
    def from_samples(cls, X, n_components):
        model = cls(n_components=n_components)
        return model.fit(X)

    def aic(self, X):
        # 2*k - 2*ln(L)
        return 2*self.n_params - 2*self.log_likelihood(X)
    
    def bic(self, X):
        # ln(n)*k - 2*ln(L)
        return np.log(len(X))*self.n_params - 2*self.log_likelihood(X)
        
    def log_likelihood(self, X):
        return self.score(X)

    @property
    def n_iter_(self):
        return self.monitor_.n_iter
    
    @property
    def n_params(self):
        # Assumes univariate Gaussian distributions
        # Transition matrix rows + mean/variance of each Gaussian
        return self.n_components**2 - self.n_components + 2*self.n_components