#!/usr/bin/env python
# coding: utf-8

# # Homework 0

# ##Survey due 4th September, 2015

# ##Submission due 10th September, 2015

# ---
# 
# Welcome to CS109 / STAT121 / AC209 / E-109 (http://cs109.org/).  In this class, we will be using a variety of tools that will require some initial configuration. To ensure everything goes smoothly moving forward, we will setup the majority of those tools in this homework. **It is very important that you do this setup as soon as possible**. While some of this will likely be dull, doing it now will enable us to do more exciting work in the weeks that follow without getting bogged down in further software configuration. You will also be filling out a **mandatory class survey and creating a github and AWS account, which are mandatory as well**. 
# 
# Please note that the **survey is due on September 4th**. The reason is that we need your github account name to set you up for the homework submission system. If you do not submit the survey on time you might not be able to submit the homework in time.
# 
# This homework will not be graded, however, you **must submit it**. Submission instructions, along with the github flow for homework, are at the end of this notebook. The practice you will get submitting this homework will be essential for the submission of the forthcoming homework notebooks and your project.

# #Table of Contents
# * [Homework 0](#Homework-0)
# 	* [Survey due 4th September, 2015](#Survey-due-4th-September,-2015)
# 	* [Submission due 10th September, 2015](#Submission-due-10th-September,-2015)
# 	* [First Things](#First-Things)
# 		* [1. Create your github account](#1.-Create-your-github-account)
# 		* [2. Class Survey](#2.-Class-Survey)
# 		* [3. Piazza](#3.-Piazza)
# 		* [4. Programming expectations](#4.-Programming-expectations)
# 		* [5. If you do not have a .edu email address](#5.-If-you-do-not-have-a-.edu-email-address)
# 	* [Getting and installing Python](#Getting-and-installing-Python)
# 		* [Installing Anaconda](#Installing-Anaconda)
# 		* [Mac/Linux users](#Mac/Linux-users)
# 		* [Windows Users](#Windows-Users)
# 		* [Troubleshooting](#Troubleshooting)
# 	* [Setting up your git environment](#Setting-up-your-git-environment)
# 		* [1. Installing git](#1.-Installing-git)
# 			* [Windows specific notes](#Windows-specific-notes)
# 			* [Mac specific notes](#Mac-specific-notes)
# 		* [2. Optional: Creating ssh keys on your machine](#2.-Optional:-Creating-ssh-keys-on-your-machine)
# 		* [3.  Optional: Uploading ssh keys and Authentication](#3.--Optional:-Uploading-ssh-keys-and-Authentication)
# 		* [4. Setting global config for git](#4.-Setting-global-config-for-git)
# 		* [5. Github tutorial](#5.-Github-tutorial)
# 	* [Sign up for AWS](#Sign-up-for-AWS)
# 		* [1. Get an AWS account](#1.-Get-an-AWS-account)
# 		* [2. Sign up for AWS educate](#2.-Sign-up-for-AWS-educate)
# 	* [Hello, Python](#Hello,-Python)
# 	* [Python Libraries](#Python-Libraries)
# 		* [Installing additional libraries](#Installing-additional-libraries)
# 		* [Testing latest libraries](#Testing-latest-libraries)
# 	* [Kicking the tires](#Kicking-the-tires)
# 		* [Hello World](#Hello-World)
# 		* [Hello matplotlib](#Hello-matplotlib)
# 		* [Hello Numpy](#Hello-Numpy)
# 	* [The Monty Hall Problem](#The-Monty-Hall-Problem)
# 	* [The workflow for homeworks and labs](#The-workflow-for-homeworks-and-labs)
# 		* [getting and working on labs](#getting-and-working-on-labs)
# 		* [getting and submitting homework](#getting-and-submitting-homework)
# 

# ##First Things

# I cant stress this enough: **Do this setup now!**
# 
# These first things are incredibly important. You must absolutely fill these out to get into the swing of things...

# ###1. Create your github account

# If you do not have a github account as yet, create it at:

# https://github.com
# 
# This step is **mandatory**. We will need your github username. We are using github for all aspects of this course, including
# 
# - doing and submitting homework
# - collaborating on your project
# - creating your web site

# To sign up for an account, just go to [github](https://github.com) and pick a unique username, an email address, and a password. Once you've done that, your github page will be at https://github.com/your-username.
# 
# Github also provides a student [developer package](https://education.github.com/pack). This is something that might be nice to have, but it is not necessary for the course. Github may take some time to approve your application for the package. Please note that this is optional and you do not have to have the package approved to fill out the survey. 

# ###2. Class Survey

# Next, you **must complete the mandatory** course survey located [here](http://goo.gl/forms/bJwajS8zO8). It should only take a few moments of your time. Once you fill in the survey we will use the github username you provided to sign you up into the `cs109-students` organization on github. (see https://help.github.com/articles/how-do-i-access-my-organization-account/) It is imperative that you fill out the survey on time as we use the provided information to sign you in: your access to the homework depends on being in this organization. 

# ###3. Piazza

# Go to [Piazza](https://piazza.com/harvard/fall2015/cs109/home) and sign up for the class using your Harvard e-mail address. If you do not have a Harvard email address write an email to staff@cs109.org and one of the TFs will sign you up.
# 
# You will use Piazza as a forum for discussion, to find team members, to arrange appointments, and to ask questions. Piazza should be your primary form of communication with the staff. Use the staff e-mail (staff@cs109.org) only for individual requests, e.g., to excuse yourself from mandatory sections. All announcements, homework, and project descriptions will be posted on Piazza first. 
# 
# **Introduction**
# 
# Once you are signed up to the Piazza course forum, introduce yourself to your classmates and course staff with a follow-up post in the introduction thread. Include your name/nickname, your affiliation, why you are taking this course, and tell us something interesting about yourself (e.g., an industry job, an unusual hobby, past travels, or a cool project you did, etc.). Also tell us whether you have experience with data science.

# ###4. Programming expectations

# All the assignments and labs for this class will use Python and, for the most part, the browser-based IPython notebook format you are currently viewing. Knowledge of Python is not a prerequisite for this course, **provided you are comfortable learning on your own as needed**. While we have strived to make the programming component of this course straightforward, we will not devote much time to teaching prorgramming or Python syntax. Basically, you should feel comfortable with:
# 
# * How to look up Python syntax on Google and StackOverflow.
# * Basic programming concepts like functions, loops, arrays, dictionaries, strings, and if statements.
# * How to learn new libraries by reading documentation.
# * Asking questions on StackOverflow or Piazza.
# 
# There are many online tutorials to introduce you to scientific python programming. [Here is a course](https://github.com/jrjohansson/scientific-python-lectures) that is very nice. Lectures 1-4 of this course are most relevant to this class. While we will cover some python programming in labs 1 and 2, we expect you to pick it up on the fly. 

# ###5. If you do not have a .edu email address

# Please get one, as you will need it to sign up for AWS educate, and if you want to sign up for the student developer github package you will need it as well. As a DCE student you are eligible for a FAS account and you can sign up [here](http://www.extension.harvard.edu/resources-policies/resources/computer-e-mail-services).

# ## Getting and installing Python

# You will be using Python throughout the course, including many popular 3rd party Python libraries for scientific computing. [Anaconda](http://continuum.io/downloads) is an easy-to-install bundle of Python and most of these libraries. We **strongly** recommend that you use Anaconda for this course. If you insist on using your own Python setup instead of Anaconda, we will not provide any installation support, and are not responsible for you loosing points on homework assignments in case of inconsistencies. 
# 
# For this course we are using **Python 2**, not **Python 3**.
# 
# Also see: http://docs.continuum.io/anaconda/install
# 
# The **IPython** or **Jupyter** notebook runs in the browser, and works best in Google Chrome or Safari for me. You probably want to use one of these for assignments in this course.

# ### Installing Anaconda

# The Anaconda Python distribution is an easily-installable bundle of Python and many of the libraries used throughout this class. Unless you have a good reason not to, we recommend that you use Anaconda.

# ### Mac/Linux users

# 1. Download the [appropriate version](http://continuum.io/downloads) of Anaconda
# 1. Follow the instructions on that page to run the installer
# 1. Test out the IPython notebook: open a Terminal window, and type `ipython notebook`. Or use the Anaconda Launcher which might have been deposited on your desktop. A new browser window should pop up. 
# 1. Click `New Notebook` to create a new notebook file. **Trick**: give this notebook a unique name, like `my-little-rose`. Use Spotlight (upper right corner of the mac desktop, looks like a maginifier) to search for this name. In this way, you will know which folder your notebook opens in by default.

# ### Windows Users

# 1. Download the [appropriate version](http://continuum.io/downloads) of Anaconda
# 1. Follow the instructions on that page to run the installer. This will typically create a directory at `C:\Anaconda`
# 1. Test it out: start the Anaconda launcher, which you can find in `C:\Anaconda` or, in the Start menu. Start the IPython notebook. A new browser window should open. 
# 1. Click `New Notebook`, which should open a new page. **Trick**: give this notebook a unique name, like `my-little-rose`. Use Explorer (usually start menu on windows desktops) to search for this name. In this way, you will know which folder your notebook opens in by default.
# 
# If you did not add Anaconda to your path, be sure to use the full path to the python and ipython executables, such as `/anaconda/bin/python`.
# 
# If you already have installed Anaconda at some point in the past, you can easily update to the latest Anaconda version by updating conda, then Anaconda as follows:
# 
# ```
# conda update conda
# conda update anaconda
# ```

# ###Troubleshooting

# You must be careful to make sure you are running the Anaconda version of python, since those operating systems come preinstalled with their own versions of python.

# In[1]:


import sys
print sys.version


# **Problem**
# When you start python, you don't see a line like `Python 2.7.5 |Anaconda 1.6.1 (x86_64)|`. You are using a Mac or Linux computer
# 
# **Reason**
# You are most likely running a different version of Python, and need to modify your Path (the list of directories your computer looks through to find programs). 
# 
# **Solution**
# Find a file like `.bash_profile`, `.bashrc`, or `.profile`. Open the file in a text editor, and add a line at this line at the end: `export PATH="$HOME/anaconda/bin:$PATH"`. Close the file, open a new terminal window, type `source ~/.profile` (or whatever file you just edited). Type `which python` -- you should see a path that points to the anaconda directory. If so, running `python` should load the proper version
# 
# If this doesn't work (typing `which python` doesn't point to anaconda), you might be using a different shell. Type `echo $SHELL`. If this isn't `bash`, you need to edit a different startup file (for example, if if `echo $SHELL` gives `$csh`, you need to edit your `.cshrc` file. The syntax for this file is slightly different: `set PATH = ($HOME/anaconda/bin $PATH)`
# ***
# 
# **Problem**
# You are running the right version of python (see above item), but are unable to import numpy. 
# 
# **Reason**
# You are probably loading a different copy of numpy that is incompatible with Anaconda
# 
# **Solution**
# See the above item to find your `.bash_profile`, `.profile`, or `.bashrc` file. Open it, and add the line `unset PYTHONPATH` at the end. Close the file, open a new terminal window, type `source ~/.profile` (or whatever file you just edited), and try again.
# ***
# 
# **Problem**
# Under Windows, you receive an error message similar to the following: "'pip' is not recognized as an internal or external command, operable program or batch file."
# 
# **Reason**
# The correct Anaconda paths might not be present in your PATH variable, or Anaconda might not have installed correctly.
# 
# **Solution**
# Ensure the Anaconda directories to your path environment variable ("\Anaconda" and "\Anaconda\Scripts").  See [this page](http://superuser.com/questions/284342/what-are-path-and-other-environment-variables-and-how-can-i-set-or-use-them) for details.
# 
# If this does not correct the problem, reinstall Anaconda.
# 
# 
# **IF YOU ARE STILL HAVING ISSUES ON THE INSTALL, POST TO PIAZZA. WE'LL HELP YOU THERE. OR ASK IN YOUR SECTION**

# ##Setting up your git environment

# ###1. Installing git

# We will be using the command line version of git.
# 
# On linux, install git using your system package manager (yum, apt-get, etc)
# 
# On the Mac, if you ever installed Xcode, you should have git installed. Or you might have installed it using `homebrew`. Either of these are fine as long as the git version is greater than 2.0
# 
# Otherwise, on Mac and Windows, go to http://git-scm.com. Accept all defaults in the installation process. On Windows, installing git will also install for you a minimal unix environment with a "bash" shell and terminal window. Voila, your windows computer is transformed into a unixy form.

# ####Windows specific notes

# There will be an installer `.exe` file you need to click. Accept all the defaults.
# 
# Here is a screenshot from one of the defaults. It makes sure you will have the "bash" tool talked about earlier.
# ![use git bash](wgi-git-bash.png)
# 
# Choose the default line-encoding conversion:
# ![default lines](wgi-defaultlines.png)
# 
# Use the terminal emulator they provide, its better than the one shipped with windows.
# ![use mintty](wgi-usemintty.png)
# 
# Towards the end, you might see a message like this. It looks scary, but all you need to do is click "Continue"
# ![scary message](wgi-scarymessage.png)
# 
# 
# At this point you will be installed. You can bring up "git bash" either from your start menu, or from the right click menu on any folder background. When you do so, a terminal window will open. This terminal is where you will issue further git setup commands, and git commands in general.
# 
# Get familiar with the terminal. It opens in your home folder, and maps `\\` paths on windows to more web/unix like paths with '/'. Try issuing the commands `ls`, `pwd`, and `cd folder` where folder is one of the folders you see when you do a ls. You can do a `cd ..` to come back up.
# 
# You can also use the terminal which comes with the ipython notebook. More about that later.

# ####Mac specific notes

# As mentioned earlier, if you ever installed Xcode or the "Command Line Developer tools", you may already have git.
# Make sure its version 2.0 or higher. (`git --version`)
# 
# Or if you use **Homebrew**, you can install it from there. The current version on homebrew is 2.4.3
#  You dont need to do anyting more in this section.
# 
# -----
# 
# First click on the `.mpkg` file that comes when you open the downloaded `.dmg` file.
# 
# When I tried to install git on my mac, I got a warning saying my security preferences wouldnt allow it to be installed. So I opened my system preferences and went to "Security".
# 
# ![system pref](mac-git-security.png)
# 
# Here you must click "Open Anyway", and the installer will run.
# 
# The installer puts git as `/usr/local/git/bin/git`. Thats not a particularly useful spot. Open up `Terminal.app`.Its usually in `/Applications/Utilities`. Once the terminal opens up, issue
# 
# `sudo ln -s /usr/local/git/bin/git /usr/local/bin/git`.

# Keep the Terminal application handy in your dock. (You could also download and use iTerm.app, which is a nicer terminal, if you are into terminal geekery). We'll be using the terminal extensively for git. You can also use the terminal which comes with the ipython notebook. More about that later.
# 
# Try issuing the commands `ls`, `pwd`, and `cd folder` where folder is one of the folders you see when you do a ls. You can do a `cd ..` to come back up.

# ###2. Optional: Creating ssh keys on your machine

# This ia an optional step. But it makes things much easier.
# 
# There are two ways git talks to github: https, which is a web based protocol
# 
# ![github https](github-https-clone.png)
# 
# or over ssh
# 
# ![github ssh](github-ssh-clone.png)
# 
# Which one you use is your choice. I recommend ssh, and the github urls in this homework and in labs will be ssh urls.
# Every time you contact your upstream repository (hosted on github), you need to prove you're you. You *can* do this with passwords over HTTPS, but it gets old quickly. By providing an ssh public key to github, your ssh-agent will handle all of that for you, and you wont have to put in any passwords.
# 
# At your terminal, issue the command (skip this if you are a seasoned ssh user and already have keys):
# 
# `ssh-keygen -t rsa`
# 
# It will look like this:
# ![github ssh keygen](sshkeygen.png)
# 
# Accept the defaults. When it asks for a passphrase for your keys, put in none. (you can put in one if you know how to set up a ssh-agent).
# 
# This will create two files for you, in your home folder if you accepted the defaults.
➜  ~  ls .ssh/id_rsa*
.ssh/id_rsa     .ssh/id_rsa.pub
# `id_rsa` is your PRIVATE key. NEVER NEVER NEVER give that to anyone. `id_rsa.pub` is your public key. You must supply this to github.

# ----

# ###3.  Optional: Uploading ssh keys and Authentication

# To upload an ssh key, log in to github and click on the gear icon in the top right corner (settings). Once you're there, click on "SSH keys" on the left. This page will contain all your ssh keys once you upload any.
# 
# Click on "add ssh key" in the top right. You should see this box:
# 
# <img src="github_ssh.png" alt="github ssh" style="width: 500px;"/>
# 
# The title field should be the name of your computer or some other way to identify this particular ssh key.
# 
# In the key field, you'll need to copy and paste your *public* key. **Do not paste your private ssh key here.**
# 
# When you hit "Add key", you should see the key name and some hexadecimal characters show up in the list. You're set.
# 
# Now, whenever you clone a repository using this form:
# 
# `$ git clone git@github.com:rdadolf/ac297r-git-demo.git`,
# 
# you'll be connecting over ssh, and will not be asked for your github password
# 
# You will need to repeat steps 2 and 3 of the setup for each computer you wish to use with github.

# ###4. Setting global config for git

# Again, from the terminal, issue the command
# 
# `git config --global user.name "YOUR NAME"`
# 
# This sets up a name for you. Then do
# 
# `git config --global user.email "YOUR EMAIL ADDRESS"`
# 
# Use the **SAME** email address you used in setting up your github account.
# 
# These commands set up your global configuration. On my Mac, these are stored in the text file `.gitconfig` in my home folder.

# ###5. Github tutorial

# Read our git and github tutorial from [Lab 1](https://github.com/cs109/2015lab1/blob/master/Lab1-git.ipynb). Then come back here.
# 
# If you have any issues or questions: Ask us! On Piazza or in Sections!

# ---

# ## Sign up for AWS

# For the course you need to sign up for Amazon Web Services (AWS). 
# 
# - The sign up process has two steps:
#     1. Get an AWS account
#     2. Sign up for AWS educate
# 
# The AWS account will enable you to access Amazon's webservices. The AWS educate sign up will provide you with $100 worth of free credits.

# ### 1. Get an AWS account

# Note: You can skip this step if you already have an account. 
# 
# - Go to [this webpage](https://aws.amazon.com/education/awseducate/apply/)
# - Click on the yellow box in the upper right corner saying "Create an AWS account"
# - Follow the normal instructions and fill in all necessary information to create your account.
# 
# Once you have an account you need your account ID. The account ID is a 12 digit number. 
# Please follow [this description](http://docs.aws.amazon.com/IAM/latest/UserGuide/console_account-alias.html) to find your ID in the Support menu of your AWS console.

# ### 2. Sign up for AWS educate

# Note: You will need your 12 digit AWS account ID for this step.
# 
# - Go to [this webpage](https://aws.amazon.com/education/awseducate/apply/)
# - Click on the right on the button saying "Apply for AWS Educate for Students"
# - Confirm that you are a student
# - Fill out the form
# - **Note that that you provide should come from your institution, which means it should end in .edu** 
# - It might take a few days for your request to be approved. 
# 
# Once again, ping us if you need help!

# ## Hello, Python

# The IPython/Jupyter notebook is an application to build interactive computational notebooks. You'll be using them to complete labs and homework. Once you've set up Python, please download this page, and open it with IPython by typing
# 
# ```
# ipython notebook <name_of_downloaded_file>
# ```

# You can also open the notebook in any folder by `cd`ing to the folder in the terminal, and typing
# 
# ```
# ipython notebook .
# ```

# in that folder.
# 
# The anaconda install also probably dropped a launcher on your desktop. You can use the launcher, and select "ipython notebbok" or "jupyter notebook" from there. In this case you will need to find out which folder you are running in.
# 
# It loolks like this for me:
# 
# ![jupyter](jupyter.png)
# 
# Notice that you can use the user interface to create new folders and text files, and even open new terminals, all of which might come useful to you. To create a new notebook, you can use "Python 2" under notebooks. You may not have the other choices available (I have julia for example, which is another language that uses the same notebook interface).

# For the rest of the assignment, use your local copy of this page, running on IPython.
# 
# Notebooks are composed of many "cells", which can contain text (like this one), or code (like the one below). Double click on the cell below, and evaluate it by clicking the "play" button above, for by hitting shift + enter

# In[2]:


x = [10, 20, 30, 40, 50]
for item in x:
    print "Item is ", item


# ## Python Libraries

# ###Installing additional libraries

# Anaconda includes most of the libraries we will use in this course, but you will need to install a few extra ones for the beginning of this course:
# 
# 1. [BeautifulSoup](http://www.crummy.com/software/BeautifulSoup/)
# 1. [Seaborn](http://web.stanford.edu/~mwaskom/software/seaborn/)
# 1. [PyQuery](https://pythonhosted.org/pyquery/)
# 
# The recommended way to install these packages is to run 
# 
# `!pip install BeautifulSoup seaborn pyquery` 
# 
# in a code cell in the ipython notebook you just created. On windows, you might want to run `pip install BeautifulSoup seaborn pyquery` on the `git-bash.exe` terminal (note, the exclamation goes away).
# 
# If this doesn't work, you can download the source code, and run `python setup.py install` from the source code directory. On Unix machines(Mac or Linux), either of these commands may require `sudo` (i.e. `sudo pip install...` or `sudo python`)

# If you've successfully completed the above install, all of the following statements should run.

# ###Testing latest libraries

# In[3]:


#IPython is what you are using now to run the notebook
import IPython
print "IPython version:      %6.6s (need at least 3.0.0)" % IPython.__version__

# Numpy is a library for working with Arrays
import numpy as np
print "Numpy version:        %6.6s (need at least 1.9.1)" % np.__version__

# SciPy implements many different numerical algorithms
import scipy as sp
print "SciPy version:        %6.6s (need at least 0.15.1)" % sp.__version__

# Pandas makes working with data tables easier
import pandas as pd
print "Pandas version:       %6.6s (need at least 0.16.2)" % pd.__version__

# Module for plotting
import matplotlib
print "Mapltolib version:    %6.6s (need at least 1.4.1)" % matplotlib.__version__

# SciKit Learn implements several Machine Learning algorithms
import sklearn
print "Scikit-Learn version: %6.6s (need at least 0.16.1)" % sklearn.__version__

# Requests is a library for getting data from the Web
import requests
print "requests version:     %6.6s (need at least 2.0.0)" % requests.__version__

#BeautifulSoup is a library to parse HTML and XML documents
import bs4
print "BeautifulSoup version:%6.6s (need at least 4.4)" % bs4.__version__

import pyquery
print "Loaded PyQuery"


# If any of these libraries are missing or out of date, you will need to install them and restart IPython.

# ##Kicking the tires

# Lets try some things, starting from very simple, to more complex.

# ### Hello World

# The following is the incantation we like to put at the beginning of every notebook. It loads most of the stuff we will regularly use.

# In[4]:


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


# ### Hello matplotlib

# The notebook integrates nicely with Matplotlib, the primary plotting package for python. This should embed a figure of a sine wave:

# In[5]:


x = np.linspace(0, 10, 30)  #array of 30 points from 0 to 10
y = np.sin(x)
z = y + np.random.normal(size=30) * .2
plt.plot(x, y, 'o-', label='A sine wave')
plt.plot(x, z, '-', label='Noisy sine')
plt.legend(loc = 'lower right')
plt.xlabel("X axis")
plt.ylabel("Y axis")           


# If that last cell complained about the `%matplotlib` line, you need to update IPython to v1.0, and restart the notebook. See the [installation page](https://github.com/cs109/content/wiki/Installing-Python)

# ### Hello Numpy

# The Numpy array processing library is the basis of nearly all numerical computing in Python. Here's a 30 second crash course. For more details, consult Chapter 4 of Python for Data Analysis, or the [Numpy User's Guide](http://docs.scipy.org/doc/numpy-dev/user/index.html)

# In[6]:


print "Make a 3 row x 4 column array of random numbers"
x = np.random.random((3, 4))
print x
print

print "Add 1 to every element"
x = x + 1
print x
print

print "Get the element at row 1, column 2"
print x[1, 2]
print

# The colon syntax is called "slicing" the array. 
print "Get the first row"
print x[0, :]
print

print "Get every 2nd column of the first row"
print x[0, ::2]
print


# Print the maximum, minimum, and mean of the array. This does **not** require writing a loop. In the code cell below, type `x.m<TAB>`, to find built-in operations for common array statistics like this

# In[7]:


print "Max is  ", x.max()
print "Min is  ", x.min()
print "Mean is ", x.mean()


# Call the `x.max` function again, but use the `axis` keyword to print the maximum of each row in x.

# In[8]:


print x.max(axis=1)


# Here's a way to quickly simulate 500 coin "fair" coin tosses (where the probabily of getting Heads is 50%, or 0.5)

# In[9]:


x = np.random.binomial(500, .5)
print "number of heads:", x


# Repeat this simulation 500 times, and use the [plt.hist() function](http://matplotlib.org/api/pyplot_api.html#matplotlib.pyplot.hist) to plot a histogram of the number of Heads (1s) in each simulation

# In[10]:



# 3 ways to run the simulations

# loop
heads = []
for i in range(500):
    heads.append(np.random.binomial(500, .5))

# "list comprehension"
heads = [np.random.binomial(500, .5) for i in range(500)]

# pure numpy
heads = np.random.binomial(500, .5, size=500)

histogram = plt.hist(heads, bins=10)


# In[11]:


heads.shape


# ## The Monty Hall Problem

# Here's a fun and perhaps surprising statistical riddle, and a good way to get some practice writing python functions
# 
# In a gameshow, contestants try to guess which of 3 closed doors contain a cash prize (goats are behind the other two doors). Of course, the odds of choosing the correct door are 1 in 3. As a twist, the host of the show occasionally opens a door after a contestant makes his or her choice. This door is always one of the two the contestant did not pick, and is also always one of the goat doors (note that it is always possible to do this, since there are two goat doors). At this point, the contestant has the option of keeping his or her original choice, or swtiching to the other unopened door. The question is: is there any benefit to switching doors? The answer surprises many people who haven't heard the question before.
# 
# We can answer the problem by running simulations in Python. We'll do it in several parts.
# 
# First, write a function called `simulate_prizedoor`. This function will simulate the location of the prize in many games -- see the detailed specification below:

# In[12]:


"""
Function
--------
simulate_prizedoor

Generate a random array of 0s, 1s, and 2s, representing
hiding a prize between door 0, door 1, and door 2

Parameters
----------
nsim : int
    The number of simulations to run

Returns
-------
sims : array
    Random array of 0s, 1s, and 2s

Example
-------
>>> print simulate_prizedoor(3)
array([0, 0, 2])
"""


def simulate_prizedoor(nsim):
    return np.random.randint(0, 3, (nsim))


# Next, write a function that simulates the contestant's guesses for `nsim` simulations. Call this function `simulate_guess`. The specs:

# In[13]:


"""
Function
--------
simulate_guess

Return any strategy for guessing which door a prize is behind. This
could be a random strategy, one that always guesses 2, whatever.

Parameters
----------
nsim : int
    The number of simulations to generate guesses for

Returns
-------
guesses : array
    An array of guesses. Each guess is a 0, 1, or 2

Example
-------
>>> print simulate_guess(5)
array([0, 0, 0, 0, 0])
"""

def simulate_guess(nsim):
    return np.zeros(nsim, dtype=np.int)


# Next, write a function, `goat_door`, to simulate randomly revealing one of the goat doors that a contestant didn't pick.

# In[14]:


"""
Function
--------
goat_door

Simulate the opening of a "goat door" that doesn't contain the prize,
and is different from the contestants guess

Parameters
----------
prizedoors : array
    The door that the prize is behind in each simulation
guesses : array
    THe door that the contestant guessed in each simulation

Returns
-------
goats : array
    The goat door that is opened for each simulation. Each item is 0, 1, or 2, and is different
    from both prizedoors and guesses

Examples
--------
>>> print goat_door(np.array([0, 1, 2]), np.array([1, 1, 1]))
>>> array([2, 2, 0])
"""

def goat_door(prizedoors, guesses):
    
    #strategy: generate random answers, and
    #keep updating until they satisfy the rule
    #that they aren't a prizedoor or a guess
    result = np.random.randint(0, 3, prizedoors.size)
    while True:
        bad = (result == prizedoors) | (result == guesses)
        if not bad.any():
            return result
        result[bad] = np.random.randint(0, 3, bad.sum())


# Write a function, `switch_guess`, that represents the strategy of always switching a guess after the goat door is opened.

# In[15]:


"""
Function
--------
switch_guess

The strategy that always switches a guess after the goat door is opened

Parameters
----------
guesses : array
     Array of original guesses, for each simulation
goatdoors : array
     Array of revealed goat doors for each simulation

Returns
-------
The new door after switching. Should be different from both guesses and goatdoors

Examples
--------
>>> print switch_guess(np.array([0, 1, 2]), np.array([1, 2, 1]))
>>> array([2, 0, 0])
"""

def switch_guess(guesses, goatdoors):
    result = np.zeros(guesses.size)
    switch = {(0, 1): 2, (0, 2): 1, (1, 0): 2, (1, 2): 1, (2, 0): 1, (2, 1): 0}
    for i in [0, 1, 2]:
        for j in [0, 1, 2]:
            mask = (guesses == i) & (goatdoors == j)
            if not mask.any():
                continue
            result = np.where(mask, np.ones_like(result) * switch[(i, j)], result)
    return result


# Last function: write a `win_percentage` function that takes an array of `guesses` and `prizedoors`, and returns the percent of correct guesses

# In[16]:


"""
Function
--------
win_percentage

Calculate the percent of times that a simulation of guesses is correct

Parameters
-----------
guesses : array
    Guesses for each simulation
prizedoors : array
    Location of prize for each simulation

Returns
--------
percentage : number between 0 and 100
    The win percentage

Examples
---------
>>> print win_percentage(np.array([0, 1, 2]), np.array([0, 0, 0]))
33.333
"""

def win_percentage(guesses, prizedoors):
    return 100 * (guesses == prizedoors).mean()


# Now, put it together. Simulate 10000 games where contestant keeps his original guess, and 10000 games where the contestant switches his door after a  goat door is revealed. Compute the percentage of time the contestant wins under either strategy. Is one strategy better than the other?

# In[17]:



nsim = 10000

#keep guesses
print "Win percentage when keeping original door"
print win_percentage(simulate_prizedoor(nsim), simulate_guess(nsim))

#switch
pd = simulate_prizedoor(nsim)
guess = simulate_guess(nsim)
goats = goat_door(pd, guess)
guess = switch_guess(guess, goats)
print "Win percentage when switching doors"
print win_percentage(pd, guess).mean()


# Many people find this answer counter-intuitive (famously, PhD mathematicians have incorrectly claimed the result must be wrong. Clearly, none of them knew Python). 
# 
# One of the best ways to build intuition about why opening a Goat door affects the odds is to re-run the experiment with 100 doors and one prize. If the game show host opens 98 goat doors after you make your initial selection, would you want to keep your first pick or switch? Can you generalize your simulation code to handle the case of `n` doors?

# ##The workflow for homeworks and labs

# ###getting and working on labs

# Lets talk a bit about how labs and sections work in this course:
# 
# 1. Lab Notebooks are made available every Thursday evening.
# 2. Lab Videos (which may not cover everything in the notebooks) are made available every Friday as well
# 3. In sections starting Monday morning, and running upto the next Friday, your TA will present part of the lab to you. You ought to have looked at and perhaps tried the lab over the previous weekend, and your section might reach a consensus on what you'd like your TF to focus on: please communicate this.
# 
# (Sections are 2 hours long. The first hour will be spent going over the lab, while the second if an office hour, where you can ask your TA questions about the homework, the lectures, the subject matter, and even the lab).
# 
# The labs will be made available on public github repositories, with naming schemes like `cs109/2015lab1`.
# 
# This is how you ought to work with them (our github tutorial has an example of this process on the `cs109/testing` repository):
# 
# 1. First fork the lab from the github web interface. For example, the first lab is at: https://github.com/cs109/2015lab1 . The fork button is at the upper right corner of the page. Press it.
# 2. When it asks you where to fork the lab, choose your own github userid. The web interface will then take you to the web page for your fork. Mine is at: https://github.com/rahuldave/2015lab1 .
# 3. Now look for the clone url at the bottom right of the page. If you set up your ssh keys, use the ssh url, else use the https url. Mine are `git@github.com:rahuldave/2015lab1.git` and `https://github.com/rahuldave/2015lab1.git` respectively. 
# 4. Clone your fork down to your machine by obtaining a terminal (`/Applications/Utilities/Terminal.app` or equivalent on mac and `git-bash.exe` on windows). Change (`cd`) into an appropriate folder and clone by doing `git clone url` where the `url` is the one in step 3.
# 5. Add a remote for the original repository that you forked from. We'll call this remote `course`. The command for this, for example, for the first lab is: `git remote add course git@github.com:cs109/2015lab1.git` or `git remote add course https://github.com/cs109/2015lab1.git`
# 6. Now you have a local repository. Start the ipython notebook in the repository and run the labs. DO NOT run the notebooks ending in `_original.ipynb`. These are simply copies of the labs. We made these copies so that you can update them from our `course` remote in case we make any changes.
# 
# For Lab 1 I'd start with pythonpandas, followed by babypython, and finally git. The git notebook can be run under the ipython notebook. But the git commands can also be run directly on a terminal, which is probably the best place to do them...you can keep the notebook on the side to read as you follow along). So after once having read the tutorial, as described earlier, you now get to work through it.
# 
# When you follow along, you can add in your own notes, and try your own variations. As you are doing this, dont forget to continue doing the "add/commit/push" cycle, so that you save and version your changes, and push them to your fork. This typically looks like:
#     - git add .
#     - git commit -a
#     - git push
#     
# In case we make changes, you can incorporate them into your repo by doing: `git fetch course; git checkout course/master -- labname_original.ipynb` where `labname.ipynb` is the lab in question. An "add/commit/push" cycle will make sure these changes go into your fork as well. If you intend to work on the changed file, simply copy the file to another one and work on it. Or you could make a new branch. Remember that this fork is YOUR repository, and you can do to it what you like. 
# 
# The diagram below should help elucidate the above and serve as a command cheat-sheet.

