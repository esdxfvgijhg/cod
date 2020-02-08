#!/usr/bin/env python
# coding: utf-8

# # PRACTICAL WORK 
# ********************
# ********************
# ********************
# Proposed by 
# 
# __PATRICK VALDURIEZ & CARLYNA BONDIOMBOUY__
# 
# IMSP-INRIA
# ********************
# ********************
# ********************
# 
# 
# ## Exercise 1 (Food Center dataset)
# 
# ### Create dataframes
# 
# Spark DataFrame provides a domain-specific language for structured data manipulation. This language includes methods we can concatenate in order to do selection, filtering, grouping, etc

# In[ ]:


# import pyspark class Row from module sql
from pyspark.sql import *

# Create  FoodCenters - Departments and Employees

# Create the FoodCenters

foodcenter1 = Row(id='0000', name='Sunny Gas Meat', location='No. 24, Oba Market Road, B/C.')
foodcenter2 = Row(id='0001', name='Mrs. Ozede Meat Shop', location='No. 12, Ekp;enede Street, B/C.')
foodcenter3 = Row(id='0002', name='Mrs Ebbuzugbe Ice-Cream Shop', location='No. 10 Old Uguanogbe Street, B/C.')
foodcenter4 = Row(id='0003', name='C. O. Meat Shop', location='No. 22, O ba Market Road, B/C.')
foodcenter5 = Row(id='0004', name='Mrs. Omorodion', location='No. 22, O ba Market Road, B/C.')
foodcenter6 = Row(id='0005', name='B. B. Meat Shop', location='No. 5, Oba M arket Roiad, B/C.')
foodcenter7 = Row(id='0006', name='Destiny Meat Shop', location='No. 24, Oba Market Road, B/C.')
foodcenter8 = Row(id='0007', name='Sunday Meat Shoip', location='No. 11, Oba Market Road, B/C.')
foodcenter9 = Row(id='0008', name='Mrs Omoregie Meat Shop', location='No. 18C, Oba Market Road, B/C.')
foodcenter10 = Row(id='0009', name='F. O. Meat Shop', location='No. 18C, Oba Market Road, B/C.')
foodcenter11 = Row(id='0010', name='Pat O. Meat Shop', location='Oba Market Road, B/C.')
foodcenter12 = Row(id='0011', name='Mrs Adeban jo Meat Shop', location='No. 22, O ba Market Road, B/C.')

# Create the Employees
Employee = Row("firstName", "lastName", "email", "salary")
employee1 = Employee('Ogbe', 'Oronsaye', 'no-reply@sunny.org', 100000)
employee2 = Employee('Uyiosa', 'Idehen', 'no-reply@shop.fr', 120000)
employee3 = Employee('Igbinosa', 'Bello', 'no-reply@jo.edu', 140000)
employee4 = Employee('Abeni', 'Davies', 'no-reply@gas.com', 160000)
employee5 = Employee('Oriafo', 'Wendell', 'no-reply@porto.fr', 200000)
employee6 = Employee('Osigbemhe', 'Koutchanou', 'no-reply@nigeria.org', 180000)
employee7 = Employee('Bello', 'Ogbeide', 'no-reply@baker.com', 100000)
employee8 = Employee('Adizie', 'Solomon', 'no-reply@abejan.com', 170000)
employee9 = Employee('Adolor', 'Aiwerioba', 'no-reply@cmr.org', 150000)
employee10 = Employee('Ambrose', 'Anegbette', 'no-reply@tofa.com', 170000)
employee11 = Employee('Dagbala', 'Ebelle', 'no-reply@ghana.org', 130000)
employee12 = Employee('Oriafo', 'Edokpolo', 'no-reply@cameroon.org', 150000)

