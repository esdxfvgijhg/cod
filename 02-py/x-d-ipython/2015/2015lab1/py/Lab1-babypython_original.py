#!/usr/bin/env python
# coding: utf-8

# # Python and Friends
# 
# This is a very quick run-through of some python syntax

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


# ##The Python Language
# 
# Lets talk about using Python as a calculator...

# In[2]:


1+2


# Notice integer division and floating-point error below!

# In[3]:


1/2,1.0/2.0,3*3.2


# Here is how we can print things. Something on the last line by itself is returned as the output value.

# In[4]:


print 1+3.0,"\n",5/3.0
5/3


# We can obtain the type of a variable, and use boolean comparisons tontest these types.

# In[5]:


a=5.0/6.0
print(a)
print type(a)


# In[6]:


import types
type(a)==types.FloatType


# In[7]:


type(a)==types.IntType


# ## Python and Iteration (and files)
# 
# In working with python I always remember: a python is a duck.
# 
# What I mean is, python has a certain way of doing things. For example lets call one of these ways listiness. Listiness works on lists, dictionaries, files, and a general notion of something called an iterator.
# 
# But first, lets introduce the notion of a comprehension. Its a way of constructing a list

# In[8]:


alist=[1,2,3,4,5]
asquaredlist=[i*i for i in alist]
asquaredlist


# Python has some nifty functions like `enumerate` and `zip`. The former gives a list of tuples with each tuple of the form `(index, value)`, while the latter takes elements from each list and outs them together into a tuple, thus creating a list of tuples. The first is a duck, but the second isnt.

# In[9]:


enumerate(asquaredlist),zip(alist, asquaredlist)


# Someone realized that design flaw and created izip.

# In[10]:


from itertools import izip
izip(alist, asquaredlist)


# In[11]:


print enumerate(asquaredlist)


# In[12]:


[k for k in enumerate(asquaredlist)]


# Open files behave like lists too! Here we get each line in the file and find its length, using the comprehension syntax to put these lengths into a big list.

# In[13]:


linelengths=[len(line) for line in open("hamlet.txt")]#poor code as we dont close the file
print linelengths


# In[14]:


sum(linelengths), np.mean(linelengths), np.median(linelengths), np.std(linelengths)


# But perhaps we want to access Hamlet word by word and not line by line

# In[15]:


hamletfile=open("hamlet.txt")
hamlettext=hamletfile.read()
hamletfile.close()
hamlettokens=hamlettext.split()#split with no arguments splits on whitespace
len(hamlettokens)


# One can use the `with` syntax which cretaes a context. The file closing is then done automatically for us.

# In[15]:


with open("hamlet.txt") as hamletfile:
    hamlettext=hamletfile.read()
    hamlettokens=hamlettext.split()
    print len(hamlettokens)


# There are roughly 32,000 words in Hamlet.

# ###The indexing of lists

# In[44]:


print hamlettext[:1000]#first 1000 characters from Hamlet.


# In[45]:


print hamlettext[-1000:]#and last 1000 characters from Hamlet.


# Lets split the word tokens. The first one below reads, give me the second, third, and fourth words (remember that python is 0 indexed). Try and figure what the others mean.

# In[16]:


print hamlettokens[1:4], hamlettokens[:4], hamlettokens[0], hamlettokens[-1]


# In[17]:


hamlettokens[1:8:2]#get every 2nd world between the 2nd and the 9th: ie 2nd, 4th, 6th, and 8th


# range and xrange get the list of integers upto N. But xrange behaves like an iterator. The reason for this is that there is no point generaing all os a million integers. We can just add 1 to the previous one and save memory. So we trade off storage for computation.

# In[18]:


mylist=[]
for i in xrange(10):
    mylist.append(i)
mylist


# ## Dictionaries
# 
# These are the bread and butter. You will use them a lot. They even duck like lists. But be careful how.

# In[19]:


adict={'one':1, 'two': 2, 'three': 3}
print [i for i in adict], [(k,v) for k,v in adict.items()], adict.values()


# The keys do not have to be strings. From python 2.7 you can use dictionary comprehensions as well

# In[20]:


mydict ={k:v for (k,v) in zip(alist, asquaredlist)}
mydict


# You can construct then nicely using the function `dict`.

# In[46]:


dict(a=1, b=2)


# ###and conversion to json

# In[21]:


import json


# In[22]:


s=json.dumps(mydict)
print s


# In[23]:


json.loads(s)


# ## Strings
# 
# Basically they behave like immutable lists

# In[24]:


lastword=hamlettokens[-1]
print(lastword)


# In[25]:


lastword[-2]="k"#cant change a part of a string


# In[26]:


lastword[-2]


# In[ ]:


You can join a list with a separator to make a string.


# In[27]:


wierdstring=",".join(hamlettokens)
wierdstring[:1000]


# ## Functions
# 
# Functions are even more the bread and butter. You'll see them as methods on objects, or standing alone by themselves.

# In[28]:


def square(x):
    return(x*x)
def cube(x):
    return x*x*x
square(5),cube(5)


# In[29]:


print square, type(cube)


# In Python, functions are "first-class". This is just a fancy way of saying, you can pass functions to other functions

# In[47]:


def sum_of_anything(x,y,f):
    print x,y,f
    return(f(x) + f(y))
sum_of_anything(3,4,square)


# Python functions can have positional arguments and keyword arguments. Positional arguments are stored in a tuple, and keyword arguments in a dictionary. Note the "starred" syntax

# In[50]:


def f(a,b,*posargs,**dictargs):
    print "got",a,b,posargs, dictargs
    return a
print f(1,3)
print f(1,3,4,d=1,c=2)


# >**YOUR TURN** create a dictionary with keys the integers upto and including 10, and values the cubes of these dictionaries

# In[ ]:


#your code here


# ##Booleans and Control-flow
# 
# Lets test for belonging...

# In[32]:


a=[1,2,3,4,5]
1 in a


# In[33]:


6 in a


# Python supports if/elif/else clauses for multi-way conditionals

# In[34]:


def do_it(x):
    if x==1:
        print "One"
    elif x==2:
        print "Two"
    else:
        print x
do_it(1)


# In[35]:


do_it(2), do_it(3)


# You can `break` out of a loop based on a condition. The loop below is a for loop.

# In[36]:


for i in range(10):
    print i
    if (i > 5):
        break


# While loops are also supported. `continue` continues to the next iteration of the loop skipping all the code below, while `break` breaks out of it.

# In[37]:


i=0
while i < 10:
    print i
    i=i+1
    if i < 5:
        continue
    else:
        break


# ## Exceptions
# 
# This is the way to catch errors.

# In[38]:


try:
    f(1)#takes atleast 2 arguments
except:
    import sys
    print sys.exc_info()


# ## All together now
# 
# Lets see what hamlet gives us. We convert all words to lower-case

# In[39]:


hamletlctokens=[word.lower() for word in hamlettokens]
hamletlctokens.count("thou")


# We then find a unique set of words using python's `set` data structure. We count how often those words occured usinf the `count` method on lists.

# In[52]:


uniquelctokens=set(hamletlctokens)


# In[41]:


tokendict={}
for ut in uniquelctokens:
    tokendict[ut]=hamletlctokens.count(ut)


# We find the 100 most used words...

# In[42]:


L=sorted(tokendict.iteritems(), key= lambda (k,v):v, reverse=True)[:100]
L


# Lets get the top 20 of this and plot a bar chart!

# In[43]:


topfreq=L[:20]
print topfreq
pos = np.arange(len(topfreq))
plt.bar(pos, [e[1] for e in topfreq]);
plt.xticks(pos+0.4, [e[0] for e in topfreq]);

