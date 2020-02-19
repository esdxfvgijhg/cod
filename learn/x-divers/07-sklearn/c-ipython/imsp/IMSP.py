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
# 
# The practical work enables to become familiar with Spark distributed data framework. To sit the different concepts list during the courses. We divide the practical work in two parts : Basic exercise and advanced exercise.
# 
# 1. Basic exercise: concerns Word count, we will manipulate the content of the file contained in the directory /tmp/TP_Spark by working with Spark data model.
# 
# 2. Advanced exercise: based on the forum web application scenario. The motivate example, enables to help an editorial ofice to find appropriate reporters for a list of publications based on given keywords.
# 
# 
# ***
# 
# #### Source : Spark/Python Practice. Boyan Kolev, Patrick Valduriez and Esther Pacitti
# 
# ***
# 
# ### Basic Exercise
# 
# Now, let us extend in a more practical way the *“word count”* example from the previous section. We will read data from numerous text files, count the word occurrences, and save the results as text files. 
# 
#  Let us assume that */tmp/TP_Spark* is our working directory. In the data set, you will find a subdirectory named *spark-docs* containing the Spark documentation in *.md files.* 
#  
#  You have to use *SparkContext’s textFile* method, that reads one or more text files and creates an RDD, where each element is one line of the text file(s). The argument of the function is the path to the file(s) and it accepts wildcards, so that you can read at once all the *.md* files in the *spark-docs* directory. 
#  
# Then, transform the resulting RDD (where each element is a whole line) to into a new *wordsRDD*, where each element is a single word. For the purpose, use the *flatMap* operation, which allows for a single RDD element to be transformed into multiple elements in the returned RDD. 
# 
# The *flatMap* transformation function should return a collection instead of a single value; like in the previous example, use space as a delimiter to split a line into words. Then, use the same map and *reduceByKey* operations as in the previous example to create the *wordCount* final RDD and save it as text into */tmp/TP_Spark/output.*
# 
# Note that *saveAsTextFile* creates the directory specified with the argument and creates many files named *part-XXXXX* that correspond to the partitions of the final RDD. It also requires that the destination directory do not exist, so if you rerun this example, make sure to delete the *output* directory.
# 
# __Solution:__
# 
# 
# 

# In[1]:


from pyspark import  SparkContext
sc = SparkContext.getOrCreate()
#sc = SparkContext("local", "App")

#sc = SparkContext(appName = "check")
RDread = sc.textFile ("C:/Users/carlyna.bondiombouy/Desktop/tmp - Copie/spark-docs/*.md")
RDread.collect()


# In[5]:


#from pyspark import SparkContext
#sc = SparkContext(appName = "check")
textfile = sc.textFile('C:/Users/carlyna.bondiombouy/Desktop/tmp/spark-docs/*.csv')
textfile.collect()


# In[30]:


from pyspark.context import SparkContext
from pyspark.sql import SparkSession
from pyspark.sql import Row


#création de contexte SPark
sc = SparkContext.getOrCreate()

#création de la session Spark
spark = SparkSession.builder.getOrCreate()

#filtrage des noms contenants des mots clés
def filterWord(City):
    return ("@" in City) or ("/" not in City) == True             and len(City) > 0

 

#fonction de chargement de données
def loadData(path):
    rdd = sc.textFile("C://Users/carlyna.bondiombouy/Desktop/tmp/spark-docs/*.csv")            .flatMap(lambda lines : lines.lower().split())            .flatMap(lambda word : word.split(","))             .flatMap(lambda word : word.split("."))             .flatMap(lambda word : word.split(";"))             .flatMap(lambda word : word.split(":"))             .flatMap(lambda word : word.split("?"))             .flatMap(lambda word : word.split("!"))             .flatMap(lambda word : word.split("\""))             .flatMap(lambda word : word.split("-"))             .flatMap(lambda word : word.split("\'"))            .filter(filterWord)            .map(lambda word : (word, 1))             .reduceByKey( lambda count1, count2 : count1 + count2 )             .map(lambda data : Row(label=data[0], length=len(data[0]), freq=data[1]))
    
    #return spark.createDataFrame(rdd)


#chargement des données
dataFrame = loadData("C:/Users/carlyna.bondiombouy/Desktop/tmp/spark-docs/*.csv")
print(dataFrame)
#print("le nombre total de mots est :", dataFrame.count())


# In[ ]:


from pyspark import  SparkContext
sc = SparkContext.getOrCreate()
text_file = sc.textFile("C://Users/carlyna.bondiombouy/Desktop/tmp/spark-docs/*.csv")
counts = text_file.flatMap(lambda line: line.split()) 
countsWord= counts.map(lambda word: (word, 1))#.cache()
reduceWord= countsWord.reduceByKey(lambda a, b: a + b)
#reduceWord.collect()
#sc.stop()
reduceWord.saveAsTextFile("C://Users/carlyna.bondiombouy/Desktop/tmp/TP_Spark/ls")


# ___**Evaluating the benefit of parallelism**___
# 
# Run the above example with one worker (no parallelism) and with several workers to assess the benefit of parallelism. The optimal number of workers for a standalone (single-node) Spark setup is the number of CPU cores. In MacOS, you can get the number of logical cores with the following bash command: *sysctl -n hw.ncpu*
# 
# You can also get the current time in Python by calling the *time* function defined in the time Python package. If you do this before and after the call to *saveAsTextFile* and print the difference, you can get the elapsed time.
# 
# Hint: You can define a Python script file to be executed automatically when pyspark is started, by setting the environment variable *PYTHONSTARTUP*.
# 
# __Solution:__
# 

# In[ ]:


import time
linesRDD = sc.textFile("C://Users/carlyna.bondiombouy/Desktop/tmp/spark-docs/*.csv")
wordsRDD = linesRDD.flatMap( lambda l: l.split(' ') )
wordsPairRDD = wordsRDD.map( lambda a: (a, 1) )
wordCount = wordsPairRDD.reduceByKey(lambda a, b: a + b)
t = time.time()
wordCount.saveAsTextFile("C://Users/carlyna.bondiombouy/Desktop/tmp/TP_Spark/output')
localtime = time.localtime(time.time())
print ("Local current time :", localtime)
(/print, ('Time, elapsed:, ', +, str(time.time(), -, t)))


# ___**Filteng the result**___
# 
# Another important RDD operation is *filter*. It returns an RDD composed only of those elements, for which is satisfied the condition defined in the (lambda) function that is passed as argument to the *filter* RDD method. When applying the *filter* operation, this function is evaluated for each element of the RDD and those elements, for which it returns *False*, are filtered out.
# 
# Modify the above query to get the count only of the word “Spark”. Now that the final RDD contains just one element, it will be more convenient to just collect and print it instead of saving it as text file. The result must be: *('Spark', 1011)*. Think about where in the chain of RDD operations to place the filter, to achieve an optimal execution.
# 
# __Solution (optimal):__
# 

# In[ ]:


linesRDD = sc.textFile('/tmp/TP_Spark/spark-docs/*.md')
wordsRDD = linesRDD.flatMap( lambda l: l.split(' ') )
wordsRDD = wordsRDD.filter( lambda a: a == 'Spark' )
wordsPairRDD = wordsRDD.map( lambda a: (a, 1) )
wordCount = wordsPairRDD.reduceByKey(lambda a, b: a + b)
print wordCount.collect()


# ### Advanced Exercise 
# 
# Let us assume the following scenario. A forum web application keeps log data about its posts in text files where a single record corresponds to one post and contains two fields about the post itself (timestamp and username) followed by a variable number of fields storing the key-words mentioned in the post (the left side of the example below). Our final goal is to find for each keyword the user who mentioned it most frequently (the right side of the example).
# 
# 
# *2014-12-13, alice, storage, cloud*
# *2014-12-22, bob, cloud, virtual, app*  
# *2014-12-24, alice, cloud*
# 
# -------->
# 
# |**KW**  |**expert** |**freq** |
# |--------|-----------|---------|
# |cloud   |alice      |2        |
# |storage |storage    |1        | 
# |virtual |virtual    |1        | 
# |app     |app        |1        |  
# 
# You can find this example input dataset in the file posts_small.txt. The fields in the input file are comma-separated, without blank spaces.
# 
# ___**First goal: get user-keyword pairs**___
# 
# Read the input file and break down each line to a number of (user, keyword) pairs, so that the result is the dataset:
# 
# $[$ ('alice', 'storage'), ('alice', 'cloud'),
#  ('bob', 'cloud'), ('bob', 'virtual'), ('bob', 'app'),
#  ('alice', 'cloud')$]$
#  
# Hint: you can use for...in Python generator expressions within brackets to create pairs between one variable and each element of a sub-collection, e.g.:
# 
# ```Python
# a = ['a', 'x', 'y', 'z']
# pairs_a = [ (a[0], w) for w in a[1:] ]
# print pairs_a
# [('a', 'x'), ('a', 'y'), ('a', 'z')]
# ```

# In[ ]:


rdd = sc.textFile('/tmp/TP_Spark/posts_small.txt')
rdd = rdd.map( lambda l: l.split(',') )
rdd = rdd.flatMap(lambda a: [ (a[1], w) for w in a[2:] ])
print rdd.collect()


# ___**Count the occurences of each pair**___
# 
# Apply the *map* and *reduceByKey* technique from the previous section to group by each (user, keyword) pair and count the occurence of each pair. The result should be:
# 
# $[$(('bob', 'virtual'), 1), (('bob', 'cloud'), 1),
#  (('bob', 'app'), 1),
#  (('alice', 'cloud'), 2), (('alice', 'storage'), 1)$]$
# 
# **Solution:**

# In[ ]:


rdd = rdd.map( lambda a: (a, 1) )
rdd = rdd.reduceByKey( lambda a, b: a + b )
print rdd.collect()


# ___**Map by keywords**___
# 
# In the above intermediate key-value set, each pair of user and keyword is taken as the key. This was important for the *reduceByKey* to return the number of times each user has mentioned each keyword. Now we need to group by keywords, so we need a map to transform the above dataset into another key-value RDD, where keywords are the keys and (user, count) pairs are the values. The result should be:
# 
# $[$('virtual', ('bob', 1)), ('cloud', ('bob', 1)),
#  ('app', ('bob', 1)),
#  ('cloud', ('alice', 2)), ('storage', ('alice', 1))$]$
# 
# **Solution:**

# In[ ]:


rdd = rdd.map( lambda a: (a[0][1], (a[0][0], a[1])) )
print rdd.collect()


# ___**Final goal: keep only the winner**___
# 
# Finally, we have to reduce by key, so as for each keyword to keep only that (user, count) value that maximizes the count. In our example, the set of all the (user, count) values, mapped to they *'cloud'*, should be reduced to only the pair *('alice', 2)*.
# 
# ```Python
# a = 3
# sign_a = 1 if a >= 0 else -1
# print sign_a
# 
# ```

# In[ ]:


rdd = rdd.reduceByKey( lambda a, b: b if b[1] > a[1] else a )
print rdd.collect()


# ___**Rasing the scale**___
# 
# Run the full query on the much larger dataset in the *posts_large.txt* file. Print also the execution time. Experiment with different levels of parallelism (e.g. with 1, 2 and 4 workers) to evaluate the benefits of parallel computing.
# 
# **Solution:**
# 

# In[ ]:


import time
rdd = sc.textFile('/tmp/TP_Spark/posts_large.txt')
rdd = rdd.map( lambda l: l.split(',') )
rdd = rdd.flatMap(lambda a: [ (a[1], w) for w in a[2:] ])
rdd = rdd.map( lambda a: (a, 1) )
rdd = rdd.reduceByKey( lambda a, b: a + b )
rdd = rdd.map( lambda a: (a[0][1], (a[0][0], a[1])) )
rdd = rdd.reduceByKey( lambda a, b: b if b[1] > a[1] else a )
t = time.time()
print rdd.collect()
print 'Time elapsed: ' + str(time.time() - t)


# ___**Filter by particular keywords**___
# 
# Find the top users of only the keywords in the list ('Spark', 'cloud', 'data', 'mining'). Think about where in the chain of RDD operations to place the filter operation, to achieve an optimal execution.
# 
# __Solution (optimal):__

# In[ ]:


import time
kwlist = ('Spark', 'cloud', 'data', 'mining')
rdd = sc.textFile('/tmp/TP_Spark/posts_large.txt')
rdd = rdd.map( lambda l: l.split(',') )
rdd = rdd.flatMap(lambda a: [ (a[1], w) for w in a[2:] ])
rdd = rdd.filter( lambda a: a[1] in kwlist )
rdd = rdd.map( lambda a: (a, 1) )
rdd = rdd.reduceByKey( lambda a, b: a + b )
rdd = rdd.map( lambda a: (a[0][1], (a[0][0], a[1])) )
rdd = rdd.reduceByKey( lambda a, b: b if b[1] > a[1] else a )
t = time.time()
print rdd.collect()
print 'Time elapsed: ' + str(time.time() - t)

