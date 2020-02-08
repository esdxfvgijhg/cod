#!/usr/bin/env python
# coding: utf-8

# # PRACTICAL WORK 
# ********************
# ********************
# ********************
# Proposed by 
# 
# __CARLYNA BONDIOMBOUY__
# 
# 
# ********************
# ********************
# ********************
# 
# ## Linux/UNIX Install 
# 
# 
# This document describes how to install Python 3.7, Java 8, Spark 2.3.0, and Anaconda3-5.3.1 on Ubuntu Linux machines.
# 
# 1.	***Python***
# 
# To see which version of Python 3 you have installed, open a command prompt and run
# 
# ```Python
# 
# $ python3 --version
# 
# If you are using Ubuntu 16.10 or newer, then you can easily install Python 3.7 with the following commands:
# 
# $ sudo apt-get update
# 
# $ sudo apt-get install python3.7
# 
# If you’re using another version of Ubuntu (e.g. the latest LTS release).
# We recommend using the deadsnakes PPA to install.
# 
# Python 3.7:
# 
# $ sudo apt-get install software-properties-common
# 
# $ sudo add-apt-repository ppa:deadsnakes/ppa
# 
# $ sudo apt-get update
# 
# $ sudo apt-get install python3.6
# 
# If you are using other Linux distribution, chances are you already have Python 3 pre-installed as well. If not, use your distribution’s package manager. For example on Fedora, you would use dnf:
# 
# $ sudo dnf install python3
# 
# Note that if the version of the python3 package is not recent enough for you, there may be ways of installing more recent versions as well, depending on your distribution. 
# 
# Working with Python 3
# At this point, you may have system Python 2.7 available as well.
# 
# $ python
# 
# This will launch the Python 2 interpreter.
# 
# $ python3
# 
# This will launch the Python 3 interpreter.
# Setuptools & Pip.
# 
# The two most crucial third-party Python packages are setuptools and pip.
# Once installed, you can download, install and uninstall any compliant Python software product with a single command. It also enables you to add this network installation capability to your own Python software with very little work.
# Python 2.7.9 and later (on the python2 series), and Python 3.4 and later include pip by default.
# To see if pip is installed, open a command prompt and run
# 
# $ command -v pip
# 
# To install pip, follow the official pip installation guide - this will automatically install the latest version of setuptools.
# Note that on some Linux distributions including Ubuntu and Fedora the pip command is meant for Python 2, while the pip3 command is meant for Python 3.
# 
# $ command -v pip3
# ```
# 
# #### Sources :
# 
# https://docs.python-guide.org/starting/install3/linux/
# 
# https://docs.python-guide.org/dev/virtualenvs/#virtualenvironments-ref
# 
# https://doc.ubuntu-fr.org/python
# 
# 2. ***Spark***
# 
# Spark is Hadoop’s sub-project. Therefore, it is better to install Spark into a Linux based system. The following steps show how to install Apache Spark.
# 
# Step 1: Verifying Java Installation
# 
# Java installation is one of the mandatory things in installing Spark. Try the following command to verify the JAVA version.
# 
# ```Python
# 
# $ java -version
# If Java is already, installed on your system, you get to see the following response −
# java version "1.7.0_71" 
# Java(TM) SE Runtime Environment (build 1.7.0_71-b13) 
# Java HotSpot(TM) Client VM (build 25.0-b02, mixed mode)
# In case you do not have Java installed on your system, then Install Java before proceeding to next step.
# 
# Step 2: Downloading Apache Spark
# 
# Download the latest version of Spark by visiting the following link Download Spark. For this tutorial, we are using spark-1.3.1-bin-hadoop2.6 version. After downloading it, you will find the Spark tar file in the download folder.
# 
# Step 3: Installing Spark
# 
# Follow the steps given below for installing Spark.
# 
# Extracting Spark tar
# The following command for extracting the spark tar file.
# 
# $ tar xvf spark-1.3.1-bin-hadoop2.6.tgz 
# Moving Spark software files
# The following commands for moving the Spark software files to respective directory (/usr/local/spark).
# 
# $ su – 
# Password:***
# 
# # cd /home/Hadoop/Downloads/ 
# # mv spark-1.3.1-bin-hadoop2.6 /usr/local/spark 
# # exit 
# 
# Setting up the environment for Spark
# Add the following line to ~/.bashrc file. It means adding the location, where the spark software file are located to the PATH variable.
# export PATH=$PATH:/usr/local/spark/bin
# Use the following command for sourcing the ~/.bashrc file.
# 
# $ source ~/.bashrc
# 
# Step 3: Verifying the Spark Installation
# 
# Write the following command for opening Spark shell.
# 
# $ spark-shell
# If spark is installed successfully then you will find the following output.
# Spark assembly has been built with Hive, including Datanucleus jars on classpath 
# Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties 
# 26/02/19 14:25:22 INFO SecurityManager: Changing view acls to: hadoop 
# 26/02/19 14:25:22 INFO SecurityManager: Changing modify acls to: hadoop
# 26/02/19 14:25:22 INFO SecurityManager: SecurityManager: authentication disabled;
#    ui acls disabled; users with view permissions: Set(hadoop); users with modify permissions: Set(hadoop) 
# 26/02/19 14:25:22 INFO HttpServer: Starting HTTP Server 
# 26/02/19 14:25:23 INFO Utils: Successfully started service 'HTTP class server' on port 43292. 
# Welcome to 
#       ____              __ 
#      / __/__  ___ _____/ /__ 
#     _\ \/ _ \/ _ `/ __/  '_/ 
#    /___/ .__/\_,_/_/ /_/\_\   version 1.4.0 
#       /_/  
# 		
# Using Scala version 2.10.4 (Java HotSpot(TM) 64-Bit Server VM, Java 1.7.0_71) 
# Type in expressions to have them evaluated. 
# Spark context available as sc  
# scala> 
# ```
# 
# 
# ********************
# ********************
# ********************
# 
# ## Windows Install 
# 
# This document describes how to install Python 3.7, Java 8, Spark 2.3.0, and Anaconda3-5.3.1 on Windows machines.
# 
# ### Python
# 
# 1.	Double-click the icon labeling the file python-3.7.0.exe.
# 
# An Open File - Security Warning pop-up window will appear.

# In[1]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/python1.png')


# 2.	Click Run.
# A Python 3.7.0 (32-bit) Setup pop-up window will appear.

# In[2]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/python2.png')


# Ensure that the Install launcher for all users (recommended) and the Add Python 3.7 to PATH checkboxes at the bottom are checked.
# 
# If the Python Installer finds an earlier version of Python installed on your computer, the Install Now message may instead appear as Upgrade Now (and the checkboxes will not appear).
# 
# 3.	Highlight the Install Now (or Upgrade Now) message, and then click it.
# 
# A User Account Conrol pop-up window will appear, posing the question Do you want the allow the following program to make changes to this computer?

# In[3]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/python3.png')


# 4. Click the Yes button.
# 
# A new Python 3.7.0 (32-bit) Setup pop-up window will appear with a Setup Progress message and a progress bar.
# 
# During installation, it will show the various components it is installing and move the progress bar towards completion. Soon, a new Python 3.7.0 (32-bit) Setup pop-up window will appear with a Setup was successfuly message.
# 
# 5.	Click the Close button.
# 
# Python should now be installed.
# Verifying
# To try to verify installation,
# 
#     1.	Navigate to the directory C:\Users\Pattis\AppData\Local\Programs\Python\Python37-32 (or to whatever directory Python was installed: see the pop-up window for Installing step 3).
#     2.	Double-click the icon/file python.exe.
#     
# The following pop-up window will appear.
# 
# 
# A pop-up window with the title C:\Users\IMSP\AppData\Local\Programs\Python\Python37-32 appears, and inside the window; on the first line is the text Python 3.7.0 ... (notice that it should also say 32 bit). Inside the window, at the bottom left, is the prompt >>>: type exit() to this prompt and press enter to terminate Python.
# 
# You should keep the file python-3.7.0.exe somewhere on your computer in case you need to reinstall Python (not likely necessary).
# 
# You may now follow the instructions to download and install Java (you should have already installed Java, but if you haven't, it is OK to do so now, so long as you install both Python and Java before you install Eclipse), and then follows the instruction to download and install the Eclipse IDE. Note: you you need to download/install Java even if you are using Eclipse only for Python)
# 
# #### Source :
# 
# https://www.ics.uci.edu/~pattis/common/handouts/pythoneclipsejava/python.html
# 
# ***************
# 
# ### Java
# 
# 1. Install Java jdk
# 2. Install Scala
# 3. Download Winutils
# 4. Install Anaconda – as an IDE for Python development
# 5. Install Spark
# 
# Installing Spark requires adding a number of environment variables so there is a small section at the beginning explaining how to add an environment variable.
# 
# ***Create Environment Variables***
# 
# To install Spark you need to add a number of environment variables. The following shows how to create an environment variable in Windows 10:

# In[4]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/java1.png')


# In Control Panel, click on System and Security:

# In[5]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/java2.png')


# In the next pane, click on System:

# In[6]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/java3.png')


# In the system pane, click on Advanced system settings:

# In[7]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/java4.png')


# In system Properties, click on Environment Variables…

# from IPython.display import Image
# Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/java5.png')

# ***Install Java jdk***
# 
# Make sure you have the latest version of Java installed; if you do, you should have the latest version of the Java jdk. If not, download the jdk from the following link:
# 
# http://www.oracle.com/technetwork/java/javase/downloads/index.html
# 
# Once downloaded, copy the jdk folder to C:\Program files\Java:

# In[9]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/java6.png')


# Create an environment variable called JAVA_HOME and set the value to the folder with the jdk in it (e.g. C:\Program Files\Java\jdk1.8.0_121):

# In[10]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/java7.png')


# *********************
# 
# ### Install Scala
# 
# Install Scala from this location:
# 
# http://www.scala-lang.org/download/2.10.5.html
# 
# Download the msi and run it on the machine.
# Create an environment variable called SCALA_HOME and point it to the directory where Scala has been installed:

# In[11]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/java8.png')


# ********************
# 
# ### Download Winutils
# 
# Download the winutils.exe binary from this location:
# 
# https://github.com/steveloughran/winutils/blob/master/hadoop-2.7.0/bin/winutils.exe
# 
# 1. Create the following folder and save winutils.exe to it:
# c:\hadoop\bin
# 
# 2. Create an environment variable called HADOOP_HOME and give it the value C:\hadoop
# 3. Edit the PATH environment variable to include %HADOOP_HOME%\bin:

# In[12]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/hadoop.png')


# 4. Create tmp\hive directory
# 
# 5. Create a folder called hive in the following location:
# C:\tmp\hive
# 
# 6. Run the following line in Command Prompt to put permissions onto the hive directory:
# 
# ```Python winutils.exe chmod -R 777 C:\tmp\hive```
# 
# You can check permissions with the following command:
# 
# ```Python winutils.exe ls \tmp\hive```
# 
# **************
# 
# ### Install Anaconda
# 
# At the moment (February 2017), Spark does not work with Python 3.x. Download a version of Anaconda that uses Python 3.x or less from the following link (I downloaded Anaconda3-x.x.x):
# 
# https://repo.continuum.io/archive/index.html
# 
# If possible, make sure Anaconda is saved to the following folder:
# C:\Program Files\Anaconda3
# 
# Add an environment variable called PYTHONPATH and give it the value of where Anaconda is saved to:

# In[13]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/anaconda.png')


# *****************
# 
# ### Spark
# 
# ***Download Spark:***
# 
# Download the latest version of Spark from the following link. Make sure the package type says pre-built for Hadoop 2.7 and later.
# http://spark.apache.org/downloads.html
# 
# 1. Once downloaded, change the extension of the file from tar to zip, so that the file name reads spark-2.x.0-bin-hadoop2.7.zip.
# 
#         a. Extract the file using winrar or winzip.
# 
# 2. Within the extracted folder is a file without an extension.
# 
#         a. Add a zip extension to the file and extract again.
# 
# 3. Create a folder at C:\Spark and copy the contents of the second extracted folder to it.
# 
# 4. Change log4j.properties file.
# 
#         a. Go to the folder C:\Spark\conf and open the file log4j.properties.template using WordPad.
#         
#         b. Find the log4j.rootCategory setting and change it from INFO to WARN.
# 
# 5. Save the changes to the file.
# 
# 6. Remove the template extension from the file name so that the file name becomes log4j.properties
# 
# 7. Add Spark Environment Variables
# 
#     Add an environment variable called SPARK_HOME and give it the value of the folder where Spark was downloaded to (C:\Spark):
# 
# 8. Add to the PATH Environment variable the following value:
# %SPARK_HOME%\bin
# 
# 9. Environment variables
# 
#         a. Add Environment Variables to open Spark with Jupyter notebook
#         
#         b. Add the following variables if you want the default program that opens with Spark to be Jupyter Notebooks.
#         
#         c. Add the environment variable PYSPARK_DRIVER_PYTHON and give it the value jupyter.
#         
#         d. Add the environment variable PYSPARK_DRIVER_PYTHON_OPTS and give it the value notebook.
#     
# 10. Open Spark
#     
#         a. To use Spark, open command prompt, then type in the following two commands: CD C:\Spark\bin
#         
#         b. Pyspark

# In[17]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/spark1.png')

