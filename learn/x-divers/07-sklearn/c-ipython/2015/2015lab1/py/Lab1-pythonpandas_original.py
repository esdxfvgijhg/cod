#!/usr/bin/env python
# coding: utf-8

# #Lab 1. An Introduction to Pandas and Python

# In[1]:


# The %... is an iPython thing, and is not part of the Python language.
# In this case we're just telling the plotting library to draw things on
# the notebook, instead of on a separate window.
get_ipython().magic(u'matplotlib inline')
#this line above prepares IPython notebook for working with matplotlib

# See all the "as ..." contructs? They're just aliasing the package names.
# That way we can call methods like plt.plot() instead of matplotlib.pyplot.plot().

import numpy as np # imports a fast numerical programming library
import scipy as sp #imports stats functions, amongst other things
import matplotlib as mpl # this actually imports matplotlib
import matplotlib.cm as cm #allows us easy access to colormaps
import matplotlib.pyplot as plt #sets up plotting under plt
import pandas as pd #lets us handle data as dataframes
#sets up pandas table display
pd.set_option('display.width', 500)
pd.set_option('display.max_columns', 100)
pd.set_option('display.notebook_repr_html', True)
import seaborn as sns #sets up styles and gives us more plotting options


# Python depends on packages for most of its functionality; these can be either built-in (such as sys), or third-party (like all the packages below). Either way you need to import the packages you need before using them.

# ##The Notebook
# 
# Look up http:/www.google.com Lets eat a burrito. $\alpha = \frac{\beta}{\gamma}$
# 
# Longer:
# 
# $$\alpha = \frac{\beta}{\gamma}$$
# 
# 1. an item
# 2. another item
# 3. i like items

# ##Pandas

# Get Cheatsheet:
# 
# from https://drive.google.com/folderview?id=0ByIrJAE4KMTtaGhRcXkxNHhmY2M&usp=sharing
# 
# 
# We read in some data from a CSV file. CSV files can be output by any spreadsheet software, and are plain text, so make a great way to share data. This dataset is from Goodreads: i scraped the highest regarded (according to Goodread's proprietary algorithm) books on that site. Ypu'll see how to do such a scraping in the next lab.

# In[2]:


df=pd.read_csv("all.csv", header=None,
               names=["rating", 'review_count', 'isbn', 'booktype','author_url', 'year', 'genre_urls', 'dir','rating_count', 'name'],
)
df.head()


# Notice we have a table! A spreadsheet! And it indexed the rows. Pandas (borrowing from R) calls it a DataFrame. Lets see the types of the columns...
# 
# `df`, in python parlance, is an **instance** of the `pd.DataFrame` class, created by calling the `pd.read_csv` function, which cllas the DataFrame constructor inside of it. If you dont understand this sentence, dont worry, it will become clearer later. What you need to take away is that `df` is a dataframe object, and it has **methods**, or functions belonging to it, which allow it to do things. For example `df.head()` is a method that shows the first 5 rows of the dataframe.
# 
# ![](files/pandastruct.png)
# 
# ###The basics

# In[3]:


df.dtypes


# The shape of the object is:

# In[4]:


df.shape


# 6000 rows times 10 columns. A spredsheet is a table is a matrix. How can we access members of this **tuple** (brackets like so:() )

# In[5]:


df.shape[0], df.shape[1]


# These are the column names.

# In[6]:


df.columns


# As the diagram above shows, pandas considers a table (dataframe) as a pasting of many "series" together, horizontally.

# In[7]:


type(df.rating), type(df)


# ###Querying
# 
# A spreadsheet is useless if you cant dice/sort/etc it. Here we look for all books with a rating less than 3. 

# In[8]:


df.rating < 3


# This gives us `True`s and `False`s. Such a series is called a mask. If we count the number of `True`s, and divide by the total, we'll get the fraction of ratings $\lt$ 3. To do this numerically see this:

# In[9]:


np.sum(df.rating < 3)


# Why did that work?

# In[10]:


print 1*True, 1*False


# So we ought to be able to do this

# In[11]:


np.sum(df.rating < 3)/df.shape[0]


# But we get a 0? Why? In Python 2.x division is **integer division** by default. So one can fix by converting the `df.shape[0]` to a float

# In[12]:


np.sum(df.rating < 3)/float(df.shape[0])


# Notice that you could just find the average since the `True`s map to 1s.

# In[15]:


np.mean(df.rating < 3.0)


# Or directly, in Pandas, which works since `df.rating < 3` is a pandas Series.

# In[16]:


(df.rating < 3).mean()


# ###Filtering
# 
# Here are two ways to get a filtered dataframe

# In[22]:


df.query("rating > 4.5")


# Here we create a mask and use it to "index" into the dataframe to get the rows we want.

# In[37]:


df[df.year < 0]


# If you want to combine these conditions, use the second form and put '()' brackets around each condition. The query uses a boolean AND. Each condition ceates a mask of trues and falses.

# In[19]:


df[(df.year < 0) & (df.rating > 4)]#there were none greater than 4.5!


# ###Cleaning

# We first check the datatypes. Notice that `review_count`, `rating_count` are of type `object` (which means they are either strings or Pandas couldnt figure what they are), while `year` is a float.

# In[20]:


df.dtypes


# Suppose we try and fix this

# In[21]:


df['rating_count']=df.rating_count.astype(int)
df['review_count']=df.review_count.astype(int)
df['year']=df.year.astype(int)


# Oppos we got an error. Something is not right. Its trying to convert some python datatype: `None` into an int. This usually means data was missing. Was it?

# In[22]:


df[df.year.isnull()]


# Aha, we had some incomplete data. Lets get rid of it

# In[23]:


df = df[df.year.notnull()]
df.shape


# We removed those 7 rows. Lets try the type conversion again

# In[26]:


df['rating_count']=df.rating_count.astype(int)
df['review_count']=df.review_count.astype(int)
df['year']=df.year.astype(int)


# In[27]:


df.dtypes


# Much cleaner now!

# ###Visualizing
# 
# Pandas has handy built in visualization.

# In[23]:


df.rating.hist();


# We can do this in more detail, plotting against a mean, with cutom binsize or number of bins. Note how to label axes and create legends.

# In[24]:


sns.set_context("notebook")
meanrat=df.rating.mean()
#you can get means and medians in different ways
print meanrat, np.mean(df.rating), df.rating.median()
with sns.axes_style("whitegrid"):
    df.rating.hist(bins=30, alpha=0.4);
    plt.axvline(meanrat, 0, 0.75, color='r', label='Mean')
    plt.xlabel("average rating of book")
    plt.ylabel("Counts")
    plt.title("Ratings Histogram")
    plt.legend()
    #sns.despine()


# One can see the sparseness of review counts. This will be important when we learn about recommendations: we'll have to *regularize* our models to deal with it.

# In[34]:


df.review_count.hist(bins=np.arange(0, 40000, 400))


# The structure may be easier to see if we rescale the x-axis to be logarithmic.

# In[35]:


df.review_count.hist(bins=100)
plt.xscale("log");


# Here we make a scatterplot in matplotlib of rating against year. By setting the alpha transparency low we can how the density of highly rated books on goodreads has changed.

# In[38]:


plt.scatter(df.year, df.rating, lw=0, alpha=.08)
plt.xlim([1900,2010])
plt.xlabel("Year")
plt.ylabel("Rating")


# ###Pythons and ducks
# 
# Notice that we used the series in the x-list and y-list slots in the `scatter` function in the `plt` module.
# 
# In working with python I always remember: a python is a duck.
# 
# What I mean is, python has a certain way of doing things. For example lets call one of these ways listiness. Listiness works on lists, dictionaries, files, and a general notion of something called an iterator.
# 
# A Pandas series plays like a python list:

# In[28]:


alist=[1,2,3,4,5]


# We can construct another list by using the syntax below, also called a list comprehension.

# In[29]:


asquaredlist=[i*i for i in alist]
asquaredlist


# And then we can again make a scatterplot

# In[30]:


plt.scatter(alist, asquaredlist);


# In[31]:


print type(alist)


# In other words, something is a duck if it quacks like a duck. A Pandas series quacks like a python list. They both support something called the iterator protocol, an notion of behaving in a "listy" way. And Python functions like `plt.scatter` will accept anything that behaves listy. Indeed here's one more example:

# In[34]:


plt.hist(df.rating_count.values, bins=100, alpha=0.5);


# In[35]:


print type(df.rating_count), type(df.rating_count.values)


# Series and numpy lists behave similarly as well.
# 
# 
# ### Vectorization
# 
# Numpy arrays are a bit different from regular python lists, and are the bread and butter of data science. Pandas Series are built atop them. 

# In[36]:


alist + alist


# In[37]:


np.array(alist)


# In[38]:


np.array(alist)+np.array(alist)


# In[39]:


np.array(alist)**2


# In other words, operations on numpy arrays, and by extension, Pandas Series, are **vectorized**. You can add two numpy lists by just using `+` whereas the result isnt what you might expect for regular python lists. To add regular python lists elementwise, you will need to use a loop:

# In[40]:


newlist=[]
for item in alist:
    newlist.append(item+item)
newlist


# **Vectorization** is a powerful idiom, and we will use it a lot in this class. And, for almost all data intensive computing, we will use numpy arrays rather than python lists, as the python numerical stack is based on it. 
# 
# You have seen this in idea in spreadsheets where you add an entire column to another one.
# 
# Two final examples

# In[41]:


a=np.array([1,2,3,4,5])
print type(a)
b=np.array([1,2,3,4,5])

print a*b


# In[42]:


a+1

