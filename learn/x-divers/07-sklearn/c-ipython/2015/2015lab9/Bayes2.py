#!/usr/bin/env python
# coding: utf-8

# # The many faces of the Reverend Bayes: Face 2.
# 
# with many parts stolen from labs and lectures for AM207.

# In[282]:


get_ipython().magic(u'matplotlib inline')
import numpy as np
import scipy as sp
import matplotlib as mpl
import matplotlib.cm as cm
import matplotlib.pyplot as plt
import pandas as pd
pd.set_option('display.width', 500)
pd.set_option('display.max_columns', 100)
pd.set_option('display.notebook_repr_html', True)
import seaborn as sns
sns.set_style("whitegrid")
sns.set_context("poster")


# ## FREQUENTIST STATISTICS
# 
# $\newcommand{\Lik}{p(D|\theta)}$
# 
# 
# In frequentist approach, a parameter estimate is computed by using some function on the data $D$. 
# In the world of frequentist there is a true value of the parameter, which is fixed, however  the data are random. 
# 
# In other words, assuming that a given distribution is a good description of the model, there is a true parameter $\theta^{\star}$ that characterizes the population. Given the data set(sample) we have, we can estimate the parameter $\hat{\theta}$. If we could replicate the experiment many times we would have the sampling distribution of $\theta$ which can be used to estimate the error on the parameter estimation. By sampling $M$ Data sets $D_i$, each of size $N$, from some true model characterized by $\theta^{\star}$ we are able to calculate  $\hat{\theta}_i$, one for each dataset. And as $M\rightarrow \infty$ the distribution of $\hat{\theta}$'s becomes narrower and narrower and approaches $\theta^{\star}$. 
# 
# ## Maximum Likelihood
# A  basic approach to parameter estimation is maximum likelihood (MLE). The goal here
# is to find the parameter estimates that maximize the likelihood. 
# 
# The likelihood gives us a measure of how likely it is to observe values $D={d_1,...,d_n}$ given the parameters $\theta$. 
# 
# Assumming iid, the likelihood  is
# 
# $$L=\Lik = \prod_{i=1}^{n} p(d_i|\theta)$$
# 
# How likely are the observations if the model is true?
# This corresponds to maximizing the likelihood as a function of $\theta$ for a given set of observations. 
# 
# $$ \theta_{ML} = \arg \! \max_{\theta} \Lik $$
# 
# Notice that this method wants to account for every point in the "training set". So it overfits.

# ## The Bayesian Approach
# 
# 
# A Bayesian approach to parameter estimation is to treat $\theta$ as a random variable instead, and to fix the data set. So we dont talk anymore about the data set as a sample from a population, but assume that its all we know about the world. KIts fixed.
# 
# We then associate with the parameter $\theta$ a
# prior distribution $p(\theta)$. The prior distribution represents our belief on the
# parameter values when we have not observed any data yet. 
# 
# In a Bayesian context, the first
# goal is to estimate the posterior distribution over parameter values given our data. This is also
# known as posterior inference. In other words, we would like to know $p(\theta|D)$ or $p(\theta|y)$.
# 
# $$ p(\theta|y) = \frac{p(y|\theta)\,p(\theta)}{p(y)} $$
# 
# with the evidence $p(D)$ or $p(y)$ being given by the prior-predictive:
# 
# $$p(y) = \int d\theta p(y|\theta) p(\theta)$$ 
# 
# Remember though at the end of the day, we care about how we are going to make predictions on future data, and not the values of the parameters. Thus what we wish to find is the distribution of a future data point $y^*$, also known as the posterior predictive distribution:
# 
# $$p(y^* | D=\{y\}) = \int d\theta p(y^*|\theta)p(\theta|\{y\})$$.
# 
# If you think about this, for example, from the perspective of a regression problem, this is the distribution for y at a new x (which in many cases is gaussian). This is not different from the frequentist case. But there the different y's come from the different samples (typically realized in practice as bootstrap samples).
# 
# ## Maximum a posteriori
# 
# The posterior distribution is specified by a simple product of the likelihood (how
# likely is the data given the model that uses these parameter estimates) and the prior. 
# In Bayesian data analysis, one way to
# apply a model to data is to find the maximum a posteriori (MAP) parameter values.
# The goal in this case is to find the parameter  that maximize the posterior probability of the
# parameters given the data. In other words, we find the mode of the posterior distribution.
# This corresponds to:
# 
# \begin{eqnarray}
#  \theta_{{\rm MAP}} &=& \arg \max_{\theta} \, p(\theta | D)  \nonumber \\ 
#                                & =& \arg \max_{\theta}  \frac{\Lik \, p(\theta)}{p(D)}  \nonumber \\ 
#                                & =& \arg \max_{\theta}  \, \Lik \, p(\theta) \nonumber \\ 
# \end{eqnarray}
# 
# This looks similar to the maximum likelihood estimation procedure. The difference is that
# the prior we set over the parameters does influence the parameter estimation. 
# Although it seems that the prior should not play a role in parameter
# estimation, there are some good reasons to prefer the MAP over the ML estimation, especially
# when only few data points are available or when the data is degenerate in some way (e.g.,
# the data shows no variation).