# Create the FoodcentersWithEmployees instances from foodcenters and employees
foodcenterWithEmployees1 = Row(foodcenter=foodcenter1, employees=[employee1, employee2])
foodcenterWithEmployees2 = Row(foodcenter=foodcenter2, employees=[employee3, employee4])
foodcentertWithEmployees3 = Row(foodcenter=foodcenter3, employees=[employee1, employee4])
foodcenterWithEmployees4 = Row(foodcenter=foodcenter4, employees=[employee2, employee3])
foodcenterWithEmployees5 = Row(foodcenter=foodcenter5, employees=[employee5, employee6])
foodcenterWithEmployees6 = Row(foodcenter=foodcenter6, employees=[employee7, employee8])
foodcenterWithEmployees7 = Row(foodcenter=foodcenter7, employees=[employee9, employee10])
foodcenterWithEmployees8 = Row(foodcenter=foodcenter8, employees=[employee11, employee3])
foodcenterWithEmployees9 = Row(foodcenter=foodcenter9, employees=[employee12, employee6])
foodcenterWithEmployees10 = Row(foodcenter=foodcenter10, employees=[employee10, employee11])
foodcenterWithEmployees11 = Row(foodcenter=foodcenter11, employees=[employee9, employee12])
foodcenterWithEmployees12 = Row(foodcenter=foodcenter11, employees=[employee7, employee10])

print (foodcenterWithEmployees12)
print("       ")
print (foodcenter10)
print("       ")
print (employee1)
print("       ")
print (foodcenterWithEmployees1.employees[0].email)


# In[ ]:


foodcenterWithEmployees_Seq = [foodcenterWithEmployees1, foodcenterWithEmployees2]
dframe = spark.createDataFrame(foodcenterWithEmployees_Seq)
display(dframe)
#dframe.show()


# In[55]:


from pyspark import  SparkContext
from pyspark.sql import *
sc = SparkContext.getOrCreate()

food_df = spark.read.csv("C://Users/carlyna.bondiombouy/Desktop/Benin/foodcenter.csv", inferSchema = True, header = True)
display(food_df)
food_df.show()


# ### Schema of DataFrame
# 
# The printSchema method enables to have a look at the schema, i.e. the structure of the DataFrame.

# In[53]:


food_df.printSchema()


# ### Rows and columns description
# 
# We want to have a look at the names and a count of the number of rows and columns of a particular DataFrame:

# In[54]:



food_df.columns #Column Names

len(food_df.columns) #Column Count


# In[19]:


food_df.count() #Row Count


# In[20]:


food_df.columns #Column Names


# In[37]:


food_df.describe().show()


# In[42]:


food_df.describe('LOCATION').show()


# ### Select clause

# In[47]:


food_df.select('LOCATION').show()


# In[50]:


food_df.select('LOCATION').distinct().show()


# ### Filter the dataframe
# 
# filters the DataFrame based on the condition that LOCATION must be equal to 'No. 24, Oba Market Road, B/C.' and calculates how many records/rows are there in the filtered output.

# In[60]:


food_df.filter(food_df.LOCATION=='No. 24, Oba Market Road, B/C.').show()
food_df.filter(food_df.LOCATION=='No. 24, Oba Market Road, B/C.').count()  #enables to get the count


# In[62]:


food_df.filter((food_df.LOCATION=="No. 4, Sokponba Road, B/C.")).show()


# ### Sorting data

# In[63]:


food_df.orderBy(food_df.LOCATION).show()


# ### Exercise 2 (orphanage home dataset)
# 
# Load the data in the same way as we did earlier.

# In[82]:


from pyspark import  SparkContext
from pyspark.sql import *
sc = SparkContext.getOrCreate()

home_df  = spark.read.csv("C://Users/carlyna.bondiombouy/Desktop/Benin/orphanagehome.csv", inferSchema = True, header = True)
display(home_df)
home_df.show()


# ### Filtering data

# In[78]:


home_df.filter(home_df.L == 'Oredo').count() 


# In[83]:


home_df.filter(home_df.ORGANIZATION == 'Uyiosa Orphanage Home.').count()


# ### Grouping the data

# In[85]:


home_df = home_df.groupby("L").count().show()