# ![homework](cs109gitflow3.png)
# 

# ###getting and submitting homework

# To make `hw0.ipynb` easily accessible, we added it to the public lab repo, so that you can read it even without having a github account. (Otherwise we would have a chicken and egg problem.). This is because our homework repository is private, and we have set it up so that your repositories are private as well.
# 
# Nevertheless, we want you to get acquainted with the workflow you must execute in order to obtain and submit homeworks. 
# 
# Let me first describe the steps by which you gain access to the homework.
# 
# 1. At the beginning of this document you were asked to obtain a github id and enter it in the mandatory survey. We will use this github id to construct a homework repository for you with read-write access, and give you access to our read-only homework repository. You will be added to a github organization `cs109-students`.
# 2. Our read-only repository is `cs109-students/2015hw`. All students have read-only access to this repository. It will serve the job of the `course` remote, like above. Any changes after the homework has gone out will be made here.
# 3. You will have your own read-write repository under the `cs109-students` organization, which will be of the form `cs109-students/userid-2015hw`. Only you and the cs109 staff have access to this repository, thus ensuring the privacy of your homework.
# 4. When each homework is released, we will create a **branch** on your remote repository, `cs109-students/userid-2015hw`. The branches are, unimaginatively named: `hw0`, `hw1`,...,`hw5`. (For the curious, the way this works is by us creating one remote per student for a local clone of our `cs109-students/2015hw` repository, and pushing the new branch to it. We only push to a new branch each time as we dont want to be messing with a branch you have already worked on.). There is `master` branch too, which will have some instructions, but nothing very exciting. You will never work on this branch.
# 
# So now, how to you obtain and submit the homework? You wont be forking here.
# 
# 1. You first make a clone of your repository. From the terminal, you issue the command: `git clone git@github.com:cs109-students/userid-2015hw.git` (for ssh users) or `git clone https://github.com/cs109-students/userid-2015hw.git` (for https users). Substitute your own userid for `userid`.
# 2. Next you add a remote `course` to track the read-only "guru" repository. The command for this is: `git remote add course git@github.com:cs109-students/2015hw.git` or `git remote add course https://github.com/cs109-students/2015hw.git`. This well help to incorporate any changes, just like above.
# 3. Your clone will come with a `master` branch, and perhaps a `hw0` branch. In either case you should first do `git fetch origin hw0`, which fetches from *your* remote repository on github the `hw0` branch. Then you issue `git checkout -b hw0 origin/hw0`. This command makes a new local branch `hw0` on your machine which tracks the `hw0` branch on your remote.
# 4. You are now in the `hw0` branch. This is where you will work on homework 0. Start the ipython notebook in the repository and run the homework. The file you will use is `hw0.ipynb`. DO NOT run the notebook ending in `_original.ipynb`. These are simply copies of the homework. We made these copies so that you can update them from our `course` remote in case we make any changes. You will now engage in the "add/commit/push" cycle as described above. (The `push` will only push to the remote `hw0` branch.)
# 5. We'll grade the last commit you make before the homework deadline. We will be looking for the file `hw0.ipynb`. (In actuality we wont grade homework 0 but check that you submitted it. But we will be using this mechanism to grade the homeworks from homework 1 onwards.)
# 6. When we are ready to send out homework 1 to you, we will create a new branch on your remote repository `git@github.com:cs109-students/userid-2015hw.git` on github with the name `hw1`. You will now repeat the process from step 3 onwards: `git fetch origin hw1` followed by `git checkout -b hw1 origin/hw1`. Then you work on the `hw1` branch, and engage in the "add/commit/push" cycle by running `hw1.ipynb`. And so on...
# 
# Once again, in case we make changes, you can incorporate them into your repo by doing: `git fetch course; git checkout course/hw0 -- hw0_original.ipynb`. An "add/commit/push" cycle will make sure these changes go into your fork as well. If you intend to work on the changed file `hw0_original.ipynb`, simply copy the file to `hw0.ipynb` and work on it. 
# 
# Remember that we will be looking for files `hw0.ipynb`, `hw1.ipynb`,...,`hw5.ipynb` as the semester goes on.
# 
# This process is summarized in the diagram below.

# ![homework](cs109gitflow2.png)