# ##Coin tosses: Binomial-Beta
# 
# code from https://github.com/CamDavidsonPilon/Probabilistic-Programming-and-Bayesian-Methods-for-Hackers/blob/master/Chapter1_Introduction/Chapter1.ipynb
# 
# This is our first example of a conjugate prior model. Coin tosses are modelled using the Binomial Distribution, which is the distribution of a set of Bernoulli random variables. The Beta distribution is conjugate to the Binomoal distribution, so that if your prior is
# $p \sim Beta(\alpha,\beta)$ and your data distribution is a set of bernoulli trials, you then have a $L = Binom(n,p)$ likelihood from the multiple ways in which those Bernouuli trials can occur. Then the posterior is, if we observed y heads in n trials:
# 
# $$ p(p|y) \propto p(y|p) P(p) = Binom(n,p) \times Beta(\alpha, \beta)$$
# 
# Because of the conjugacy, this turns out to be:
# 
# $$Beta(y + \alpha, n - y + \beta)$$
# 
# Here we use a $Beta(1,1)$ prior since it is equivalent to a uniform distribution. This is an **uninformative prior**.

# In[56]:


plt.figure(figsize=(11, 9))

import scipy.stats as stats

beta = stats.beta
n_trials = [0, 1, 2, 3, 4, 5, 8, 15, 50, 500]
data = stats.bernoulli.rvs(0.5, size=n_trials[-1])
x = np.linspace(0, 1, 100)

# For the already prepared, I'm using Binomial's conj. prior.
for k, N in enumerate(n_trials):
    sx = plt.subplot(len(n_trials) / 2, 2, k + 1)
    plt.xlabel("$p$, probability of heads")         if k in [0, len(n_trials) - 1] else None
    plt.setp(sx.get_yticklabels(), visible=False)
    heads = data[:N].sum()
    #posterior distribution.
    y = beta.pdf(x, 1 + heads, 1 + N - heads)
    plt.plot(x, y, label="observe %d tosses,\n %d heads" % (N, heads))
    plt.fill_between(x, 0, y, color="#348ABD", alpha=0.4)
    plt.vlines(0.5, 0, 4, color="k", linestyles="--", lw=1)

    leg = plt.legend()
    leg.get_frame().set_alpha(0.4)
    plt.autoscale(tight=True)


plt.suptitle("Bayesian updating of posterior probabilities",
             y=1.02,
             fontsize=14)

plt.tight_layout()


# ## The Normal Model
# 
#  
#  A random variable $Y$ is said to be normally distributed with mean $\mu$ and variance $\sigma^2$ if the 
#  density of $Y$ is given by 
#  $$ p(y|\mu, \sigma^2) =  \frac{1}{ \sqrt{ 2 \pi \sigma^2}} e^{-( \frac{y-\mu}{2 \sigma})^2} $$
#  
#  
# Suppose our model is $\{y_1, \ldots, y_n|\mu, \sigma^2 \} \sim N(\mu, \sigma^2)$ then
# the likelihood is 
# 
# $$
# p(y_1, \ldots, y_n| \mu, \sigma^2) = 
# \prod_{i=1}^{n} p(y_i| \mu, \sigma^2)=\prod_{i=1}^{n}  \frac{1}{ \sqrt{ 2 \pi \sigma^2}} e^{-( \frac{(y_i-\mu)^2}{2\sigma^2})} = 
# \frac{1}{ \sqrt{ 2 \pi \sigma^2}}   \exp \left\{  - \frac{1}{2}  \sum_i \frac{(y_i-\mu)^2}{\sigma^2} \right\} 
# $$
# 
# Lets see the posterior of $\mu$ assuming we 
# know $\sigma^2$.  
# 
# For any conditional prior the posterior 
# 
# $$ p( \mu |  y_1, \ldots, y_n, \sigma^2)  \propto p(\mu| \sigma^2) \,e^{ - \frac{1}{2\sigma^2} \sum (y_i - \mu)^2 }$$
# 
# 
# The conjugate of the normal is the normal itself. 
# 
# Say we have the prior
# 
# $$ p(\mu | \sigma^2) = \exp \left\{ -\frac{1}{2 \tau^2} (\hat{\mu}-\mu)^2 \right\} $$
# 
# then it can be shown that the posterior is 
# 
# $$  p( \mu |  y_1, \ldots, y_n, \sigma^2) \propto \exp \left\{ -\frac{a}{2} (\mu-b/a)^2 \right\} $$
# where 
# $$ a = \frac{1}{\tau^2} + \frac{n}{\sigma^2} , \;\;\;\;\; b = \frac{\hat{\mu}}{\tau^2} + \frac{\sum y_i}{\sigma^2} $$
# This is a normal density curve with $1/\sqrt{a}$ playing the role of the 
# standard deviation and $b/a$ playing the role of the mean. Re-writing this, 
# 
# $$ p( \mu |  y_1, \ldots, y_n, \sigma^2)  \propto \exp\left\{ -\frac{1}{2} \left( \frac{\mu-b/a}{1/\sqrt(a)}\right)^2 \right\} $$
# 
# 
# Define $\kappa = \sigma^2 / \tau^2 $ to be the variance of the sample model  in units of variance
# of our prior belief (prior distribution) then the posterior mean  
# 
# $$\mu_p = \frac{ \kappa}{\kappa + n }  \hat{\mu} + \frac{n}{\kappa + n} \bar{y} $$
# 
# which is a weighted average of prior mean and sampling mean.
# The variance is 
# 
# $$ \tau_p^2 = \frac{1}{1/\tau^2+n/\sigma^2} $$
# or better 
# 
# $$ \frac{1}{\tau_p^2} = \frac{1}{\tau^2} + \frac{n}{\sigma^2} $$

# ###Gaussian with known $\sigma$
# 
# (this is an example from AM207)
# 
# Define $\kappa=\frac{\sigma^2}{\tau^2}$ to be the variance of the sample model in units of variance of our prior belief (prior distribution) then the posterior mean
# 
# $$\mu_{p} = \frac{\kappa}{\kappa + n} \mu_{prior} + \frac{n}{\kappa + n} \bar{y}$$
# 
# which is a weighted average of prior mean and sampling mean. The variance is
# 
# $$\frac{1}{\tau_p^2} = \frac{1}{\tau^2} + \frac{1}{\sigma^2}$$
# 
# We have data on the wing length in millimeters of a nine members of a particular species of moth. We wish to make inferences from those measurements on the population mean $\mu$. Other studies show the wing length to be around 19 mm. We also know that the length must be positive. We can choose a prior that is normal and most of the density is above zero ($\mu=19.5,\tau=10$). This is only a **marginally informative** prior.
# 
# Many bayesians would prefer you choose relatively uninformative priors.
# 
# The measurements were: 16.4, 17.0, 17.2, 17.4, 18.2, 18.2, 18.2, 19.9, 20.8 giving $\bar{y}=18.14$. 
# 
# Using the formulas above we have ($\kappa = \frac{\sigma^2}{100}$) and 
# say $\sigma^2=s^2=1.9928$ then the posterior is $N(18.14,0.47)$. Note this is for a KNOWN $\sigma$.

# In[2]:


Y = [16.4, 17.0, 17.2, 17.4, 18.2, 18.2, 18.2, 19.9, 20.8]
# Prior mean
mu_prior = 19.5
# prior std
tau = 10 
N = 15000


# In[3]:


#Data Quantities
sig = np.std(Y) # assume that is the value of KNOWN sigma (in the likelihood)
mu_data = np.mean(Y)
n = len(Y)
kappa = sig**2 / tau**2
sig_post =np.sqrt(1./( 1./tau**2 + n/sig**2));
# posterior mean
mu_post = kappa / (kappa + n) *mu_prior + n/(kappa+n)* mu_data

#samples
theta_prior = np.random.normal(loc=mu_prior, scale=tau, size=N);
theta_post = np.random.normal(loc=mu_post, scale=sig_post, size=N);


# In[4]:


plt.hist(theta_post, bins=30, alpha=0.9, label="posterior");
plt.hist(theta_prior, bins=30, alpha=0.2, label="prior");
plt.xlim([10, 30])
plt.xlabel("wing length (mm)")
plt.ylabel("Number of samples")
plt.legend();


# ## Kidney Cancer
# 
# This is part of a dataset that Joe talked about in class. Its a dataset about counties in the US, and has information about kidney cancer fatalities over 5 years on a per county basis. This is stored in the variable `dc` below. The `pop` is the county population, and the 5 year mortaility is calculated by just dividing one by the other.

# In[94]:


dfk=pd.read_csv("kcancer.csv")
dfk.head()


# We've written some code, based on code in https://github.com/dataiap/dataiap/blob/master/resources/util/map_util.py to map what this looks like.

# In[156]:


import simplejson as json
with open('./us_state_map.geojson','r') as fp:
    statedata = json.load(fp)
with open('./us_county_map.geojson','r') as fp:
    data = json.load(fp)


# In[174]:


from collections import defaultdict
fips2poly = defaultdict(list)
blues = ['#FFF7FB', '#ECE7F2', '#D0D1E6', '#A6BDDB', '#74A9CF',
         '#3690C0', '#0570B0', '#045A8D', '#023858']
_color_idx = 0
def draw_polygon(subplot, coords, **kwargs):
    xs, ys = zip(*coords)
    kwargs['alpha']=0.5
    subplot.fill(xs, ys, **kwargs)
def draw_county(subplot, fips, **kwargs):
    """
    draw_county(subplot, fips, color=..., **kwargs)
    
    Automatically draws a filled shape representing the county with id fips in
    subplot.  The color keyword argument specifies the fill color.  It accepts keyword
    arguments that plot() accepts
    The fips id is described at http://en.wikipedia.org/wiki/FIPS_county_code
    """
    global _color_idx
    if fips not in fips2poly:
        #raise RuntimeError, 'County fips %s not found' % fips
        print 'County fips %s not found' % fips
        return
    if 'color' not in kwargs:
        color = blues[_color_idx]
        _color_idx = (_color_idx+1) % len(blues)
        kwargs['color'] = color
    for polygon in fips2poly[fips]:
        draw_polygon(subplot, polygon, **kwargs)

for f in data['features']:
    fips = f['properties']['GEOID']
    fips = int(fips)
    geo = f['geometry']
    if geo['type'] == 'Polygon':
        for coords in geo['coordinates']:
            fips2poly[fips].append(coords)
    elif geo['type'] == 'MultiPolygon':
        for polygon in geo['coordinates']:
            fips2poly[fips].extend(polygon)


# In[175]:


state2poly = defaultdict(list)
for f in statedata['features']:
    state = f['properties']['NAME']
    geo = f['geometry']
    if geo['type'] == 'Polygon':
        for coords in geo['coordinates']:
            state2poly[state].append(coords)
    elif geo['type'] == 'MultiPolygon':
        for polygon in geo['coordinates']:
            state2poly[state].extend(polygon)


# In[176]:


def draw_state(subplot, name, **kwargs):
    """
    draw_state(subplot, state, color=..., **kwargs)
    
    Automatically draws a filled shape representing the state in
    subplot.  *state* is the full name of the state, as defined by USPS
    (https://www.usps.com/send/official-abbreviations.htm).
    The color keyword argument specifies the fill color.  It accepts keyword
    arguments that plot() accepts
    """
    global _color_idx
    if name not in state2poly:
        if get_statename(name) in state2poly:
            name = get_statename(name)
        else:
            print "state %s not found" % name
            return

    kwargs['color'] = "#FFFFFF"
    for polygon in state2poly[name]:
        draw_polygon(subplot, polygon, **kwargs)


# In[180]:


def make_map(countyseries, skip=[], stateskip=['Alaska', 'Hawaii'], color=None, ax=None):
    if not ax:
        fig = plt.figure(figsize=(16, 12))
        ax = plt.gca()

        for state in state2poly.keys():
            if state in stateskip:
                continue
            draw_state(ax, state,  ec='k')
        
    for county in countyseries:
        if county in skip:
            continue
        if color:
            draw_county(ax, county,  ec='k', color=color)
        else:
            draw_county(ax, county,  ec='k') 

    
    ax.set_xticks([])
    ax.set_yticks([])
    #ax.set_xlim(-180, -60)
    ax.set_xlim(-132, -60)
    ax.set_ylim(20, 59)
    return ax


# We look for the counties with the highest rate of cancer. Perhaps these are poorer, rural, with poor access to hospitals?

# In[111]:


top_kcancer_counties = dfk.sort(columns='pct_mortality',ascending=False)[:323]


# In[185]:


make_map(top_kcancer_counties.countyfips, color="blue")


# What about the counties with the lowest rate of cancer? Let us plot those as well..

# In[182]:


bot_kcancer_counties = dfk.sort(columns='pct_mortality',ascending=True)[:323]


# In[184]:


ax=make_map(top_kcancer_counties.countyfips, color="blue")
make_map(bot_kcancer_counties.countyfips, color="red", ax=ax)


# Um, these are right next door.

# In[277]:


ax=dfk.plot(kind='scatter',x="pop",y="pct_mortality",alpha=0.05, color="grey")
top_kcancer_counties.plot(kind='scatter',x="pop",y="pct_mortality",alpha=0.07, color="blue", ax=ax)
bot_kcancer_counties.plot(kind='scatter',x="pop",y="pct_mortality",alpha=0.07, color="red", ax=ax)
plt.ylim([-0.0001, 0.0005])
plt.xlim([-1, 700000])


# Plotting against the population of the county gives away the story. In a county with 1000 people, no cancers lowballs the likely rate and 1 cancer highballs it. Here is the same image on a log plot.

# In[204]:


ax=dfk.plot(kind='scatter',x="pop",y="pct_mortality",alpha=0.05, color="grey", logx=True)
top_kcancer_counties.plot(kind='scatter',x="pop",y="pct_mortality",alpha=0.07, color="blue", ax=ax,logx=True)
bot_kcancer_counties.plot(kind='scatter',x="pop",y="pct_mortality",alpha=0.07, color="red", ax=ax,logx=True)
plt.ylim([-0.0001, 0.001])


# What's a data analyst todo?
# 
# Recall the structure of the priors in the normal case and beta-binomial case. In situations where we do not have much data, the prior "means" or other quantities make a difference. In a sense, one can use priors to "regularize" or models.
# 
# Since we are dealing with count data here, we shall a use a poisson distribution to"generate" the counts. We have some choices.
# 
# ####Full pooling
# 
# We just add all the counts and populatioms together over the nation, estimating one death-rate. This is too BIASed a model..its a very big bulldozer for a small nail. Too coarse grained.
# 
# #### Fullly un-pooled
# 
# We just use the death rate in each county separately. We know this does poorly on low population counties. VARIANCE!
# 
# ####Partially pooled
# 
# What we want is a model which deferes to the data when there is enough: those counties with large populations, but regularizes the values from counties with small populations. What sort of a prior can help us here?
# 
# Why not borrow statistical strength from the overall average while not accepting it entirely? This leads naturally to the concept of a hierarchical model: one in which we have a separate poisson for each county, with a separate rate parameter for each county. But we assume that all of these rate parameters $\theta_j$ are draws from the same $Gamma(\alpha, \beta) distribution.
# 
# Modeling in this way has two advantages: (a) as we shall see, it helps us develop a computational strategy to solve the problem, and (b) it allows estimates of the probabilities of any one of the units (here, one of the experiments) to borrow strength from all the data as a whole through the estimation of the hyperparameters $\alpha$ and $\beta$. In other words, if some of the experiments had lower sample sizes or other outlier like behavior, the procedure helps "regularize" this.

# In[205]:


from scipy.stats import poisson, gamma, nbinom


# The likelihood is a product of poissons, each with a different rate parameter:
# 
# $$\cal L = \prod_{j} Poisson(y_{j}, 5\,\theta_{j}n_{j})$$
# 
# The prior is
# 
# $$p(\theta_{j}) \sim Gamma(\alpha, \beta)$$
# 
# The posterior distribution then simply turns out to be another Gamma!
# 
# $$p(\theta_{j} | \{y_j\}) \propto \cal L(\{y_j\} | \{\theta_{j}\}) \times p(\theta_{j}) \propto Gamma(\alpha + y_{j}, \beta + 5\,n_{j})$$
# 
# To calculate this postrior one MUST integrate or **marginalize** over all other parameters. Notice that all the poissons separate out.

# In[284]:


#counts_j ~ poisson (n_j*theta_j)
prior = lambda theta, a,b: gamma.pdf(theta, a, 0., 1./b)
like1 = lambda yj, thetaj, nj: poisson.pmf(yj, 5.*thetaj*nj)
posterior = lambda thetaj,a,b,yj, nj: gamma.pdf(thetaj, a+yj, 0., 1./(b+5.*nj))


# The mean of this posterior distribution is 
# 
# $$\frac{\alpha + y_{j}}{\beta + 5\,n_{j}}$$
# 
# which can be used to estimate the death rates in all the counties.

# In[285]:


meanpost = lambda yj,nj,a,b: (a+yj)/(b + 5*nj)


# The posterior predictive turns out to be simple too. Its a negative binomial distribution:
# 
# $$p(y^{*} | \{y_{j}\}) = NegBin(\alpha, \frac{\beta}{5\,n_{j}})$$
# 
# We can use this somewhat self-referentially on the same counties (or hold some out) to estimate the number of deaths in these counties. 
# 

# In[286]:


postpred = lambda y,a,b,nj: nbinom.pmf(y, a, b/(5.*nj))
meanpostpred=lambda nj, a,b: 5.*nj*(a/b)
varpostpred=lambda nj,a,b: meanpostpred(nj,a,b)*(1. +  meanpostpred(nj,a,b)/a)


# ###Empirical Bayes
# 
# Now here is the magic in the estimation of the parameter of the prior. We use the mean and the variance of the negative binomial distribution, respectively:
# 
# $$ 5\,n_{j}\frac{\alpha}{\beta}$$
# 
# and
# 
# $$ 5\,n_{j}\frac{\alpha}{\beta} + \left(5\,n_{j}\frac{\alpha}{\beta}\right)^{2}\frac{1}{\alpha}$$
# 
# and equate these to the empirically calculated mean and variance of the number of deaths: this fixes $\alpha$ and $\beta$ for us from all the data while the individual Gamma function posterior draws retain information from that counties contribution to the likelihood and thus only allow for partial pooling.

# In[287]:


dfk.head()


# In[288]:


meany=dfk.dc.mean()
vary=dfk.dc.var()


# In[289]:


meanpop=dfk['pop'].mean()


# In[290]:


meanpopsquared=np.mean(dfk['pop']**2)


# In[291]:


abyb=meany/(5.*meanpop)


# In[292]:


est_a = (25.*meanpopsquared*abyb*abyb)/(vary - meany) 


# In[293]:


est_b = est_a/abyb


# In[294]:


est_a, est_b


# In[295]:


abyb


# Here we plot the empirical distribution of the rates

# In[296]:


binx=np.arange(0, 15, 0.1)
plt.hist(100000*dfk.dc/(5.*dfk['pop']), bins=binx, alpha=0.4);
#plt.plot(binx, [prior(t/100000.0, est_a, est_b) for t in binx]);


# And here we see the posterior rates on the old plot...see how they are regularized to be in a sensible channel?

# In[299]:


ax=dfk.plot(kind='scatter',x="pop",y="pct_mortality",alpha=0.05, color="grey", logx=True)
top_kcancer_counties.plot(kind='scatter',x="pop",y="pct_mortality",alpha=0.07, color="blue", ax=ax,logx=True)
bot_kcancer_counties.plot(kind='scatter',x="pop",y="pct_mortality",alpha=0.07, color="red", ax=ax,logx=True)
vals=zip(dfk['dc'], dfk['pop'])
meanposts=[meanpost(yjay, njay, est_a, est_b) for (yjay, njay) in vals]
ax.plot(dfk['pop'], 5*np.array(meanposts), '.', alpha=0.04, color="green")
plt.ylim([-0.0001, 0.0003])


# Finally we note that the posterior predictive deaths forecast (blue dots are rotated) towards a flat line: ie they are regularized and are shrinking to a commonish mean!

# In[297]:


meanpostpreds = dfk['pop'].apply(lambda nj: meanpostpred(nj, est_a, est_b))
errorpostpreds= dfk['pop'].apply(lambda nj: np.sqrt(varpostpred(nj, est_a, est_b)))


# In[298]:


plt.errorbar(dfk['dc'], 
             meanpostpreds, 
             yerr=[errorpostpreds ,errorpostpreds],
             fmt='.', alpha=0.2)
plt.plot([0,600],[0,600],'k--', alpha=0.3)
plt.xlabel("observed deaths in 5 years")
plt.ylabel("posterior mean")
plt.ylim([0,1000])
plt.xlim([0,300])


# In[ ]:




