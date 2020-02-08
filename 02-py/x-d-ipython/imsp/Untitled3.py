#!/usr/bin/env python
# coding: utf-8

# In[ ]:


from pyspark import  SparkContext
sc = SparkContext.getOrCreate()
words = sc.parallelize (
  ["scala",
  "java",
  "hadoop",
  "spark",
  "akka",
  "spark vs hadoop",
  "pyspark",
  "pyspark and spark"]
)
counts = words.count()
print "Number of elements in RDD -> %i" % (counts)


# In[2]:


from pyspark import SparkContext
sc = SparkContext.getOrCreate()
words = sc.parallelize (
  ["scala",
  "java",
  "hadoop",
  "spark",
  "akka",
  "spark vs hadoop",
  "pyspark",
  "pyspark and spark"]
)
def f(x): print(x)
fore = words.foreach(f)


# In[ ]:




