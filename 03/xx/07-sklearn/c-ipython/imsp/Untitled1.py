#!/usr/bin/env python
# coding: utf-8

# In[4]:


import urllib.request
# Download the file from `url` and save it locally under `file_name`:
urllib.request.urlretrieve("http://kdd.ics.uci.edu/databases/kddcup99/kddcup.data_10_percent.gz", "kddcup.data_10_percent.gz")


# In[9]:


from pyspark import  SparkContext
sc = SparkContext.getOrCreate()
data_file = "C:/Users/carlyna.bondiombouy/Downloads/Benin data/TP data/Nouveau dossier/kddcup.data_10_percent.gz"
raw_data = sc.textFile(data_file).cache()


# In[10]:


from pyspark.sql import SQLContext
sqlContext = SQLContext(sc)


# In[11]:


from pyspark.sql import Row

csv_data = raw_data.map(lambda l: l.split(","))
row_data = csv_data.map(lambda p: Row(
    duration=int(p[0]), 
    protocol_type=p[1],
    service=p[2],
    flag=p[3],
    src_bytes=int(p[4]),
    dst_bytes=int(p[5])
    )
)


# In[15]:


from pyspark.sql import SQLContext
sqlContext = SQLContext(sc)
interactions_df = sqlContext.createDataFrame(row_data)
interactions_df.registerTempTable("interactions")


# In[16]:


from pyspark.sql import SQLContext
sqlContext = SQLContext(sc)
# Select tcp network interactions with more than 1 second duration and no transfer from destination
tcp_interactions = sqlContext.sql("""
    SELECT duration, dst_bytes FROM interactions WHERE protocol_type = 'tcp' AND duration > 1000 AND dst_bytes = 0
""")
tcp_interactions.show()


# In[ ]:




