#!/usr/bin/env python
# coding: utf-8

# # CS-109: Fall 2015  -- Lab 11
# 
# ***
# In today's lab we'll talk about:
# 1. Project Guidelines
# 2. Go through an example project with lots of key elements.
# 3. In the middle of (2.) we'll see Elastic Net regularization as an extension of Lasso. What's a lab without learning?!
# 
# This is the main file for the lab, `Lab11-2-Data-Processing.ipynb` is supplemental. 
# ***
# 
# ## But first, this:
# You'll be working in groups now, we encourage you to continue to use `git` but **constant communication** is key. [Slack](https://slack.com/) may be a good option for this!
# 
# [<img src="./images/git.png">](https://xkcd.com/1597/)
# 
# 

# # Project Guidelines:
# Much of this is taken directly from the [Project Page](http://cs109.github.io/2015/pages/projects.html) on the CS109 website.
# 
# > Goal: to go through the complete data science process to answer questions you have about some topic.
# >
# > How?
# > - acquire the data
# > - design your visualizations
# > - run statistical analysis
# > - communicate the results
# 
# ### Project Milestones:
# - **Proposal**: Due 11/12/2015
# - **Proposal Review**: You'll be assigned a TF as an advisor, they'll review your proposal and meet with your **entire** team.
# 
# 
# ### Data science as a process
# You'll start with an initial idea, your TF should be able to guide you as to the viability of such a proposal. However, as with any project, you'll run into roadblocks! It's important for us to see the entire process and not just the final product. **Your proposal is a great jumping-off point for some of this!**
# 
# >#### IPython Process Book
# 
# >An important part of your project is your iPython process book. Your process book details your steps in developing your solution, including how you collected the data, alternative solutions you tried, describing statistical methods you used, and the insights you got. Equally important to your final results is how you got there! Your process book is the place you describe and document the space of possibilities you explored at each step of your project. We strongly advise you to include many visualizations in your process book.Your process book should include the following topics. Depending on your project type the amount of discussion you devote to each of them will vary:
# 
# > - **Overview and Motivation**: Provide an overview of the project goals and the motivation for it. Consider that this will be read by people who did not see your project proposal.
# 
# > - **Related Work**: Anything that inspired you, such as a paper, a web site, or something we discussed in class.
# 
# > - **Initial Questions**: What questions are you trying to answer? How did these questions evolve over the course of the project? What new questions did you consider in the course of your analysis? 
# 
# > - **Data**: Source, scraping method, cleanup, storage, etc.
# 
# > - **Exploratory Data Analysis**: What visualizations did you use to look at your data in different ways? What are the different statistical methods you considered? Justify the decisions you made, and show any major changes to your ideas. How did you reach these conclusions?
# 
# > - **Final Analysis**: What did you learn about the data? How did you answer the questions? How can you justify your answers?
# 
# > - **Presentation**: Present your final results in a compelling and engaging way using text, visualizations, images, and videos on your project web site.
# 
# >Describe the storytelling elements and goals in your process notebook and show us sketches and screenshots of different web site iterations. As this will be your only chance to describe your project in detail make sure that your process book is a standalone document that fully describes your process and results.
# 
# ### Final Products
# - **Code**: you've been graded all semester on this, just keep doing a great job at submitting clean code with comments
# - **Website**: make a *public website* (Github pages, Google sites, etc.), summarize the main results of your project and tell a story, **anyone** should be able to read this part of your project, link to your Process Notebook and Github repo. 
# - **Two-minute presentation**: Each team will create a **two minute** screencas (seriously, 2 minutes) with narration showing a demo of your iPython process book and/or some slides.  Upload to YouTube (or Vimeo) and **embed it into your project web page**. Focus on:
#     - main contributions rather than on technical details. 
#     - What do you feel is the best part of your project? 
#     - What insights did you gain? 
#     - What is the single most important thing you would like your audience to take away? 
#     - This should be **one of the first things** someone visiting your website should see.
# 
# ### Peer Assessment
# Remember, data science is an interdisciplinary field, you'll never work alone. It's important that everyone contributes and works well together. So we added this portion to get everyone thinking about teamwork early on.
# 
# > Peer assessment:
# > - **Preparation**: were they prepared during team meetings?
# > - **Contribution**: did they contribute productively to the team discussion and work?
# > - **Respect for others’ ideas**: did they encourage others to contribute their ideas?
# > - **Flexibility**: were they flexible when disagreements occurred?
# 
# ### Grading Criteria
# 
# > - **Project Scope** - Did you choose the appropriate complexity and level of difficulty of your project?
# > - **Process Book** - Did you follow the data science process and is it well documented in your process book?
# > - **Solution** - Is your analysis effective and correct in answering your intended questions?
# > - **Implementation** - What is the quality of your code? Is it appropriately polished, robust, and reliable?
# > - **Presentation** - Are your web site and screencast clear, engaging, and effective?
# > - **Peer Evaluations** - Your individual project score will also be influenced by your peer evaluations.
# 
# 

# 
# # Example: Food Inspection Forecasting
# 
# ## **HUGE NOTE:  Much of this is taken from the [food-inspections-evaluation](https://github.com/Chicago/food-inspections-evaluation) repository. It's publicly available, so if you're interested please check it out further.**
# 
# Some articles talking about the project:
#  - [Washington Post, September 28, 2014](https://www.washingtonpost.com/business/on-it/in-chicago-food-inspectors-are-guided-by-big-data/2014/09/27/96be8c68-44e0-11e4-b47c-f5889e061e5f_story.html)
#  - [Chicago Tribune, July 6, 2015](http://www.chicagotribune.com/business/ct-chicago-allstate-inspections-0703-biz-20150706-story.html)
# 
# Let's check out the website they built for their project (built with Gihub pages):
# 
# [<img src="./images/chicago_page.png">](http://chicago.github.io/food-inspections-evaluation/)
# 
# We're looking for some of the major elements we discussed above. 
# 
# Some questions about the webpage:
# 
# - Is the writing directed appropriately?
# - Motivation?
# - Do they link to their sources?
# 
# Goal: 
# > To forecast food establishments that are most likely to have critical violations so that they may be inspected first.
# 
# Main Result:
# > <img src="./images/main_result.png">
# 
# Data: 
# > https://data.cityofchicago.org/

# # Download the Data:
# 
# The entire analysis was done in R, I used their code to processed the data to the point where I could use it easily. See `Data-Processing.ipynb`. This is an ipython notebook that uses `R-magic`. If you don't know `R` you can just download the files with processed data into your lab directory.
# 
# **OR, just follow along without running the code**. Running the code isn't as important for this lab.
# 
# Download the following files (right-click -> "save file as"): (1-2) are important for running the model below, (1) is just for data exploration.
# 1. [Model Matrix](https://www.dropbox.com/s/t90lh34kuyt2byf/model_matrix.csv?dl=0)
# 2. [Outcome](https://www.dropbox.com/s/nj8jtuqisk74qj6/TARGET.csv)
# 3. [Food Inspections data (huge)](https://www.dropbox.com/s/6x1dcin3viwyumy/food_inspections.csv?dl=0)

# In[464]:


# special IPython command to prepare the notebook for matplotlib
get_ipython().magic(u'matplotlib inline')

import numpy as np
import pandas as pd
import scipy.stats as stats
import matplotlib.pyplot as plt
import sklearn
import statsmodels.api as sm

import seaborn as sns
sns.set_style("whitegrid")
sns.set_context("poster")

# special matplotlib argument for improved plots
from matplotlib import rcParams


# In[298]:


food = pd.read_csv('food_inspections.csv', sep=',')

print food.shape
food.head()


# ### Focus in on 2014 data

# In[418]:


get_ipython().run_cell_magic(u'time', u'', u"import dateutil.parser\nfood['year'] = [dateutil.parser.parse(x).year for x in food.Inspection_Date]")


# In[419]:


food2014 = food.loc[food['year'].values == 2014,]


# In[420]:


print food2014.shape
food2014.head()


# #### A breakdown of the inspection types in 2014:

# In[422]:


food2014.Inspection_Type.value_counts()


# #### A summary of the risk types appears below:

# In[423]:


food2014.Risk.value_counts()


# # Model Building
# ### Goal of the model
# > The principle question is whether we can reasonably determine the probability that a restaurant inspection will yield at least one critical violation.
# 
# Clearly this goal was refined with some experience handling this data, you'll have the same experience as you work with your data. 
# 
# 
# 
# Variable Name (Literal)                       | Variable Description
# ----------------------------------------------|---------------------------------
# `Inspectorblue`                               | Indicator variable for Sanitarian Cluster 1
# `Inspectorbrown`                              | Indicator variable for Sanitarian Cluster 2
# `Inspectorgreen`                              | Indicator variable for Sanitarian Cluster 3
# `Inspectororange`                             | Indicator variable for Sanitarian Cluster 4
# `Inspectorpurple`                             | Indicator variable for Sanitarian Cluster 5
# `Inspectoryellow`                             | Indicator variable for Sanitarian Cluster 6
# `pastCritical`                                | Indicates any previous critical violations (last visit)
# `pastSerious`                                 | Indicates any previous serious violations (last visit)
# `timeSinceLast`                               | Elapsed time since previous inspection
# `ageAtInspection`                             | Age of business license at the time of inspection
# `consumption_on_premises_incidental_activity` | Presence of a license for consumption / incidental activity
# `tobacco_retail_over_counter`                 | Presence of an additional license for tobacco sales
# `temperatureMax`                              | The daily high temperature on the day of inspection
# `heat_burglary`                               | Local intensity of recent burglaries
# `heat_sanitation`                             | Local intensity of recent sanitation complaints
# `heat_garbage`                                | Local intensity of recent garbage cart requests
# 
# 
# 
# ## Elastic Net Regularized Lostic Regression
# 
# #### Recall: Logistic Regression with Lasso
# We've seen Logistic regression with the Lasso penalty, a form of regularization and variable selection. As a reminder, the Logistic regression with Lasso minimizes the equation:
# 
# $$
# \min_{(\beta_0, \beta) \in \mathbb{R}^{p+1}} -\left[\frac{1}{N} \sum_{i=1}^N y_i \cdot (\beta_0 + x_i^T \beta) - \log (1+e^{(\beta_0+x_i^T \beta)})\right] + \alpha\ ||\beta||_1
# $$
# 
# We're essentially looking for solutions $(\beta_0, \beta)$ that are **small** in terms of the $L_1$ norm. We've also seen Ridge regression, another type of regularization, essentially the same but with $\lambda\ ||\beta||_2^2$ instead of the $L_1$ norm. 
# 
# 
# ####  Elastic Net Regularized Logistic Regression
# For the final model they decided to use Elastic Net regularization on a logistic regression. This is essentially a combination of Lasso and Ridge regularization, you can see it below in the formulation. 
# 
# >$$
# \begin{aligned}
# \log = \frac{\text{Pr}(V=1|X=x)}{\text{Pr}(V=0|X=x)} = \beta_0 + \beta^T x
# \end{aligned}
# $$
# 
# >Thus, the objective function is to minimize 
# >
# $$
# \begin{aligned}
# \min_{(\beta_0, \beta) \in \mathbb{R}^{p+1}} -\left[\frac{1}{N} \sum_{i=1}^N y_i \cdot (\beta_0 + x_i^T \beta) - \log (1+e^{(\beta_0+x_i^T \beta)})\right] + \alpha (1-\lambda)||\beta||_2^2/2 + \alpha\lambda||\beta||_1
# \end{aligned}
# $$
# 
# In our code $\lambda =$ `l1_ratio`, and an $\alpha$ range is determined by `eps`, see the [documentation](http://scikit-learn.org/stable/modules/generated/sklearn.linear_model.ElasticNet.html) for more details. 
# 
# **Note: They didn't justify their use of this model. We know that prediction is their end-goal. I would like to know what other methods they tried or if they have a specific reason for using this model**

# In[357]:


mm = pd.read_csv('model_matrix.csv', sep=',')
X = mm.values.astype(np.double)
y = pd.read_csv('TARGET.csv', sep=',').values.astype(np.double).transpose()[0]


# In[358]:


from sklearn.linear_model import lasso_path, enet_path
eps = 5e-6  # the smaller it is the longer is the path


# In[463]:


get_ipython().run_cell_magic(u'time', u'', u'print("Computing regularization path using the lasso...")\nalphas_lasso, coefs_lasso, _ = lasso_path(X, y, eps, fit_intercept=False)\n\nprint("Computing regularization path using the elastic net...")\nalphas_enet, coefs_enet, _ = enet_path(X, y, eps=eps, l1_ratio=0.8, fit_intercept=False)')


# In[366]:


# Color Palette, seaborn has the best colors i.m.o.
col = sns.color_palette("husl", 16)

# make the lasso path
plt.figure(1)
ax = plt.gca()
ax.set_color_cycle(col)
l1 = plt.plot(-np.log10(alphas_lasso), coefs_lasso.T)
l2 = plt.plot(-np.log10(alphas_enet), coefs_enet.T, linestyle='--')
plt.xlim([1, 4])

plt.xlabel('-log(alpha)')
plt.ylabel('coefficients')
plt.title('Lasso and Elastic-Net Paths')
plt.legend((l1[-1], l2[-1]), ('Lasso', 'Elastic-Net'), loc='lower left')


# In[465]:


# subset variables with large coefficients
# selected somewhat arbitrarily, could do something better here.

# show all coefficients
# keep = np.ones(16, dtype=bool)
# show only if sum of coefficients larger than something
# keep = np.abs(coefs_enet.T.sum(axis = 0)) > 0.5
# show only if least shrunk coefficient larger than something
keep = np.abs(coefs_enet.T[99,:]) > 0.05


# In[466]:


# Color Palette, seaborn has the best colors i.m.o.
col = sns.color_palette("hls", keep.sum())

plt.figure(1)
ax = plt.gca()
ax.set_color_cycle(col)
l2 = plt.plot(-np.log10(alphas_enet), coefs_enet.T[:,keep])
plt.xlim([1, 4])

plt.xlabel('-log(alpha)')
plt.ylabel('coefficients')
plt.title('Elastic-Net Paths (largest coefficients)')
plt.legend(l2, list(mm.columns.values[keep]), loc='upper left')


# ## Reading Path Charts
# Both Lasso and Elastic Net regularization have the property that with enough regularization (large $\alpha$) (or small $-log(\alpha)$ on the chart) the coefficients ($\hat\beta_0, \hat\beta_1, ..., \hat\beta_p$) get shrunk to 0. That means they're no longer playing a role in the prediction! Recall:
# 
# $$\hat y_i = \frac{exp(\hat\beta_0 + \hat\beta_1 X_{i1} + ... + \hat\beta_p X_{ip})}{1 + exp(\hat\beta_0 + \hat\beta_1 X_{i1} + ... + \hat\beta_p X_{ip})}$$
# 
# First let's notice that the `Inspector*` variables are all present, except for one -- `InspectorYellow` is missing, but it's easy to see that it wouldn't be informative at all. Simply knowing that the region wasn't any of (`blue`, `brown`, ..., `purple`) will tell you that the inspection was in `yellow`. So the regularization does a good job at getting rid of this redundant information. 
# 
# What this means for us is that we can look at a chart like the one above and see that (from left to right) the first variable to enter the model is `InspectorBlue`, `InspectorPurple`, etc. 
# 
# Other main findings they gathered from this chart:
# 
# > - Establishments that had previous critical or serious violations
# > - Whether the establishment has a tobacco license or has an incidental alcohol consumption license
# 

# # Model Validation/testing
# The super impressive thing about this analysis (to me) is their way of testing their results. 
# 
# The discovery of a critical violation is a time-sensitive issue! The earlier an inspector can find these critical violations the better. So instead of just looking at things like accuracy, f1 score, etc. they looked for a way of vallidating the model within the contect of the problem. Here's how:
# 
# - They used the data before **July 31, 2014** to fit the model. 
# - They selected a model parameters using **August 1-31, 2014** as a tuning dataset.
# - They used the model to predict critical violations in the 1,637 food establishments that were scheduled for **September 1, 2014 to October 31, 2014**. 
# - Based on the predictions they could create a schedule of inspections that would hopefully yield a higher number of critical violations earlier.
# - They then let the inspectors go on about their business, reposting critical violations as they do.
# - At the end of the month, they compared what happened to what `could have happened` if they used the schedule based on predictions.
# 
# > After formulating the analytical model, the the principal question for researchers turned to whether this analytical model provides more efficiency for the food inspection team. CDPH operational procedures requires the department to inspect every risk 1 and risk 2 restaurant. Therefore, the operational goal is to allow inspectors to discover critical violations earlier than their current operations (business-as-usual).

# # Results:
# ## Taken from [Report](https://github.com/Chicago/food-inspections-evaluation/blob/master/REPORTS/forecasting-restaurants-with-critical-violations-in-Chicago.pdf)
# <img src="./images/days.png">
# <img src="./images/cumulative1.png">
# <img src="./images/efficiency.png">
# <img src="./images/cumulative2.png">
# 

# # Some further notes:
# 
# - Further inspection of their code revealed a very detailed analysis, the selected their tuning parameters using a validation set. 
# - Due to the ongoing nature of the problem, it makes sense to validate on only the latest data.
# - Further exploration in terms of models could show some improvement.
# - The writeup contained lots more analysis and information than the website for those who are interested.
# 
# # MORE PROJECTS:
# You'll see some previous projects that we thought were also exceptional:
# http://cs109.github.io/2014/pages/projects.html
# 
# - Ale Augur: Quantifying and Predicting Beer Preference with the Untapped API by Ian Nightingale, Alexander Jaffe and Brian Mendel ([Website](http://beer.iandnightingale.com/), [Screencast](https://www.youtube.com/watch?v=J6Svwwetaj8))
# - ClimbRec by Amy Skerry ([Website](http://mindhive.mit.edu/saxe/cs109proj/), [Screencast](https://www.youtube.com/watch?v=41BG2z9SbMg&feature=youtu.be))
# - The Green Canvas by Ahmed Hosny, Jili Huang and Yingyi Wang ([Website](http://ahmedhosny.github.io/theGreenCanvas/), [Screencast](http://vimeo.com/114379373))
# - Predicting Citation Counts of arXiv Papers by Marion Dierickx, George Miller, Sam Sinai and Stephen Portillo ([Website](https://sites.google.com/site/teamcitations/), [Screencast](http://youtu.be/bjAcHu8JRG0))
# - Improving University Energy Efficiency: Building Energy Demand Prediction by Wen Xie, Wette Constant and Bin Yan ([Website](http://cs109-energy.github.io/), [Screencast](http://youtu.be/JiAQxctOntQ))
# - Predicting AirBnb Success by Enrique Dominguez-Meneses, Jameson Rogers, Noah Taylor and Muhammed Yildiz ([Website](http://hamelsmu.github.io/AirbnbScrape/), [Screencast](https://www.youtube.com/watch?v=raGjUj5qArc))
# 
# Some of the screencasts are down, but the webpages are still up!
