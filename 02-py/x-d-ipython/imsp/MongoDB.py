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
# ## Install MongoDB on Windows
# 
# ### Overview
# Use this tutorial to install MongoDB on Windows systems.
# 
# ###### PLATFORM SUPPORT
# 
# Starting in version 2.2, MongoDB does not support Windows XP. Please use a more recent version of Windows to use more recent releases of MongoDB.
# 
# While MongoDB is available as both 64-bit and 32-bit builds, only 64-bit builds are supported in production.
# 
#     IMPORTANT If you are running any edition of Windows Server 2008 R2 or Windows 7, please install a hotfix to resolve an
#     issue with memory mapped files on Windows https://support.microsoft.com/fr-fr/help/2731284/33-dos-error-code-when-memory-memory-mapped-files-are-cleaned-by-using.
# 
# #### Requirements
# On Windows MongoDB requires Windows Server 2008 R2, Windows Vista, or later. The .msi installer includes all other software dependencies and will automatically upgrade any older version of MongoDB installed using an .msi file.
# 
# ***
# 
# ### Get MongoDB
# 
# 1. Determine which MongoDB build you need.
# 
# 
# There are three builds of MongoDB for Windows:
# 
# *MongoDB for Windows 64-bit* runs only on Windows Server 2008 R2, Windows 7 64-bit, and newer versions of Windows. This build takes advantage of recent enhancements to the Windows Platform and cannot operate on older versions of Windows.
# 
# *MongoDB for Windows 64-bit Legacy* runs on Windows Vista and Windows Server 2008 and does not include recent performance enhancements.
# 
# To find which version of Windows you are running, enter the following commands in the *Command Prompt* or *Powershell*:
# 
# ```Python
# C:\Users\carlyna.bondiombouy>wmic os get caption
# Caption
# Microsoft Windows 10 Professionnel
# 
# C:\Users\carlyna.bondiombouy>wmic os get osarchitecture
# OSArchitecture
# 64 bits
# 
# ```
# 
# 2. Download MongoDB for Windows.
# 
# Download the latest production release of MongoDB from the MongoDB downloads page https://www.mongodb.com/download-center/community. Ensure you download the correct version of MongoDB for your Windows system. The 64-bit versions of MongoDB do not work with 32-bit Windows.
# 
# 
# ********
# 
# 
# ### Install MongoDB
# 
# ##### Interactive Installation
# 
# 1. Install MongoDB for Windows.
# 
# In Windows Explorer, locate the downloaded MongoDB .msi file, which typically is located in the default Downloads folder. Double-click the .msi file. A set of screens will appear to guide you through the installation process.
# 
# You may specify an installation directory if you choose the “Custom” installation option.
# 
#     NOTE These instructions assume that you have installed MongoDB to C:\mongodb.
# 
# MongoDB is self-contained and does not have any other system dependencies. You can run MongoDB from any folder you choose. You may install MongoDB in any folder (e.g. D:\test\mongodb).
# 
# 2. Unattended Installation
# 
# You may install MongoDB unattended on Windows from the command line using **msiexec.exe.**
# 
#         1.Open an Administrator command prompt.
# Press the Win key, type *cmd.exe*, and press *Ctrl + Shift + Enter* to run the Command Prompt as Administrator.
# 
# Execute the remaining steps from the Administrator command prompt.
# 
#         2.Install MongoDB for Windows.
# Change to the directory containing the *.msi* installation binary of your choice and invoke:
# 
# ```Python
# 
# msiexec.exe /q /i mongodb-win32-x86_64-2008plus-ssl-3.0.15-signed.msi ^
#             INSTALLLOCATION="C:\mongodb" ^
#             ADDLOCAL="all"
#         ```
#         
#         
# You can specify the installation location for the executable by modifying the *INSTALLLOCATION* value.
# 
# By default, this method installs all MongoDB binaries. To install specific MongoDB component sets, you can specify them in the ADDLOCAL argument using a comma-separated list including one or more of the following component sets:
# 
# 
# |**Component Set**   |**Binaries**                                                        |
# |--------------------|--------------------------------------------------------------------|
# |Server              | mongod.exe                                                         |
# |Router              | mongos.exe                                                         | 
# |Client              | mongo.exe                                                          | 
# |MonitoringTools     | mongostat.exe, mongotop.exe                                        |  
# |ImportExportTools   | mongodump.exe, mongorestore.exe, mongoexport.exe, mongoimport.exe  |  
# |MiscellaneousTools  | bsondump.exe, mongofiles.exe, mongooplog.exe, mongoperf.exe        |
# 
# 
# For instance, to install only the MongoDB utilities, invoke:
# 
# 
# ```Python
# 
# msiexec.exe /q /i mongodb-win32-x86_64-2008plus-ssl-3.0.15-signed.msi ^
#             INSTALLLOCATION="C:\mongodb" ^
#             ADDLOCAL="MonitoringTools,ImportExportTools,MiscellaneousTools"
# 
#  ```
#  
#  
# ******
# 
# 
# 
# ### Run MongoDB
# 
# WARNING:
# 
# Do not make mongod.exe visible on public networks without running in “Secure Mode” with the auth setting. MongoDB is designed to be run in trusted environments, and the database does not enable “Secure Mode” by default.
#  
#  1. Set up the MongoDB environment.
#  
# MongoDB requires a data directory https://docs.mongodb.com/v3.0/reference/glossary/#term-dbpath to store all data. MongoDB’s default data directory path is \data\db. Create this folder using the following commands from a *Command Prompt:*
# 
# ```Python 
# md \data\db  ```
# 
# You can specify an alternate path for data files using the --dbpath [https://docs.mongodb.com/v3.0/reference/program/mongod/#cmdoption-mongod-dbpath] option to mongod.exe [https://docs.mongodb.com/v3.0/reference/program/mongod.exe/#bin.mongod.exe], for example:
# 
# ```Python
# C:\mongodb\bin\mongod.exe --dbpath d:\test\mongodb\data ```
# 
# If your path includes spaces, enclose the entire path in double quotes, for example:
# 
# ```Python 
# C:\mongodb\bin\mongod.exe --dbpath "d:\test\mongo db data" ```
# 
# You may also specify the dbpath in a configuration file [https://docs.mongodb.com/v3.0/reference/configuration-options/].
# 
# 
# 2. Start MongoDB.
# 
# To start MongoDB, run mongod.exe. For example, from the Command Prompt:
# 
# ```Python 
# \mongodb\bin\mongod.exe ```
# 
# This starts the main MongoDB database process. The waiting for connections message in the console output indicates that the mongod.exe https://docs.mongodb.com/v3.0/reference/program/mongod.exe/#bin.mongod.exe process is running successfully.
# 
# Depending on the security level of your system, Windows may pop up a Security Alert dialog box about blocking “some features” of *C:\mongodb\bin\mongod.exe* from communicating on networks. All users should select *Private Networks, such as my home or work network* and *click Allow access.* For additional information on security and MongoDB, please see the Security Documentation https://docs.mongodb.com/v3.0/security/.
# 
# 3. Connect to MongoDB.
# 
# To connect to MongoDB through the ~bin.mongo.exe shell, open another *Command Prompt.*
# 
# ```Python 
# C:\mongodb\bin\mongo.exe ```
# 
# If you want to develop applications using .NET, see the documentation of C# and MongoDB [https://docs.mongodb.com/ecosystem/drivers/csharp/] for more information.
# 
# 4. Begin using MongoDB.
# 
# To help you start using MongoDB, MongoDB provides Getting Started Guides [https://docs.mongodb.com/v3.0/#getting-started] in various driver editions. See Getting Started for the available editions.
# 
# Before deploying MongoDB in a production environment, consider the Production Notes[https://docs.mongodb.com/v3.0/administration/production-notes/s]  document.
# 
# Later, to stop MongoDB, press Control+C in the terminal where the mongod [https://docs.mongodb.com/v3.0/reference/program/mongod/#bin.mongod] instance is running.
# 
# 
# *****
# 
# 
# ### Configure a Windows Service for MongoDB
# 
# 1. Open an Administrator command prompt.
# 
# Press the Win key, type *cmd.exe*, and press *Ctrl + Shift + Enter* to run the *Command Prompt* as Administrator.
# 
# Execute the remaining steps from the Administrator command prompt.
# 
# 2. Create directories.
# 
# Create directories for your database and log files:
# ```Python
# mkdir c:\data\db
# mkdir c:\data\log ```
# 
# 3. Create a configuration file.
# 
# Create a configuration file. The file must set systemLog.path [https://docs.mongodb.com/v3.0/reference/configuration-options/#systemLog.path]. Include additional configuration options as appropriate.
# 
# For example, create a file at C:\mongodb\mongod.cfg that specifies both systemLog.path [https://docs.mongodb.com/v3.0/reference/configuration-options/] and storage.dbPath [https://docs.mongodb.com/v3.0/reference/configuration-options/#storage.dbPath]:
# 
# ```Python
# systemLog:
#     destination: file
#     path: c:\data\log\mongod.log
# storage:
#     dbPath: c:\data\db ```
#     
# 4. Install the MongoDB service.
# 
#        IMPORTANT Run all of the following commands in Command   Prompt with “Administrative Privileges”.
# 
# Install the MongoDB service by starting *mongod.exe* [https://docs.mongodb.com/v3.0/reference/program/mongod.exe/#bin.mongod.exe] with the *--install* option and the *-config* option to specify the previously created configuration file.
# 
# ```Python
# "C:\mongodb\bin\mongod.exe" --config "C:\mongodb\mongod.cfg" --install
# ```
# To use an alternate *dbpath*, specify the path in the configuration file *(e.g. C:\mongodb\mongod.cfg)* or on the command line with the --dbpath [https://docs.mongodb.com/v3.0/reference/program/mongod/#cmdoption-mongod-dbpath] option.
# 
# If needed, you can install services for multiple instances of *mongod.exe* or *mongos.exe.* Install each service with a unique *--serviceName* and *--serviceDisplayName.* Use multiple instances only when sufficient system resources exist and your system design requires it.
# 
# 5. Start the MongoDB service.
# 
# ```Python
# net start MongoDB
# ```
# 
# 6. Stop or remove the MongoDB service as needed.
# 
# To stop the MongoDB service use the following command:
# 
# ```Python
# net stop MongoDB
# ```
# To remove the MongoDB service use the following command:
# 
# ```Python
# "C:\mongodb\bin\mongod.exe" --remove
# ```
# 
# #### Manually Create a Windows Service for MongoDB
# 
# You can set up the MongoDB server as a *Windows Service* that starts automatically at boot time.
# 
# The following procedure assumes you have installed MongoDB using the *.msi* installer with the path *C:\mongodb\.*
# 
# If you have installed in an alternative directory, you will need to adjust the paths as appropriate.
# 
# 1. Open an Administrator command prompt.
# 
# Press the *Win* key, type *cmd.exe*, and press *Ctrl + Shift + Enter* to run the *Command Prompt* as Administrator.
# 
# Execute the remaining steps from the Administrator command prompt.
# 
# 2. Create directories.
# 
# Create directories for your database and log files:
# 
# ```Python
# mkdir c:\data\db
# mkdir c:\data\log
# ```
# 
# 3. Create a configuration file.
# 
# Create a configuration file. The file must set *systemLog.path*. Include additional *configuration options* as appropriate.
# 
# For example, create a file at C:\mongodb\mongod.cfg that specifies both *systemLog.path* and *storage.dbPath:*
# 
# ```Python
# systemLog:
#     destination: file
#     path: c:\data\log\mongod.log
# storage:
#     dbPath: c:\data\db
# ```
# 
# 4. Create the MongoDB service.
# 
# Create the MongoDB service.
# 
# ```Python
# sc.exe create MongoDB binPath= "C:\mongodb\bin\mongod.exe --service --config=\"C:\mongodb\mongod.cfg\"" DisplayName= "MongoDB" start= "auto"
# ```
# *sc.exe* requires a space between “=” and the configuration values (eg “binPath= “), and a “" to escape double quotes.
# 
# If successfully created, the following log message will display:
# 
# ```Python
# [SC] CreateService SUCCESS
# ```
# 
# 5. Start the MongoDB service.
# 
# ```Python
# net start MongoDB
# ```
# 
# 6. Stop or remove the MongoDB service as needed.
# 
# To stop the MongoDB service, use the following command:
# 
# ```Python
# net stop MongoDB
# ```
# 
# To remove the MongoDB service, first stop the service and then run the following command:
# 
# ```Python
# sc.exe delete MongoDB
# ```
# 
# ***************
# 
# ## Install MongoDB on Linux
# 
# https://docs.mongodb.com/v3.0/administration/install-on-linux/
# 
# #### Recommended
# 
# For the best installation experience, MongoDB provides packages for popular Linux distributions. These packages, which support specific platforms and provide improved performance and TLS/SSL support, are the preferred way to run MongoDB. The following guides detail the installation process for these systems:
# 
# **Install on Red Hat**
# Install MongoDB on Red Hat Enterprise and related Linux systems using .rpm packages.
# 
# **Install on SUSE**
# Install MongoDB on SUSE Linux systems using .rpm packages.
# 
# **Install on Amazon Linux**
# Install MongoDB on Amazon Linux systems using .rpm packages.
# 
# **Install on Ubuntu**
# Install MongoDB on Ubuntu Linux systems using .deb packages.
# 
# **Install on Debian**
# Install MongoDB on Debian systems using .deb packages.
# 
# For systems without supported packages, refer to the Manual Installation tutorial.
# 
# #### Manual Installation
# 
# For Linux systems without supported packages, MongoDB provides a generic Linux release. These versions of MongoDB don’t include TLS/SSL, and may not perform as well as the targeted packages, but are compatible on most contemporary Linux systems. See the following guides for installation:
# 
# Install MongoDB From Tarball
# Install the official build of MongoDB on other Linux systems from MongoDB archives.
# 
# **********
# 
# ## Install MongoDB on macOS
# 
# https://docs.mongodb.com/v3.0/tutorial/install-mongodb-on-os-x/
# 
# **********
# **********
# 
# ## Source
# 
# https://docs.mongodb.com/v3.0/
# 

# ***************
# 
# Command prompt
# 
# It is important to open the command prompt as administrator: 
# 
# ```Python
# C:\Program Files\Python37>python -m pip install --user --upgrade pip
# Collecting pip
#   Using cached https://files.pythonhosted.org/packages/d8/f3/413bab4ff08e1fc4828dfc59996d721917df8e8583ea85385d51125dceff/pip-19.0.3-py2.py3-none-any.whl
# Installing collected packages: pip
#   Found existing installation: pip 18.1
#     Uninstalling pip-18.1:
#       Successfully uninstalled pip-18.1
# Successfully installed pip-19.0.3
# 
# C:\Program Files\Python37>pip install pymongo==3.7.2
# Collecting pymongo==3.7.2
#   Using cached https://files.pythonhosted.org/packages/10/35/f081e8f16cb357cc1e082743fed98fb699f3b9f215addc1b4b8bd1b58472/pymongo-3.7.2-cp37-cp37m-win_amd64.whl
# Installing collected packages: pymongo
# Successfully installed pymongo-3.7.2
# 
# ```

# ## Exercise 1
# 
# Create a database called "Food Center":
# 
# **Important: In MongoDB, a database is not created until it gets content!**
# 
# *MongoDB waits until you have created a collection (table), with at least one document (record) before it actually creates the database (and collection).*

# In[24]:



import pymongo
myclient = pymongo.MongoClient('mongodb://localhost:27017/')
mydb = myclient['FoodCenter']

# database created!


# **You can check if a database exist by listing all databases in you system:**

# In[25]:


#Return a list of your system's databases:
import pymongo
myclient = pymongo.MongoClient('mongodb://localhost:27017/')
print(myclient.list_database_names())



# In[26]:


#We check a specific database by name:
import pymongo
myclient = pymongo.MongoClient('mongodb://localhost:27017/')
dblist = myclient.list_database_names()
if "FoodCenter" in dblist:
  print("The database exists.")


# *Important: In MongoDB, a collection is not created until it gets content!*
# 
# **Create a collection called "customers":**
# 

# In[27]:


import pymongo
myclient = pymongo.MongoClient('mongodb://localhost:27017/')
mydb = myclient['FoodCenter']
mycol = mydb["customers"]


# **Return a list of all collections in your database:**

# In[28]:


print(mydb.list_collection_names())


# **Check if the "customers" collection exists**

# In[29]:


collist = mydb.list_collection_names()
if "customers" in collist:
  print("The collection exists.")


# **Check if the "customers" collection exists:**

# In[30]:


import pymongo
myclient = pymongo.MongoClient('mongodb://localhost:27017/')
mydb = myclient['FoodCenter']
mycol = mydb["customers"]
mydict = { "NAME": "Lisbor Hotel","LOCATION": "No. 4, Sokponba Road, B/C." }
x = mycol.insert_one(mydict)
print(x)


# *The insert_one() method returns a InsertOneResult object, which has a property, inserted_id, that holds the id of the inserted document.*
# 
# **Insert another record in the "customers" collection, and return the value of the _id field:**
# 
# 

# In[32]:


import pymongo
myclient = pymongo.MongoClient('mongodb://localhost:27017/')
mydb = myclient['FoodCenterBenin']
mycol = mydb["customers"]
mydict = { "NAME": "Matice Fast Food",
   "LOCATION": "No. 12, Sokponba Road, B/C." }
x = mycol.insert_one(mydict)
print(x.inserted_id)


# *If you do not specify an _id field, then MongoDB will add one for you and assign a unique id for each document.
# In the code above no _id field was specified, so MongoDB assigned a unique _id for the record (document).*

# ## Exercise 2
# 
# To insert multiple documents into a collection in MongoDB, we use the insert_many() method.
# 
# The insert_many() method returns a InsertManyResult object, which has a property, inserted_ids, that holds the ids of the inserted documents.
# 
# The first parameter of the insert_many() method is a list containing dictionaries with the data you want to insert:
# 

# In[35]:


import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["FoodCenter"]
mycol = mydb["customers"]

mylist = [
 {
   "NAME": "Lisbor Hotel",
   "LOCATION": "No. 4, Sokponba Road, B/C."
 },
 {
   "NAME": "Matice Fast Food",
   "LOCATION": "No. 12, Sokponba Road, B/C."
 },
 {
   "NAME": "Vesa Sea Food",
   "LOCATION": "100A, Off Sokponba Road, B/C."
 },
 {
   "NAME": "Debbies Kitchen",
   "LOCATION": "No. 61, Sokponba, Road, B/C."
 },
 {
   "NAME": "Mrs. Owen",
   "LOCATION": "No. 73B, 2nd East Circular Road, B/C"
 },
 {
   "NAME": "Mama Rita Cold Room",
   "LOCATION": "Sokponba by 2nd East Cikrcular Road, B/C."
 },
 {
   "NAME": "Mrs. UY Fried and Cold Room",
   "LOCATION": "Evbarune , Gbefo Street, B/C."
 },
 {
   "NAME": "Eddyibanga Int. Ltd",
   "LOCATION": ""
 },
 {
   "NAME": "Farmers Shopping complex",
   "LOCATION": "No. 78, Sokponba Road, B/C"
 },
 {
   "NAME": "The Phimas Garden Hotel",
   "LOCATION": "No. 3, Obazuina Street, Off 1st East Circular Road, Benin City."
 },
 {
   "NAME": "Usama Ivory Hotel",
   "LOCATION": "No. 169, 1st East Circular Road, B/C."
 },
 {
   "NAME": "Two Sisters  Cold Room",
   "LOCATION": "No. 105, Sokponba Road, B/C."
 },
 {
   "NAME": "Mama Enoghayin Cold Room",
   "LOCATION": "No. 105, Sokponba Road, B/C."
 },
 {
   "NAME": "Clement Uyiekpen Cold Room",
   "LOCATION": "No. 73B, 2nd East Circular Road, B/C"
 },
 {
   "NAME": "Rito Cold Room",
   "LOCATION": "No. 105, Sokponba Road, B/C."
 },
 {
   "NAME": "Efifa Cold Room",
   "LOCATION": "No. 105, Sokponba Road, B/C."
 },
 {
   "NAME": "Christy Guest House",
   "LOCATION": "No. 106, Sokponba Road, B/C"
 },
 {
   "NAME": "Sunday M. Meat Shop",
   "LOCATION": "No. 11, Oba Market Road, B/C."
 },
 {
   "NAME": "G.T.I Meat Shop",
   "LOCATION": "No. 25 & 26, Oba Market Road, B/C."
 },
 {
   "NAME": "Judgement MeAT Shop",
   "LOCATION": "No. 11, Oba Market Road, B/C."
 },
 {
   "NAME": "Mrs. Ewalefo",
   "LOCATION": "No. 5, Oba M arket Roiad, B/C."
 },
 {
   "NAME": "Omeka Meat Shop",
   "LOCATION": "No. 24, Oba Market Road, B/C."
 },
 {
   "NAME": "Uzee Meat Shop",
   "LOCATION": "No. 24, Oba Market Road, B/C."
 },
 {
   "NAME": "Meat Shop",
   "LOCATION": "No. 3, Oba Market Road, B/C."
 },
 {
   "NAME": "Mrs. V. Meat Shop",
   "LOCATION": "No. 105, Oba Market Road, B/C."
 },
 {
   "NAME": "Meat Shop",
   "LOCATION": "No. 9, Oba Market Road, B/C."
 },
 {
   "NAME": "I. V. Frozen Food",
   "LOCATION": "No. 18, Oba Market Road, B/C."
 },
 {
   "NAME": "Mrs Rita Odiowe",
   "LOCATION": "No. 11, Oba Market Road, B/C."
 },
 {
   "NAME": "Godfrey Meat",
   "LOCATION": "No. 24, Oba Market Road, B/C."
 },
 {
   "NAME": "Mr. Edogun",
   "LOCATION": "No. 10, Old Oguanogbe Street, B/C."
 },
 {
   "NAME": "Sunny Gas Meat",
   "LOCATION": "No. 24, Oba Market Road, B/C."
 },
 {
   "NAME": "Mrs. Ozede Meat Shop",
   "LOCATION": "No. 12, Ekp;enede Street, B/C."
 },
 {
   "NAME": "Mrs Ebbuzugbe Ice-Cream Shop",
   "LOCATION": "No. 10 Old Uguanogbe Street, B/C."
 },
 {
   "NAME": "C. O. Meat Shop",
   "LOCATION": "No. 22, O ba Market Road, B/C. "
 },
 {
   "NAME": "Mrs. Omorodion",
   "LOCATION": "No. 22, O ba Market Road, B/C. "
 },
 {
   "NAME": "B. B. Meat Shop",
   "LOCATION": "No. 5, Oba M arket Roiad, B/C."
 },
 {
   "NAME": "Destiny Meat Shop",
   "LOCATION": "No. 24, Oba Market Road, B/C."
 },
 {
   "NAME": "Sunday Meat Shoip",
   "LOCATION": "No. 11, Oba Market Road, B/C."
 },
 {
   "NAME": "Mrs Omoregie Meat Shop",
   "LOCATION": "No. 18C, Oba Market Road, B/C."
 },
 {
   "NAME": "F. O. Meat Shop",
   "LOCATION": "No. 18C, Oba Market Road, B/C."
 },
 {
   "NAME": "Pat O. Meat Shop",
   "LOCATION": "Oba Market Road, B/C."
 },
 {
   "NAME": "Mrs Adeban jo Meat Shop",
   "LOCATION": "No. 22, O ba Market Road, B/C. "
 },
 {
   "NAME": "Mr. Tofa Meat Shop",
   "LOCATION": "No. 24, Oba Market Road, B/C."
 },
 {
   "NAME": "Joseph Meat Shop",
   "LOCATION": "No. 22, O ba Market Road, B/C. "
 },
 {
   "NAME": "OTF NI Meat",
   "LOCATION": "No. 24, Oba Market Road, B/C."
 },
 {
   "NAME": "Blessed Boy Meat Shop",
   "LOCATION": "No. 26, Oba Market Road, B/C."
 },
 {
   "NAME": "Christy Meat Shop",
   "LOCATION": "No. 7, Oba Mnarket Road, B/C."
 },
 {
   "NAME": "Ororo Cold Room",
   "LOCATION": "Ogbe Quarters, Benin City"
 },
 {
   "NAME": "Fan Milk Product",
   "LOCATION": "No. 41, Ekenwan Road, B/C."
 },
 {
   "NAME": "Mrs Enabbulele",
   "LOCATION": "No. 14, Plymouth Road, B/C."
 },
 {
   "NAME": "Mrs Enabbulele",
   "LOCATION": "No. 18, Plymouth Road, B/C."
 },
 {
   "NAME": "G.T. Fast Food",
   "LOCATION": "No. 60, Ekenwan Road, B/C."
 },
 {
   "NAME": "Mr. Biggs Fast Food",
   "LOCATION": "No. 107, Ekenwan Road, B/C."
 },
 {
   "NAME": "Matice",
   "LOCATION": "No. 99, Ekenwan Road, B/C."
 },
 {
   "NAME": "Kicken Republic",
   "LOCATION": "No. 100, Ekenwan Road, B/C."
 },
 {
   "NAME": "Frozen Food",
   "LOCATION": "Ogbe Quarters"
 },
 {
   "NAME": "Rima Bakery",
   "LOCATION": "No. 45, Ogiemudia Street, Ovboutubu Qtrs. B/C."
 },
 {
   "NAME": "Onious Fl avour Hotel",
   "LOCATION": "No. 282, Upper Ekenwan Road, B/C."
 },
 {
   "NAME": "Eddes Restaurant",
   "LOCATION": "No. 2, Ekenwan Road, B/C."
 },
 {
   "NAME": "Bensuhi Guest House",
   "LOCATION": "Ekenwan Road, Benin City."
 },
 {
   "NAME": "Madam Osagiede Restaurant",
   "LOCATION": "No. 33, Oba Market Road, B/C."
 },
 {
   "NAME": "Donhen Frozen Food",
   "LOCATION": "No. 30, Aba Market Rolad, B/C."
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "By Emotan Hotel, C.I.D. Road, B/C."
 },
 {
   "NAME": "Mr. Biggs Fast Food",
   "LOCATION": "No. 65, Sapele Road, B/C."
 },
 {
   "NAME": "Isoken Bar",
   "LOCATION": "No. 55, Sapele Road, B/C."
 },
 {
   "NAME": "Restaurant & Bar",
   "LOCATION": "Ekae/Evbouriaria Area, Sapele Road, B/C."
 },
 {
   "NAME": "Madam B. Restaurant",
   "LOCATION": "No. 1, Isekhure Way, Sapele Road, B/C."
 },
 {
   "NAME": "Shaden Bakery",
   "LOCATION": "No. 4, Owegie Street, Off Ekenwan Rfoad, B/C."
 },
 {
   "NAME": "K.F.C Plaza",
   "LOCATION": "Ekenwan Road, Benin City."
 },
 {
   "NAME": "Pounded Yam Restaurant",
   "LOCATION": "No. 100, Ekenwan Road, B/C."
 },
 {
   "NAME": "Mr. Frank Hotel",
   "LOCATION": "No. 401, Upper Ekenwan Road, B/C."
 },
 {
   "NAME": "Bright Kitchen",
   "LOCATION": ""
 },
 {
   "NAME": "Embo Restaurant/Bar",
   "LOCATION": "No. 26, Airport Road, B/C."
 },
 {
   "NAME": "Taste & Class Restaurant and Bar",
   "LOCATION": "No. 36, Airport Road, B/C."
 },
 {
   "NAME": "Pepper Rice",
   "LOCATION": "Chief Osama Shopping Complex, B/C."
 },
 {
   "NAME": "Amala Satisfying Meal",
   "LOCATION": "Chief Osama Shopping Complex, B/C."
 },
 {
   "NAME": "Chin Chin Restaurant",
   "LOCATION": "No. 26, Ezoti Street, B/C."
 },
 {
   "NAME": " Food Outlet",
   "LOCATION": "No. 6, Airport Road, B/C."
 },
 {
   "NAME": "Zion Pepper Rice",
   "LOCATION": "Chief Osama Shopping Complex, B/C."
 },
 {
   "NAME": "Mama Put",
   "LOCATION": "Ibewe Street, B/C."
 },
 {
   "NAME": "Eddy Meat Shop",
   "LOCATION": "61, Yoruba Str. Benin City"
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "No. 39, Boundary Road, B/C."
 },
 {
   "NAME": "Ukunuyi Store",
   "LOCATION": "No. 1, Off Boundary Road, G.R.A., B/C."
 },
 {
   "NAME": "The Right Choice",
   "LOCATION": "No. 43, Ihama Street, B/C."
 },
 {
   "NAME": "Car Wash",
   "LOCATION": "No. 21, Adesuwa Road, Off Sapele Road, B/C."
 },
 {
   "NAME": "Bright Restaurant & Bar",
   "LOCATION": "No. k2, Adesuwa Road, Off Sapele Road, B/C."
 },
 {
   "NAME": "Kem Crescent & Bar",
   "LOCATION": "No. 37, Ihama Street, G.R.A., B/C."
 },
 {
   "NAME": "Madam Ihama",
   "LOCATION": "No. 46, Ihama Street, G.R.A., B/C."
 },
 {
   "NAME": "Theresa Restaurant & Bar",
   "LOCATION": ""
 },
 {
   "NAME": "U.K. Bread ",
   "LOCATION": "No. 38, L agos Street, B/C."
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "No. 208, Upper Sokponba Road, B/C."
 },
 {
   "NAME": "Randehi Royal Hotel",
   "LOCATION": "No. 6, off Ihama Street, B/C."
 },
 {
   "NAME": "Amala Sport",
   "LOCATION": "Ebeneza Junction, G.R.A., B/C."
 },
 {
   "NAME": "The Dinner Food Outlet",
   "LOCATION": "Utop Filling Station, Airport Road, B/C."
 },
 {
   "NAME": "Vics Fast Food",
   "LOCATION": "No. 36, Ihama Street, B/C."
 },
 {
   "NAME": "Odia Sea Fish Food",
   "LOCATION": " No. 35, Airport Road, B/C."
 },
 {
   "NAME": "Shape Quest House/Bar",
   "LOCATION": "No. 82, Akenzua Street, B/C."
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "No. 3. Igun Street, B/C."
 },
 {
   "NAME": "Ogo Food Outlet",
   "LOCATION": "No. 10, Sokponba Road, B/C."
 },
 {
   "NAME": "Act Restaurant antd Bar",
   "LOCATION": "Nlo. 20, Ogongosun Street, B/C."
 },
 {
   "NAME": "Modest Kitchen",
   "LOCATION": "No. 25, Dumez Road, B/C."
 },
 {
   "NAME": "Amala Spot, Restaurant & Bar",
   "LOCATION": "No. 4, Ogbelaka Street, B/C."
 },
 {
   "NAME": "Tonmard Food Outlet",
   "LOCATION": "No. 31, Dumez Road, B/C."
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "No. 4, Sakponba Road, B/C."
 },
 {
   "NAME": "Nosakhare Bakery",
   "LOCATION": "No. 1, Nosakhare Street, Upper Mission Road, B/C."
 },
 {
   "NAME": "De Peak Restaurant",
   "LOCATION": "No. 16, Dawnson Road, B/C."
 },
 {
   "NAME": "Mafretis Food",
   "LOCATION": "Aram Plaza, New Lagos Road, B/C."
 },
 {
   "NAME": "Unibake Bread",
   "LOCATION": "No. 9, 2nd Victory Street, New Benin, B/C."
 },
 {
   "NAME": "Madam Stainless Restaurant & Bar",
   "LOCATION": "No. 37, Constain Road, New Benin, B/C."
 },
 {
   "NAME": "Citizen Hotel",
   "LOCATION": "No. 40B, Uwa Street, Off Sapele Road, B/C."
 },
 {
   "NAME": "Victory Hotel",
   "LOCATION": "Victory road, Off New Lagos Road, New Benin, B/C."
 },
 {
   "NAME": "State CLO Food Outlet",
   "LOCATION": "Benin-City."
 },
 {
   "NAME": "Food is Ready Restaurant & Bar",
   "LOCATION": "63, sapele Road, Benin City"
 },
 {
   "NAME": "Kada Plaza",
   "LOCATION": "35, Sapele road, Benin City"
 },
 {
   "NAME": "western Hotel",
   "LOCATION": "22A, M M Way, Benin City"
 },
 {
   "NAME": "Apex kitchen",
   "LOCATION": "Km 12, Sapele Road,  Benin City"
 },
 {
   "NAME": "Stallion Sea Food",
   "LOCATION": "Sapele Road, Benin City"
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "56, Sapele Road,  Benin City"
 },
 {
   "NAME": "Restaurant & Bar",
   "LOCATION": "63, sapele Road, Benin City"
 },
 {
   "NAME": "Eddna Water",
   "LOCATION": "18, Ikpokpan Road, Benin City"
 },
 {
   "NAME": "Nkechi Food Outlet",
   "LOCATION": "20, Upper sakponba Road,  Benin City"
 },
 {
   "NAME": "Nwokoyo Eze",
   "LOCATION": "4, Osunde Street, upper Sakponba Road,  Benin City"
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "124, Upper Sakponba Road,  Benin City"
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "28, Igbesamwan Street, Benin City"
 },
 {
   "NAME": "Restaurant ",
   "LOCATION": "2, Igbesanmwan Street, Benin City"
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "24, Upper Sakponba Road, Benin City"
 },
 {
   "NAME": "Spaco Restaurant",
   "LOCATION": "5, Ugbague Street, Benin city"
 },
 {
   "NAME": "Restaurant & Bar",
   "LOCATION": "155, 2nd East Circular Road,  Benin City"
 },
 {
   "NAME": "Restaurant & Bar",
   "LOCATION": "18, Igingan Stree,t Benin City"
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "36A, 2nd East Circular Road,  Benin City"
 },
 {
   "NAME": "Petty Berist",
   "LOCATION": "42, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "western Bakery",
   "LOCATION": "10, Ekpenede street, Benin City"
 },
 {
   "NAME": "Shedrach Hulticulture & Agro chemical Ventures",
   "LOCATION": "1, College  Road, Benin City"
 },
 {
   "NAME": "Face to face Restaurant & bar",
   "LOCATION": "242, Upper sakponba Road, Benin City"
 },
 {
   "NAME": "Presidential Hotel",
   "LOCATION": "265, Upper Sakponba Road, Benin City"
 },
 {
   "NAME": "Cold Room ",
   "LOCATION": "Obasogie Street, Benin City"
 },
 {
   "NAME": "Edo / Delta Hotel",
   "LOCATION": "134, Akpakpava Road, Benin City"
 },
 {
   "NAME": "Cold Room ",
   "LOCATION": "87, Second East Circular Road, Benin City"
 },
 {
   "NAME": "Winsa Frozen Food",
   "LOCATION": "93, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Meat Shop",
   "LOCATION": "91, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Iyamu Cold Room",
   "LOCATION": "3, Ekiosa Street, Benin City"
 },
 {
   "NAME": "Osato meat Shop",
   "LOCATION": "91, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Restaurant & Bar",
   "LOCATION": "97, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Cold Room ",
   "LOCATION": "96, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Cold Room ",
   "LOCATION": "77, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Meat Shop",
   "LOCATION": "2nd East Circular Road,  Benin City"
 },
 {
   "NAME": "Cold Room ",
   "LOCATION": "85, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Table water",
   "LOCATION": "Igbinedion Street, Benin City"
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "39, Boundary Road, Benin City"
 },
 {
   "NAME": "Ukumuyi Stores",
   "LOCATION": "1, off Boundary  Road, Benin City"
 },
 {
   "NAME": "Kish Bar",
   "LOCATION": "46, Ihama Road,  Benin City"
 },
 {
   "NAME": "Eddy Meat Shop",
   "LOCATION": "61, Yoruba Str. Benin City"
 },
 {
   "NAME": "Restaurant",
   "LOCATION": "22,  Igbesamwan  Road,  Benin City"
 },
 {
   "NAME": "Cold Room ",
   "LOCATION": "17B, Orobato street, Benin City"
 },
 {
   "NAME": "Cold Room ",
   "LOCATION": "91, 2nd East Circular Road,  Benin City"
 },
 {
   "NAME": "Space Restaurant",
   "LOCATION": "5, Ugbague Street, Benin city"
 },
 {
   "NAME": "Cold Room ",
   "LOCATION": "Evbarunegbefo Street, Ekiosa, Benin City"
 },
 {
   "NAME": "Our Choice water",
   "LOCATION": "Ehaekpen, off Akpakpava street, Benin City"
 },
 {
   "NAME": "Restaurant & Bar",
   "LOCATION": "9, Owoseni Street, Benin City"
 },
 {
   "NAME": "Cold Room ",
   "LOCATION": "9, Efehi Street, Off New lagos  Road, Benin City"
 },
 {
   "NAME": "Bins Hotel",
   "LOCATION": "200A, Ekenwan  Road, Benin City"
 },
 {
   "NAME": "Mr Biggs",
   "LOCATION": "1, Ihama  Road,  Benin City"
 },
 {
   "NAME": "Talk of the Town",
   "LOCATION": "Ede Shopping Complex, Benin City"
 },
 {
   "NAME": "DA Civic Centre",
   "LOCATION": "By Ben Oni Junction, Benin City"
 },
 {
   "NAME": "Supreme Guest House",
   "LOCATION": "28, ben-Oni Road, Benin City"
 },
 {
   "NAME": "Constantial Hotel",
   "LOCATION": "Airport Road,  Benin City"
 },
 {
   "NAME": "Fredric A Hotel",
   "LOCATION": "1, Fred close off gapiona Road, Benin City"
 },
 {
   "NAME": "Fedgard",
   "LOCATION": "JBS Estate, off Boundary Road, Benin City"
 },
 {
   "NAME": "Ritz chartlton Hotel",
   "LOCATION": "64, Boundary Road,  Benin City"
 },
 {
   "NAME": "Motel Benin Plaza",
   "LOCATION": "GRA, Benin City"
 },
 {
   "NAME": "Court Yard Hotel ",
   "LOCATION": "1, Boundary Road, Benin City"
 },
 {
   "NAME": "Bibi Hotel",
   "LOCATION": "72B, Boundary Road, Benin City"
 },
 {
   "NAME": "Bar",
   "LOCATION": "10, 2nd East Circular  Road, Benin City"
 },
 {
   "NAME": "Osakpolor Seas Food",
   "LOCATION": "85, Oliha Palace, Benin City"
 },
 {
   "NAME": "Obazee Cold Room",
   "LOCATION": "Oliha Palace, Benin City"
 },
 {
   "NAME": "Nice Time Restaurant",
   "LOCATION": "8, Uzama street Benin City"
 },
 {
   "NAME": "Devine Cold room",
   "LOCATION": "Oliha Palace, Benin City"
 },
 {
   "NAME": "Restaurant & Bar",
   "LOCATION": "27, T.V Road, Benin City"
 },
 {
   "NAME": "Decency Restaurant & Bar",
   "LOCATION": "Aideyan Avenue, GRA, Benin city"
 },
 {
   "NAME": "Mrs Okafor Restaurant & Bar",
   "LOCATION": "55, New Lagos Road, Benin City"
 },
 {
   "NAME": "Meat Shop",
   "LOCATION": "2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Patient Eze",
   "LOCATION": "63, New lagos  Road,  Benin City"
 },
 {
   "NAME": "Mrs Enabulele",
   "LOCATION": "45, Yoruba street, Benin City"
 },
 {
   "NAME": "Cold Room ",
   "LOCATION": "13B, Owoseni street, Benin City"
 },
 {
   "NAME": "Cold Room ",
   "LOCATION": "13, Owoseni street, Benin City"
 },
 {
   "NAME": "Cold Room ",
   "LOCATION": "63, New lagos  Road,  Benin City"
 },
 {
   "NAME": "Joe Bakery",
   "LOCATION": "18, 1st East Circular Road,  Benin City"
 },
 {
   "NAME": "Mrs Igbinaduwa Cold Room",
   "LOCATION": "Oliha Palace, Benin City"
 },
 {
   "NAME": "Agbel Bar",
   "LOCATION": "61, Ehaekpen Street Benin City"
 },
 {
   "NAME": "Lucky Restaurant",
   "LOCATION": "28, T.V Road, Benin City"
 },
 {
   "NAME": "Kelvison Restaurant & Bar",
   "LOCATION": "178, Siluko Road, Benin City"
 },
 {
   "NAME": "Octagon Restaurant & Bar",
   "LOCATION": "Uwaifo Street, off Siluko Road,  Benin City"
 },
 {
   "NAME": "Insight Bakery",
   "LOCATION": "102c, Siluko Road,  Benin City"
 },
 {
   "NAME": "Eranori Pure Water",
   "LOCATION": "2, Obanosa Street, off Siluko Road, Benin City"
 },
 {
   "NAME": "St Gordon Hotel",
   "LOCATION": "165, Sapele Road, Benin City"
 },
 {
   "NAME": "Twin light Hotel",
   "LOCATION": "32, Wire Road, Benin City"
 },
 {
   "NAME": "Shabel Bakery",
   "LOCATION": "50, T.V Road,  Benin City"
 },
 {
   "NAME": "Restaurant & Bar",
   "LOCATION": "74, Sakpoba Road,  Benin City"
 },
 {
   "NAME": "Mr Good Luck Meat Shop",
   "LOCATION": "15, Oba market Road, Benin City"
 },
 {
   "NAME": "Feb Meat  Shop",
   "LOCATION": "18, Oba market Road,  Benin City"
 },
 {
   "NAME": "The Freedom Meat Shop",
   "LOCATION": "13, Oba Market Road,  Benin City"
 },
 {
   "NAME": "Classic Frozen food",
   "LOCATION": "13, Oba Market Road,  Benin City"
 },
 {
   "NAME": "Judge Meat Shop",
   "LOCATION": "11, Oba market Road,  Benin City"
 },
 {
   "NAME": "D' Flavour Fast Food",
   "LOCATION": "38, Ekenwan Road,  Benin City"
 },
 {
   "NAME": "Asoteni Hotels",
   "LOCATION": "No. 5A, Ihama Str. Benin City"
 },
 {
   "NAME": "Royal Mable",
   "LOCATION": "Ihama GRA, B/C"
 },
 {
   "NAME": "Zeelodge Bar",
   "LOCATION": "No. 17, Boundry Rd, GRA, Benin City."
 },
 {
   "NAME": "Koso Inter Hotel Guest House",
   "LOCATION": "No. 5, Tonny Annenih Avenue, GRA, BeninCity"
 },
 {
   "NAME": "Farnec Guest House",
   "LOCATION": "No. 4, Tonny Annenih Avenue, GRA, BeninCity"
 },
 {
   "NAME": "Big Joe Hotel",
   "LOCATION": "No. 13, Adesuwa Rd, Benin City."
 },
 {
   "NAME": "C & A Kichen Fast Food",
   "LOCATION": "No. 1, Adesuwa Road, Benin City."
 },
 {
   "NAME": "Patient Ijebu Restaurant & Bar",
   "LOCATION": "No. 84, Sapele Rd, Benin City."
 },
 {
   "NAME": "Mani Igie Food Centre",
   "LOCATION": "No. 165, Sapele Rd, Benin City."
 },
 {
   "NAME": "Chenijav Guest House",
   "LOCATION": "No. 1, Ogiefua Avenue, off St. Saviour Rd, Benin City"
 },
 {
   "NAME": "IVB Meat Shop",
   "LOCATION": "No. 6A, IzuinaSt. New Benin, Benin City."
 },
 {
   "NAME": "Madani Helen meat Shop",
   "LOCATION": "No. 51, New Lagos Road, B/C"
 },
 {
   "NAME": "Iyayi brother Cool Room",
   "LOCATION": "No. 94, 2nd East Circular Rd, B/C"
 },
 {
   "NAME": "Meat Cold Room",
   "LOCATION": "No 8, lawani St. New Benin, B/C"
 },
 {
   "NAME": "Mrs. Queen Amadin Cold Room",
   "LOCATION": "No. 1, Upper lawani St. off new Lagos Rd, B/C"
 },
 {
   "NAME": "Mrs. C. Iyayi Cold Room",
   "LOCATION": "No. 11, Udukpayi St. New Benin, B/C"
 },
 {
   "NAME": "Mrs. Bello Cold Room",
   "LOCATION": "No. 3, okundaiye St. off new benin, B/C"
 },
 {
   "NAME": "Mrs. Big Fast Food",
   "LOCATION": "No. 57, Akpakpava St. B/C"
 },
 {
   "NAME": "Twins Food Outlet",
   "LOCATION": "No. 59, 1st East Circular Rd, B/C"
 },
 {
   "NAME": "BB Spits Fast Food",
   "LOCATION": "No. 37, 1st East Circular Rd, B/C"
 },
 {
   "NAME": "Opeyemi Bakery",
   "LOCATION": "No. 9, Noruwa St. Old Western Rd, B/C"
 },
 {
   "NAME": "Restaurant & Bar",
   "LOCATION": "No. 29, New lagos rd, B/C"
 },
 {
   "NAME": "Mrs. Omokaro restaurant & bar",
   "LOCATION": "No. 65, Lawani St. Off new Lagos Rd, B/C"
 },
 {
   "NAME": "Restaurant & Bar",
   "LOCATION": "No. 40, New Lagos Rd, B/C"
 },
 {
   "NAME": "Makacin Restaurant & Bar",
   "LOCATION": "Boundry Rd, GRA. B/C"
 },
 {
   "NAME": "Mr. N. Omorodion Food Outlet",
   "LOCATION": "No. 92, igun Str. B/C"
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "No. 7, Oka Eben Str. Off James Watt Rd, B/C"
 },
 {
   "NAME": "Food is Ready",
   "LOCATION": "No. 53A, Akpakpava Str. B/C"
 },
 {
   "NAME": "Mrs. Osagie Restaurant & bar",
   "LOCATION": "No. 140, 2nd East Circular Rd, B/C"
 },
 {
   "NAME": "Victoria Obasuyi",
   "LOCATION": "No. 27, Eguadase Str. B/C"
 },
 {
   "NAME": "Restaurant & Bar",
   "LOCATION": "By Iyobosa Junction, 2nd East Circular Rd, B/C"
 },
 {
   "NAME": "Madam T. Amala Sport",
   "LOCATION": "No. 27C, Ehaikpen Str. B/C"
 },
 {
   "NAME": "our Choice Table Water",
   "LOCATION": "No. 20, Ehaikpen Str. B/C"
 },
 {
   "NAME": "Madani Rstaurant Bar",
   "LOCATION": "No. 29, Akpakpava Str. B/C"
 },
 {
   "NAME": "Mama Chinedu Cold Room",
   "LOCATION": "No. 49b, new Lagos Rd, B/C"
 },
 {
   "NAME": "Mr. obazee Cold Room",
   "LOCATION": "No. 39, Yoruba Str. Off New Lagos Rd, B/C"
 },
 {
   "NAME": "Mrs. Ehigie Cold Room",
   "LOCATION": "No. 39, Yoruba Str. Off New Lagos Rd, B/C"
 },
 {
   "NAME": "Mrs. Omoruyi Cold Room",
   "LOCATION": "No. 39B, Yoruba Str. Off New Lagos Rd, B/C"
 },
 {
   "NAME": "Mrs. Akhitenor Cold Room",
   "LOCATION": "No. 39B, Yoruba Str. Off New Lagos Rd, B/C"
 },
 {
   "NAME": "Mrs. Onio-Atu Cold Room",
   "LOCATION": "No. 48, Yoruba Str. Off New Lagos Rd, B/C"
 },
 {
   "NAME": "Mrs. Iyamu Cold Room",
   "LOCATION": "No. 6, 1st ofumwengbe Str. New lagos Rd, B/C"
 },
 {
   "NAME": "Christian Bar",
   "LOCATION": "NO. 1, Ofumwengbe Str. New Benin, B/C"
 },
 {
   "NAME": "Mr. Moses Cold Room",
   "LOCATION": "NO. 1, Ofumwengbe Str. New Benin, B/C"
 },
 {
   "NAME": "Broker's Diary Product",
   "LOCATION": "No. 12, 3rd Cementry Rd, B/C"
 },
 {
   "NAME": "Mrs. Osemwigie Meat Shop",
   "LOCATION": "No. 24, Oba Market Rd, B/C"
 },
 {
   "NAME": "Success Bakery",
   "LOCATION": "No. 140, Erediauwa Str. Off upper SokponbaRd, B/C"
 },
 {
   "NAME": "Piret Hotel",
   "LOCATION": "No. 6, Evbo Minan Str.  Off Sapele Rd, B/C"
 },
 {
   "NAME": "Meridian Lodge",
   "LOCATION": "No. 2, Adenomo Cresent. Off Etete GRA, B/C"
 },
 {
   "NAME": "Mrs. B. Ohenhen",
   "LOCATION": "No. 70, Siluko Rd, B/C"
 },
 {
   "NAME": "Our Lord Bakery",
   "LOCATION": "No. 11, Owenubugie Str. Useh market Rd, B/C"
 },
 {
   "NAME": "Restaurant & Bar",
   "LOCATION": "No. 74, Sakponba Rd, B/C"
 },
 {
   "NAME": "World Circle Bar",
   "LOCATION": "No. 124, 1st East Circular Rd, B/C"
 },
 {
   "NAME": "Mrs. Aigbogun Meat Shop",
   "LOCATION": "No. 94, 2nd East Circular Rd, B/C"
 },
 {
   "NAME": "Mama Kate Restaurant & Bar",
   "LOCATION": "No. 194, Upper Mission Rd, B/C"
 },
 {
   "NAME": "Felona Hotels",
   "LOCATION": "No. 6, Downson Rd, B/C"
 },
 {
   "NAME": "Mrs. G. Egbetu",
   "LOCATION": "Orobator Str. Off 2nd East Circular Rd, B/C"
 },
 {
   "NAME": "Rossy Bakery",
   "LOCATION": "No. 198, MM Way, B/C"
 },
 {
   "NAME": "Mrs. Aimienoho",
   "LOCATION": "No. 20, obasogie Str. 2nd East Circular Rd, B/C"
 },
 {
   "NAME": "Mrs. Okhomina",
   "LOCATION": "No. 20, obasogie Str. 2nd East Circular Rd, B/C"
 },
 {
   "NAME": "RosefSea Food ",
   "LOCATION": "No. 31B, Yorua Str. B/C"
 },
 {
   "NAME": "Ekipec Resources",
   "LOCATION": "No. 31, Yoruba Str. B/C"
 },
 {
   "NAME": "Rossy Bakery",
   "LOCATION": "MM Way, Opp. Ekiosa Market, B/C"
 },
 {
   "NAME": "Jor & Restaurant",
   "LOCATION": "No. 53, Upper Sakponba Rd, B/C"
 },
 {
   "NAME": "Hotel Philomena",
   "LOCATION": "No. 19, Okhoro Rd, B/C"
 },
 {
   "NAME": "Blessed Edozen Bakery",
   "LOCATION": "No. 9, Eyanugie Str. 1st East Circular Rd, B/C"
 },
 {
   "NAME": "Omega Fast Food",
   "LOCATION": "No. 125, new Lagos Rd, B/C"
 },
 {
   "NAME": "Inaynitaz",
   "LOCATION": "No. 13, Ikpokpan Str. Off GRA. B/C"
 },
 {
   "NAME": "Mat Ice Fast Food",
   "LOCATION": "No. 52, Ihama Rd, GRA. B/C"
 },
 {
   "NAME": "Wanatan Garden",
   "LOCATION": "No. 51, Ihama Rd, GRA. B/C"
 },
 {
   "NAME": "Diaca Meal",
   "LOCATION": "No. 74, Ihama Rd, GRA. B/C"
 },
 {
   "NAME": "Saga Hotel",
   "LOCATION": "No. 16, Edo-Osagie Str. GRA, B/C"
 },
 {
   "NAME": "Kiko Hotel",
   "LOCATION": "No. 2, Delta Cresent, Off Ikpokpan GRA, B/C"
 },
 {
   "NAME": "Isno Hotel",
   "LOCATION": "No. 17, Ikpokpan Rd, GRA, B/C"
 },
 {
   "NAME": "Elegance Hotel",
   "LOCATION": "No. 58, Boundry Rd, GRA, B/C"
 },
 {
   "NAME": "Waynitaz",
   "LOCATION": "No. 13, Ikpokpan Str. Off GRA, B/C"
 },
 {
   "NAME": "Ronze Jet Crest Hotel",
   "LOCATION": "No. 78B, Ihama GRA, B/C"
 },
 {
   "NAME": "Vichi Gates",
   "LOCATION": "No. 68,Ihama Rd, GRA, B/C"
 },
 {
   "NAME": "Tunnel Bar",
   "LOCATION": "No. 49, Ihama Rd, GRA, B/C"
 },
 {
   "NAME": "Naomi's Garden",
   "LOCATION": "No. 7, Upper Adesuwa Rd, GRA, B/C"
 },
 {
   "NAME": "St Saviour Car Wash Restaurant & Bar",
   "LOCATION": "No. 107, St. Saviour Rd, B/C"
 },
 {
   "NAME": "Ejeke Bakery",
   "LOCATION": "No. 70, Owina Str. Off Sakponba Rd, B/C"
 },
 {
   "NAME": "Notre Dame Pure Water",
   "LOCATION": "No. 75B, Benin-Agbor Rd, B/C"
 },
 {
   "NAME": "Ejike Bakery",
   "LOCATION": "No. 70, Owina Str. Off Sakponba Rd, B/C"
 },
 {
   "NAME": "Imperial Hotel",
   "LOCATION": "No. 38, Edokpolor Factory Rd, B/C"
 },
 {
   "NAME": "Maria Pure Water",
   "LOCATION": "No. 71, Benin-Agbor Rd, Ikpoba Hill,B/C"
 },
 {
   "NAME": "J & H Food Outlet",
   "LOCATION": "No. 10, Oregbeni Str. B/C"
 },
 {
   "NAME": "Queen Sport Food Outlet",
   "LOCATION": "Benin-Agbor Rd, B/C"
 },
 {
   "NAME": "Idi Motel",
   "LOCATION": "Izemwingie Str. Off Benin-Agbor Rd, B/C"
 },
 {
   "NAME": "Mania Hope Food Outlet",
   "LOCATION": "Oregbeni Estate, Benin-Agbor Rd, B/C"
 },
 {
   "NAME": "Rins Exclusive Restaurant",
   "LOCATION": "Ogbesun Qtrs, off Benin-Agbor Rd, B/C"
 },
 {
   "NAME": "Reo Guest House",
   "LOCATION": "No. 166, ikhunoro, Off Benin-Agbor Rd, B/C"
 },
 {
   "NAME": "oghosa Pure Water",
   "LOCATION": "No. 1, oghosa Close, Off Benin-Agbor Rd, B/C"
 },
 {
   "NAME": "O & G Table Water",
   "LOCATION": "Iguomo, Benin-Agbor Rd, B/C"
 },
 {
   "NAME": "Morning Glory Bakery",
   "LOCATION": ""
 },
 {
   "NAME": "Sizzler Fast Food",
   "LOCATION": "Benin-Agbor Rd, B/C"
 },
 {
   "NAME": "Estate Hotel",
   "LOCATION": "No. 1, Oregbeni Estate, Benin-Agbor Rd, B/C"
 },
 {
   "NAME": "Dum Bird Food Outlet",
   "LOCATION": "Oregbeni Estate, Benin-Agbor Rd, B/C"
 },
 {
   "NAME": "Metro Holiday In",
   "LOCATION": "Behind Guinness PLC. Ikpoba Hill, Benin-Agbor Rd, B/C"
 },
 {
   "NAME": "Egede Food Centre",
   "LOCATION": ""
 },
 {
   "NAME": "Mama Devine resturant",
   "LOCATION": "Oregbeni Estate hotel road, Benin City."
 },
 {
   "NAME": "Popis Corner",
   "LOCATION": "No. 71, Mission road B/c."
 },
 {
   "NAME": "Star Corner",
   "LOCATION": "Ifon road off Idahosa str. B/c."
 },
 {
   "NAME": "Water for real",
   "LOCATION": "No. 10, Upper Mission road by New Benin Market B/c."
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "No. 12, Edokpolor, off Benin-Agbor road, B/c"
 },
 {
   "NAME": "Furmigation service.",
   "LOCATION": "No. 125, Ikpoba hill, B/c"
 },
 {
   "NAME": "GT Buttered Bread",
   "LOCATION": "No. 9, Ofungbe str. Off Sapele rd. B/c."
 },
 {
   "NAME": "Face 2 Enterprise",
   "LOCATION": "No. 122, Benin-Agbor road, Ikpoba hill."
 },
 {
   "NAME": "Mama Otibhor Resturant",
   "LOCATION": "No. 124, Benin-Agbor road, B/c"
 },
 {
   "NAME": "RESTAURANT AND BAR",
   "LOCATION": "10, Edokpolor House"
 },
 {
   "NAME": "Palm wine Joint/Joint",
   "LOCATION": "Plytmouth road, B/c."
 },
 {
   "NAME": "Omega Resturant and Bar",
   "LOCATION": "No. 125, Uselu-Lagos Rd. B/c."
 },
 {
   "NAME": "Fried Chemicals.",
   "LOCATION": " No. 46, Lagos Road str. B/c"
 },
 {
   "NAME": "Austine O shop",
   "LOCATION": "No. 16, Ibiewe str. B/c"
 },
 {
   "NAME": "Kelly Building chemical shop",
   "LOCATION": "No. 13, 2nd Ibiwe str. B/c"
 },
 {
   "NAME": "Mama Nosa Meat shop",
   "LOCATION": "No. 16, Yoruba str. off New Lagos, B/c"
 },
 {
   "NAME": "Amala Spot",
   "LOCATION": "No. 137, New- Lagos Road, B/c"
 },
 {
   "NAME": "Ola Hesomi resturant ",
   "LOCATION": "No. 137, New- Lagos Road, B/c"
 },
 {
   "NAME": "Paliament Bar",
   "LOCATION": "No. 83, Wire Road, B/c"
 },
 {
   "NAME": "Mela Motel",
   "LOCATION": "Mela motel Road, B/c"
 },
 {
   "NAME": "No Country man fast food",
   "LOCATION": "Textile mill road, B/c"
 },
 {
   "NAME": "Mikes Bakery",
   "LOCATION": "Evbareke, B/c."
 },
 {
   "NAME": "Diamond Hieght Hotel",
   "LOCATION": "No. 10, Irubi st. B/c"
 },
 {
   "NAME": "Efex Hotel",
   "LOCATION": "No. 102, Uselu-Lagos road, B/C"
 },
 {
   "NAME": "Talk of Tale City guest House ",
   "LOCATION": "No. 38, Dawson  Road, B/c"
 },
 {
   "NAME": "Hotel Delto",
   "LOCATION": "No.3, Imato Cresent, off Wire road, B/C"
 },
 {
   "NAME": "Etinosa Resturant & Bar ",
   "LOCATION": "Off Oselo-Lagos road, B/c"
 },
 {
   "NAME": "Mr Biggs Fast Food",
   "LOCATION": "No. 102, Uselu-Ugbowo Lagos road, B/c"
 },
 {
   "NAME": "Brother Bar",
   "LOCATION": "No. 30B, Wire road, B/c"
 },
 {
   "NAME": "GT Fast Food",
   "LOCATION": "No. 84, Uselu-Lagos Road, B/c"
 },
 {
   "NAME": "Mat Ice Fast Food",
   "LOCATION": "No. 167B, Uselu- Lagos Road, B/c"
 },
 {
   "NAME": "Kaydes Fast Food",
   "LOCATION": "Uselu-Lagos Road, B/c"
 },
 {
   "NAME": "Haven Hotel",
   "LOCATION": "No. 3, Igbinovia Drive off Uwagboe Rd. B/c"
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "No. 58, Wire Road. B/c"
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "No. 1, Ofunmwegbe St. B/c"
 },
 {
   "NAME": "Country Side Hotel",
   "LOCATION": "No. 10, Aimamiegbon,Ainiueiwa st. off Uselu Rd. B/c"
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "No. 88, Uselu-Lagos Rd. B/c"
 },
 {
   "NAME": "Mayro Water Fatory ",
   "LOCATION": "Etete Rd, GRA, B/c"
 },
 {
   "NAME": "Beer Palour Bar",
   "LOCATION": "Akenzua St. B/c"
 },
 {
   "NAME": "Benny Furmigation Service",
   "LOCATION": "No. 125, Ikpoba hill, B/c"
 },
 {
   "NAME": "Cremes Suites/Hotel",
   "LOCATION": "No. 2, Blessed Avenue off Boundary Rd,B/c"
 },
 {
   "NAME": "Boston Hotel",
   "LOCATION": "No. 1, Oguigo Avenue, GRA. B/c"
 },
 {
   "NAME": "God's Grace Backery",
   "LOCATION": "No. 34, Etinosa st. off Upper Lawani St. B/c"
 },
 {
   "NAME": "Fortune Bakery",
   "LOCATION": "No. 38, Eweka st. New Benin, B/c"
 },
 {
   "NAME": "Eze Marue Lous Bakery",
   "LOCATION": "No. 39, Dandy st. off Okhoro st. b/c"
 },
 {
   "NAME": "Tessy Bakery",
   "LOCATION": "No. 3, Aghehoguwa st. off Eagle Furniture, B/c"
 },
 {
   "NAME": "Aunty Cecilia Buttered Bread ",
   "LOCATION": "No. 5, Aken Osifo st. off Edaiken School Rd. B/c"
 },
 {
   "NAME": "PA Bello ",
   "LOCATION": "No. 2,  first Ibiwe st. B/c"
 },
 {
   "NAME": "Iyayi Fast Food",
   "LOCATION": "Iguosa Village, Benin- Lagos Rd, B/c"
 },
 {
   "NAME": "Precious Palm Royal Hotel",
   "LOCATION": "Benin Lagos Rd, B/c"
 },
 {
   "NAME": "Country Side Hotel",
   "LOCATION": "No 10, Ainiueiwa st. off Uselu Rd. B/c"
 },
 {
   "NAME": "Legend Bar",
   "LOCATION": "No. 234, New Lagos Road, Benin City"
 },
 {
   "NAME": "Ozino's Bakery",
   "LOCATION": "No. 10, Ighedosa off Obaminoyi st. off upper sakpomba st. B/c"
 },
 {
   "NAME": "God Det Bakery",
   "LOCATION": "Aladhan str. off Dumez Rd. B/c"
 },
 {
   "NAME": "Blue Star Fast Food",
   "LOCATION": "No. 206, Upper Siloko Road ,B/c"
 },
 {
   "NAME": "Madam Chicken Fast Food Outlet",
   "LOCATION": "Uwelu spare part market, B/c"
 },
 {
   "NAME": "Piccadilly Bar",
   "LOCATION": "No 110, Sakpomba Road. B/c"
 },
 {
   "NAME": "Andy Frozen meat shop",
   "LOCATION": "No.100 Sakpomba Rd. B/c"
 },
 {
   "NAME": "Odaro Buttered Bread",
   "LOCATION": "No. 6, Ekwouare str. off MM way, B/c"
 },
 {
   "NAME": "Cold Room",
   "LOCATION": "No.1 Upper Lawani, New Benin, B/c"
 },
 {
   "NAME": "Abisco ",
   "LOCATION": "No.8 Benevolent st. off Obasuyi st Uwelu, B/c"
 },
 {
   "NAME": "Peace Settings Guest House",
   "LOCATION": "No.31 Ozanere st. B/c"
 },
 {
   "NAME": "star Corner",
   "LOCATION": "No. 31 Edo lane, MM way, B/c"
 },
 {
   "NAME": "Wisdom Bakery",
   "LOCATION": "No. 2, Okungriwa-Priri"
 },
 {
   "NAME": "BJ Bread ",
   "LOCATION": "No. 11, Eweka Str. off upper Siloko Rd. B/c"
 },
 {
   "NAME": "Samphim Hotels",
   "LOCATION": "No. 5, Km5, Benin - Auchi Road Road, B/c"
 },
 {
   "NAME": "Grace Erabor",
   "LOCATION": "No. 100, Edo lane, off MM way, Benin City"
 },
 {
   "NAME": "Blue Star Fast Food",
   "LOCATION": "No. 205, upper siloko Rd. B/c"
 },
 {
   "NAME": "Motuko Bakery",
   "LOCATION": "Benin Lagos Rd, Beside ITV, B/c"
 },
 {
   "NAME": "Home Sweet Home Resturant",
   "LOCATION": "No. 42, The limit Rd off sapele rd. B/c"
 },
 {
   "NAME": "Obern Concepts Furmigation Outfits",
   "LOCATION": "No 42, Godwin Abebel way (D limt) Road off Sapele Rd. B/c "
 },
 {
   "NAME": "Ritchy Bread Bakery",
   "LOCATION": "Plot 19, Federal Housing Estate, B/c"
 },
 {
   "NAME": "Wellington Royal Hotel",
   "LOCATION": "Uguobadia Avenue, off Etete Rd, GRA. B/c"
 },
 {
   "NAME": "Jerry Bakery",
   "LOCATION": "No. 2, Aibuedefe st. off 1st Uogbor st B/c"
 },
 {
   "NAME": "Afes Table Water",
   "LOCATION": "No. 12B, Osagie off Dumez Rd. B/c"
 },
 {
   "NAME": "Ivory Kitchen",
   "LOCATION": "No. 2, Faith drive off Faith Rd. B/c"
 },
 {
   "NAME": "Sweet -\"B\" IN",
   "LOCATION": "No. 3, Odekhinan Avenue off 2nd Ugbor Rd. GRA. B/c"
 },
 {
   "NAME": "Bros Bakery",
   "LOCATION": "No. 10, Onaghisee st. off upper Sakpomber Rd. B/c"
 },
 {
   "NAME": "The Andaluz Car wash/Bar",
   "LOCATION": "No. 4, Trinity way, off ugbor rd. B/c"
 },
 {
   "NAME": "Shoneys Bendevou Fast food",
   "LOCATION": "No. 11 upper Adesuwa, GRA. B/c"
 },
 {
   "NAME": "Oriakeh Bar",
   "LOCATION": "No. 28, Oko Central, GRA. B/c"
 },
 {
   "NAME": "Uncle Franic Bakery",
   "LOCATION": "No. 10, Ohen Street Ekae Km 8 Saplele Rd"
 },
 {
   "NAME": "Red velt vet Hotel",
   "LOCATION": "Faith Drive off way GRA, B/c"
 },
 {
   "NAME": "Due Palace Bar",
   "LOCATION": "No. 32, Oko Rd along airport road,B/c"
 },
 {
   "NAME": "Sharpex Guest house",
   "LOCATION": "No. 13, Obashan st. off oko central rd, GRA. B/c"
 },
 {
   "NAME": "Perino Hotel ",
   "LOCATION": "No. 5, Boundary rd. GRA, B/c"
 },
 {
   "NAME": "Double Blessing Table water",
   "LOCATION": "No. 108, Sapele Road, B/c"
 },
 {
   "NAME": "Mat Ice Fast Food",
   "LOCATION": "No. 52, Ihiama st. GRA. B/c"
 },
 {
   "NAME": "Option-One Hotel",
   "LOCATION": "No. 62, Ihiama st. GRA. B/c"
 },
 {
   "NAME": "Ken Concept Bar",
   "LOCATION": "Ihama str. GRA, B/c"
 },
 {
   "NAME": "Wantan Garden",
   "LOCATION": ""
 },
 {
   "NAME": "Vichi Gates Hotel",
   "LOCATION": "No. 68, Ihama Road, GRA. B/c"
 },
 {
   "NAME": "Fedgad Bar & Restaurant",
   "LOCATION": "No. 17, JBS Estate off Boundary road, B/c"
 },
 {
   "NAME": "Ronze-Jet Crest Hotel",
   "LOCATION": "No. 78b Ihama rd, GRA. B/c"
 },
 {
   "NAME": "Mayo Table Water",
   "LOCATION": "No. 6 Etete Road off Adesuwa Rd. GRA, B/c"
 },
 {
   "NAME": "Baden Baden Executive suite & Halls",
   "LOCATION": "Sapele Road, Benin city"
 },
 {
   "NAME": "The Limit Motels LTD",
   "LOCATION": "Godwin Abey way, off Sapele rd. B/c"
 },
 {
   "NAME": "De- City Table water ",
   "LOCATION": "Plot 1, Evbuoriaria, off sapele rd. B/c"
 },
 {
   "NAME": "Absel Ttable water",
   "LOCATION": "km 8, Benin Sapele road, B/c"
 },
 {
   "NAME": "Good days Guest House ",
   "LOCATION": "No. 7, Abusomwan st. off Idahosa, B/c"
 },
 {
   "NAME": "Network Recreation ",
   "LOCATION": "No. 2, Akenzua st. B/c"
 },
 {
   "NAME": "Sakpomba Parliament",
   "LOCATION": "No. 21 sakpomba rd.  B/c"
 },
 {
   "NAME": "Chosen Bakery",
   "LOCATION": "No. 8, Ogbelaka lane, B/c"
 },
 {
   "NAME": "The Dinner Restaurant and Bar",
   "LOCATION": "No. 18, Sokpomba rd. B/c"
 },
 {
   "NAME": "Nosaru Bakery",
   "LOCATION": "No. 1,  Yoruba st. B/c"
 },
 {
   "NAME": "Restaurant and Bar",
   "LOCATION": "1st East circular rd. B/c"
 },
 {
   "NAME": "Isoken Food Oulet",
   "LOCATION": "1, 2nd East Circular Road"
 },
 {
   "NAME": "Uwa Table Water",
   "LOCATION": "45, Amadasun Street off Etete Road G.R.A Benin City"
 },
 {
   "NAME": "Mike Bakery",
   "LOCATION": "18, Alimere Street off Textile Mill Road"
 },
 {
   "NAME": "Our Choice Table Water",
   "LOCATION": "20, Uyi-Ekpen Street off Akpakpava Benin City"
 },
 {
   "NAME": "Popular Bakery",
   "LOCATION": "1B, Wisdom Street Benin City"
 },
 {
   "NAME": "Iyayi Table Water",
   "LOCATION": ""
 },
 {
   "NAME": "Honey Rainbow Bakery",
   "LOCATION": ""
 },
 {
   "NAME": "Money Glory ",
   "LOCATION": "112, 1st Upstairs Road Benin City"
 },
 {
   "NAME": "Insight Bakery ",
   "LOCATION": "102b, Siluko Road,Benin City"
 },
 {
   "NAME": "The Owner Star Bakery ",
   "LOCATION": "Omoregbe Street, off Siluko Road, Benin City "
 },
 {
   "NAME": "Melo Bakery ",
   "LOCATION": "Omigie Street, off Oromiyan, Benin City"
 },
 {
   "NAME": "Eddy Baga Internationa LTD Foundation Outfit",
   "LOCATION": "41, Sokponba Road, Benin City"
 },
 {
   "NAME": "Ohallic NIG.LTD",
   "LOCATION": " 2, Ogbelaka Street, off Sapele, Road Benin City"
 },
 {
   "NAME": "Wagosa Table Water",
   "LOCATION": "54, Upper Ekenwa Road Benin, City"
 },
 {
   "NAME": "Estate Hotel ",
   "LOCATION": "Ikpoba Hill, Benin City"
 },
 {
   "NAME": "Imeral Regency Hotel",
   "LOCATION": "35, Jemila Road, Ikpoba Hill, Benin City"
 },
 {
   "NAME": "Jemila Hotel",
   "LOCATION": "8, Edokpolor Factory Road, Benin City"
 },
 {
   "NAME": "Jigger Guest House",
   "LOCATION": "Aroko Estate, Ikpoba Hill, Benin City"
 },
 {
   "NAME": "Benco Chemical ",
   "LOCATION": "63, Ehaekpen Street, Benin City"
 },
 {
   "NAME": "Marvelous Hotel ",
   "LOCATION": "1, Aroko Street, Ikpoba Hill, Benin City"
 },
 {
   "NAME": "Spanish Bakery ",
   "LOCATION": "19, Akugbe Street, Ikpoba Hill, Benin City"
 },
 {
   "NAME": "Central Hotel ",
   "LOCATION": "76, Akpakpava Road, Benin City"
 },
 {
   "NAME": "Peak Hotel ",
   "LOCATION": "222, Old Benin-Agbor Road, Ikpoba Hill, Benin City"
 },
 {
   "NAME": "Honey Rainbow Bakery",
   "LOCATION": "Old Benin-Agbor Road, Behind Motor Park, Benin City"
 },
 {
   "NAME": "Rins Execlusive Hotel",
   "LOCATION": "13, Igbinosa Street, Ikpoba Hill, Benin City"
 },
 {
   "NAME": "REO Guest House",
   "LOCATION": "166, Old Agbor Road, Ikpoba Hill, Benin City"
 },
 {
   "NAME": "Hotel Doris Dey",
   "LOCATION": "29, Benin-Agbor Road, Benin City"
 },
 {
   "NAME": "Standard Guest House",
   "LOCATION": "Ikpoba Hill, Benin City"
 },
 {
   "NAME": "Ify Guest House",
   "LOCATION": "2, Idalo Street, Ikpoba Hill, Benin City"
 },
 {
   "NAME": "Sonia  Guest House ",
   "LOCATION": "2, Idalo Street, Ikpoba Hill, Benin City"
 },
 {
   "NAME": "Daddy J Hotel",
   "LOCATION": "J.Hotel Street, Ikpoba Hill, Benin City"
 },
 {
   "NAME": "Elegance Hotel LTD",
   "LOCATION": ""
 },
 {
   "NAME": "Ugo Bakery ",
   "LOCATION": "17, Osaro Street, Ikpoba Hill, Benin City"
 },
 {
   "NAME": "Eche Bar",
   "LOCATION": "102, Benin-Agbor Road, Benin City"
 },
 {
   "NAME": "Maria Pure Water ",
   "LOCATION": "Benin-Agbor Road, Benin City"
 },
 {
   "NAME": "Hotel Reliance ",
   "LOCATION": "13, Benin-Auchi Road, Benin City"
 },
 {
   "NAME": "Ritchy Bakery ",
   "LOCATION": "Federal Housing Estate, Benin City"
 },
 {
   "NAME": "Osaro Bakery",
   "LOCATION": "Federal Housing Estate, Benin City"
 },
 {
   "NAME": "Notre Dame Pure Water",
   "LOCATION": "75b, Benin-Agbor Road, Benin City"
 },
 {
   "NAME": "Safari Guest House",
   "LOCATION": "75, Benin-Auchi Road, Benin City"
 },
 {
   "NAME": "Big Joe Pure Water",
   "LOCATION": "49, Benin-Auchi Road, Benin City"
 },
 {
   "NAME": "Basis Royal Grand Hotel",
   "LOCATION": "144, Benin-Auchi Road, Eyaen, Benin City"
 },
 {
   "NAME": "Rialto Hotel ",
   "LOCATION": "1, Rialto Close, Eyaen, Benin-Auchi Road, Benin City"
 },
 {
   "NAME": "Zafike Royal Hotel",
   "LOCATION": "Km 8, Benin-Auchi Road ,Benin City"
 },
 {
   "NAME": "Samphino Hotel ",
   "LOCATION": "Eyaen, Benin-Auchi Road, Benin City"
 },
 {
   "NAME": "2+2 Guest House ",
   "LOCATION": ""
 },
 {
   "NAME": "Lixbor Hotel",
   "LOCATION": "Sakponba Road, Benin City"
 },
 {
   "NAME": "Debbies Kitchen",
   "LOCATION": "61, Sokponba Road, Benin City"
 },
 {
   "NAME": "Sizzler Fast Food",
   "LOCATION": "3, Sokponba Road, Benin City"
 },
 {
   "NAME": "Mat-Ice",
   "LOCATION": "12, Sokponba Road, Benin City"
 },
 {
   "NAME": "Network Relaxation ",
   "LOCATION": "2, Aruosa Stree,t Benin City"
 },
 {
   "NAME": "Maustine Place ",
   "LOCATION": "6, Upper Mission Extension, Benin City"
 },
 {
   "NAME": "Aibije Hotel ",
   "LOCATION": "30, Upper Mission Extension, Benin City"
 },
 {
   "NAME": "Paulingo Plaza ",
   "LOCATION": "8, Guest House, Upper Mission Extension, Benin City"
 },
 {
   "NAME": "Babalarun Bar ",
   "LOCATION": "59, Sokponba Road, Benin City"
 },
 {
   "NAME": "Kydee Centre ",
   "LOCATION": "59, Airport Road, Benin City"
 },
 {
   "NAME": "Supreme Guest House ",
   "LOCATION": "59, Airport Road, Benin City"
 },
 {
   "NAME": "Samsy Hotel",
   "LOCATION": "5, Ben Oni Stree,t GRA, Benin City"
 },
 {
   "NAME": "Tetrazzin Chicken Restaurant",
   "LOCATION": "70, Airport Road, Benin City"
 },
 {
   "NAME": "De Marriot Hotel ",
   "LOCATION": "4, Jemide Avenue, off Giwa Amu Street, GRA, Benin City"
 },
 {
   "NAME": "Prestige Hotel ",
   "LOCATION": "1, Oni Street, GRA, Benin City"
 },
 {
   "NAME": "Mr Food Fast Food ",
   "LOCATION": "1, Ihama, off Airport Road, Benin City"
 },
 {
   "NAME": "Rossy Bakery ",
   "LOCATION": "198, M.M Way, Benin City"
 },
 {
   "NAME": "Envoy Hotel ",
   "LOCATION": "4, Osagie Avenu,e off Giwa Amu, GRA, Benin City"
 },
 {
   "NAME": "Omoritana Hotel ",
   "LOCATION": "13, Oni Street, GRA, Benin City "
 },
 {
   "NAME": "Constantials Hotel",
   "LOCATION": "24/26, Airport Road, Benin City"
 },
 {
   "NAME": "Mana Table Water",
   "LOCATION": ""
 },
 {
   "NAME": "Tarex Place ",
   "LOCATION": "6, Edobor Osula Street, off Oni Street, GRA, Benin City"
 },
 {
   "NAME": "Envoy Hotel ",
   "LOCATION": "4, Osagie Avenue, off Giwa Amu, GRA, Benin City"
 },
 {
   "NAME": "Talk of the City Hotel",
   "LOCATION": ""
 },
 {
   "NAME": "Hotel Felona ",
   "LOCATION": "Dawson Road, Benin City"
 },
 {
   "NAME": "Blessed Edo Bakery ",
   "LOCATION": ""
 },
 {
   "NAME": "Akpakpava Bakery",
   "LOCATION": "Old Western Road, Benin City"
 },
 {
   "NAME": "Benin Motel Plaza",
   "LOCATION": "GRA, Benin City"
 },
 {
   "NAME": "Zee Louge",
   "LOCATION": "97, Boundary Road, GRA, Benin City"
 },
 {
   "NAME": "Katori's Bamboo House",
   "LOCATION": "34, Boundary Road, GRA, Benin City"
 },
 {
   "NAME": "Courtyard Hotel",
   "LOCATION": "15, Boundary Road, GRA, Benin City"
 },
 {
   "NAME": "Creme Suites&Hotel ",
   "LOCATION": "26, Blessed People Avenue, GRA, Benin City"
 },
 {
   "NAME": "Fed Guard Hotel ",
   "LOCATION": "7, JBS Estate, GRA, Benin City"
 },
 {
   "NAME": "Bibi Motel ",
   "LOCATION": "72, Boundary Road, GRA Benin City"
 },
 {
   "NAME": "Rity Garton Hotel",
   "LOCATION": "64, Boundary Road, GRA, Benin City"
 },
 {
   "NAME": "Diamond Travel Hotel",
   "LOCATION": "11B, Urubi Street, Benin City"
 },
 {
   "NAME": "Wakki Guardinu",
   "LOCATION": "19, Adesuwa Road, GRA, Benin City"
 },
 {
   "NAME": "Kreeds Hotel ",
   "LOCATION": "41A, Adesuwa Road, GRA, Benin City"
 },
 {
   "NAME": "Rea Africana Restaurant",
   "LOCATION": "1, Azige Crescent, GRA, Benin City"
 },
 {
   "NAME": "Car Wash & Bar",
   "LOCATION": "21, Adesuwa Road, GRA, Benin City"
 },
 {
   "NAME": "Fej Restaurant ",
   "LOCATION": "12, Boundary Road, Benin City"
 },
 {
   "NAME": "Benin Continental Hotel",
   "LOCATION": "11b, Ikpokpan Avenue, GRA, Benin City"
 },
 {
   "NAME": "Waynitaz Food ",
   "LOCATION": "13, Ikpokpan Road, GRA, Benin City"
 },
 {
   "NAME": "Kiko Hotel ",
   "LOCATION": "2, Delta Crescent, GRA, Benin City"
 },
 {
   "NAME": "Isno Hotel ",
   "LOCATION": "17, Ikpokpan Road, GRA, Benin City"
 },
 {
   "NAME": "40/40 Sport & Bar ",
   "LOCATION": "Adesuwa Road, GRA Benin City"
 },
 {
   "NAME": "Farmer's Sakponba ",
   "LOCATION": "4, Complex"
 },
 {
   "NAME": "Time and Season Bakery ",
   "LOCATION": "38, M.M.Way, Benin City"
 },
 {
   "NAME": "Niki Manifact-Uring Comp.LTD ",
   "LOCATION": "Ogba Road, Benin City"
 },
 {
   "NAME": "Okaro Table Water ",
   "LOCATION": "44, Iyekekpolor Housing Estate, Benin City"
 },
 {
   "NAME": "The  Coon Yoghurt",
   "LOCATION": "10, Airuedomwinya Avenue, Iyekogba Housing Estate, B/City"
 },
 {
   "NAME": "Omo -Adoni Odighiri Fumigation Outfit ",
   "LOCATION": "7A, Ikpoba Slope, Benin City"
 },
 {
   "NAME": "mrs Iyamu Cold Romm",
   "LOCATION": "92, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "MRS Owens Cold Room",
   "LOCATION": " 73, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Mrs C &G Cold Room",
   "LOCATION": "81, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "O &R Cold Room",
   "LOCATION": "83, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Mrs M Imasun Cold Room",
   "LOCATION": "7b, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Westey Hotels",
   "LOCATION": "2 Aguele Drive, Off Akhiobare, GRA, Benin City"
 },
 {
   "NAME": "Government Reservation",
   "LOCATION": "48, Akhiobare Street, GRA, Benin City"
 },
 {
   "NAME": "Cold Room",
   "LOCATION": "2nd East Circular Junction, Benin City"
 },
 {
   "NAME": "Mrs Grace Agbogi Meat ",
   "LOCATION": "4, Ogiamiem Street, Benin City "
 },
 {
   "NAME": "Mrs Enabulele Cold Room ",
   "LOCATION": "Yoruba Street, Benin City"
 },
 {
   "NAME": "BI  LO International Meat Shop",
   "LOCATION": "Yoruba Street, Benin City"
 },
 {
   "NAME": "Mrs bello Osagie Cold Room",
   "LOCATION": "Off Upper Lawani Street, Benin City"
 },
 {
   "NAME": "mama Junior Cold  Room",
   "LOCATION": "Upper Lawani Street, Benin City"
 },
 {
   "NAME": "B7 meat Shop",
   "LOCATION": "Yoruba Street, Benin City"
 },
 {
   "NAME": "Cold Room",
   "LOCATION": "Upper Lawani Junction, New Benin ,Benin City"
 },
 {
   "NAME": "Sizzler Fast Food",
   "LOCATION": "Sakponba Road, Benin City"
 },
 {
   "NAME": "Mrs Igbinewera Meat Shop",
   "LOCATION": "93, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Mrs Adesuwa Meat Shop",
   "LOCATION": "91, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Foreign Lady Meat Shop",
   "LOCATION": "91, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "One Love Meat Shop",
   "LOCATION": "91, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Mrs Giegbefu Mwen Cold Room",
   "LOCATION": "1b, Ogiamien Lane, Off 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Car Wash & Bar",
   "LOCATION": ""
 },
 {
   "NAME": "Mrs B meat Shop ",
   "LOCATION": "93, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Winsa Frozen Meat Shop",
   "LOCATION": "2nd East Circular Junction, by Sokponba, Benin City"
 },
 {
   "NAME": "Mr Egharevba Cold Room ",
   "LOCATION": "19, Orobaton Street, Benin City"
 },
 {
   "NAME": "Mr Fred C \\Y Cold Room",
   "LOCATION": "Evbarunegbefu  Street,  Benin City"
 },
 {
   "NAME": "Cold Room ",
   "LOCATION": "EVbarunegbefu  Street, Off Lucky Way, Benin City"
 },
 {
   "NAME": "Mr Enabulele Cold Room",
   "LOCATION": "12B,  Obasogie Street, Off 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Mrs Okuns Cold Room",
   "LOCATION": "23, Evba, Ubefo Str. Benin City"
 },
 {
   "NAME": "Mr Uyiekpen Cold Room",
   "LOCATION": "9, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Osawe Cold Room",
   "LOCATION": "79, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Mr Joseph Unufe Febhns",
   "LOCATION": "105, Sokponba Road, Benin City"
 },
 {
   "NAME": "Mania Enoghayin Cold Room",
   "LOCATION": "105, Sokponba Road, Benin City"
 },
 {
   "NAME": "Rito Cold Room",
   "LOCATION": "105, Sokponba Road, Benin City"
 },
 {
   "NAME": "Mania Bose Cold Room",
   "LOCATION": "90, 2nd East Circular Road, Benin City"
 },
 {
   "NAME": "Mrs A Osayan De Cold Room",
   "LOCATION": "18,  Evbarunegbefu  Street,  Benin City"
 },
 {
   "NAME": "Rendekhi Royal Hotel",
   "LOCATION": "6, Ihenuri, off Ihania str. GRA, Benin City"
 },
 {
   "NAME": "Pepper Rice Resturant",
   "LOCATION": "8, Adeyan Crescent, Benin City, "
 },
 {
   "NAME": "Consulate Bar",
   "LOCATION": "19, Ikpokpon Road, GRA, B/City"
 },
 {
   "NAME": "Chioce Gate Hotel",
   "LOCATION": "11, Neka Street, GRA, B/City"
 },
 {
   "NAME": "Hotel Excutive",
   "LOCATION": "40, Sabuohen Close, Off Ihania Street, B/City."
 },
 {
   "NAME": "Uyi Grand Hotel ",
   "LOCATION": "Aidevaon Street Off Ihania Street. B/City"
 },
 {
   "NAME": "Alice Hotel ",
   "LOCATION": "24, Imureze, Off Upper Adesuwa Rd. Benin City"
 },
 {
   "NAME": "Wantan Garden",
   "LOCATION": "51, Ihama Road, GRA, B/City"
 },
 {
   "NAME": "Kems Concept",
   "LOCATION": "37, Ihama Road, GRA, B/City"
 },
 {
   "NAME": "Useni Hotel And Suites68",
   "LOCATION": "68, Ihama Rd, GRA, B/City"
 },
 {
   "NAME": "P.F Quality Hotel",
   "LOCATION": "6, Ale Street, Off 180 Upper Sokponba Rd, B/City"
 },
 {
   "NAME": "Citizen Hotel",
   "LOCATION": "42, Uwa Str. Benin City"
 },
 {
   "NAME": "Aso Time Bar",
   "LOCATION": ""
 },
 {
   "NAME": "Otonie Guest House",
   "LOCATION": "4, Otonia Street,B/City"
 },
 {
   "NAME": "Chemijar Hotel ",
   "LOCATION": ""
 },
 {
   "NAME": "Mrs Otamere Meat Shop",
   "LOCATION": "27, MM Way, Benin City"
 },
 {
   "NAME": "The Royal Marble Hotel",
   "LOCATION": "22, Ihama GRA B/City"
 },
 {
   "NAME": "Florence Imolorhe Meat Shop",
   "LOCATION": ""
 },
 {
   "NAME": "Patno Resturant And Bar",
   "LOCATION": "5, Ogbelakar Str. B/City."
 },
 {
   "NAME": "Good Shephard Guest House",
   "LOCATION": "14, Amure Str. Opposite Ebeneza Primary School, Benin City"
 },
 {
   "NAME": "Chioce Gate Hotel",
   "LOCATION": "11, Neka Street GRA, B/City"
 },
 {
   "NAME": "Evelyn Meat Shop",
   "LOCATION": "18, Oba Market Road, Benin City"
 },
 {
   "NAME": "Aimosa Meat Shop",
   "LOCATION": "02, Oba Market Road, B/City"
 },
 {
   "NAME": "Mrs Amen Ojo Meat Shop",
   "LOCATION": "24, Oba Market Road, B/City"
 },
 {
   "NAME": "Madam Carry Go Meat Shop",
   "LOCATION": "24, Oba Market Road, B/City"
 },
 {
   "NAME": "Mrs Topa Meat Shop",
   "LOCATION": "24, Oba Market Road, B/City"
 },
 {
   "NAME": "No Name Meat Shop",
   "LOCATION": "18, Oba Market Road, Benin City"
 },
 {
   "NAME": "Mrs Agboola Meat Shop",
   "LOCATION": "22, Oba Market Road, B/City"
 },
 {
   "NAME": "Mama Emeka Restaurant ",
   "LOCATION": "Vegetable Market, B/City"
 },
 {
   "NAME": "Sunny Meat Shop",
   "LOCATION": "24, Oba Market Road, B/City"
 },
 {
   "NAME": "Ivory Kitchen",
   "LOCATION": "27, Airport Road, B/City"
 },
 {
   "NAME": "Senaga Guest House",
   "LOCATION": "31, Airport Road, B/City"
 },
 {
   "NAME": "Meat Shop",
   "LOCATION": "22, Oba Market Road, B/City"
 },
 {
   "NAME": "Emeka Meat Shop",
   "LOCATION": "22, Oba Market Road, B/City"
 },
 {
   "NAME": "Vicland Venture Kitchen",
   "LOCATION": "Coca-Cola, Benin City"
 },
 {
   "NAME": "Ozinon Restaurant ",
   "LOCATION": "1, Igbinedion Street, B/City"
 },
 {
   "NAME": "Olivia Table Water",
   "LOCATION": "51, Arenzen Str. B/City"
 },
 {
   "NAME": "Debbis Fast Food",
   "LOCATION": "61, Sakponba Road, B/City"
 },
 {
   "NAME": "Derino Holtel",
   "LOCATION": "I5, Boundary Rd, GRA, B/City"
 },
 {
   "NAME": "Wauossa Table Water",
   "LOCATION": "I54, Upper Ekemwan Road, B/City"
 },
 {
   "NAME": "Unibake Bakery Table Water",
   "LOCATION": "9, 2nd Victory Lane, B/City"
 },
 {
   "NAME": "Pat Meat Shop",
   "LOCATION": "34, Oba Market Road, Benin City"
 },
 {
   "NAME": "Uche Iwuozo Meat Shop",
   "LOCATION": "18, Oba Market Road, Benin City"
 },
 {
   "NAME": "Oghosa Meat Shop",
   "LOCATION": "18, Oba Market Road, Benin City"
 },
 {
   "NAME": "F.O Meat Shop",
   "LOCATION": "18, Oba Market Road, Benin City"
 },
 {
   "NAME": "Lynnfida Guest House",
   "LOCATION": "Osabuohien Close, Off Ihama GRA, B/City"
 },
 {
   "NAME": "Jenilla Hotel",
   "LOCATION": "8, Edokpolor Factory Road, Ikpoba Hill, Benin City"
 },
 {
   "NAME": "Lisbor Hotel",
   "LOCATION": "4, Sokponba Rd, Benin City"
 },
 {
   "NAME": "Royal Bakery",
   "LOCATION": "4, Iyobosa St, Benin City"
 },
 {
   "NAME": "Hotel Felona",
   "LOCATION": "Downson Rd, B/City"
 },
 {
   "NAME": "Aso Time Restaurant And Bar",
   "LOCATION": "5, Ihama GRA, B/City"
 },
 {
   "NAME": "Jeffosa  Suit/Guest House",
   "LOCATION": "22, Anuwa Str. Off Upper Sokponba Rd. Benin City"
 },
 {
   "NAME": "Winner Chort",
   "LOCATION": "93, Lagos Str. Benin City"
 },
 {
   "NAME": "Stainles Resturant",
   "LOCATION": "37, Costain Road B/City"
 },
 {
   "NAME": "Central Hotel",
   "LOCATION": "76, Akpakpava Road, B/City"
 },
 {
   "NAME": "The Royal Marble Hotel ",
   "LOCATION": "33, Ihama GRA, B/City"
 },
 {
   "NAME": "Nasco Bakery",
   "LOCATION": "117, Upper Mission Road, B/City"
 },
 {
   "NAME": "Ranzeki Hotel",
   "LOCATION": "6, Ihenuuriri Str. Gra B/City"
 },
 {
   "NAME": "Toc Hotel ",
   "LOCATION": "38, Dowson Road, B/City"
 },
 {
   "NAME": "Diamond Height",
   "LOCATION": "11, Urubi Street, B/City"
 },
 {
   "NAME": "Nosakhare Baker",
   "LOCATION": "1, Nosakhare St, B/City"
 },
 {
   "NAME": "Vicks Fast Food ",
   "LOCATION": "36, Ihama GRA, B/City"
 },
 {
   "NAME": "Consulate Bar",
   "LOCATION": "19, Ikpokpan Rd, B/City"
 },
 {
   "NAME": "Isno Hotel",
   "LOCATION": "17, Ikpokpan Rd, GRA, B/City"
 },
 {
   "NAME": "Pire Motel",
   "LOCATION": "Evbomwan Close, Off Sapele Rd, B/City."
 },
 {
   "NAME": "Wayitaz Fast Food ",
   "LOCATION": "13 Ikpokpan Rd, GRA, B/City."
 },
 {
   "NAME": "Two Sisters Hotel",
   "LOCATION": "113, Akpakpava Road, B/City"
 },
 {
   "NAME": "Fce Bakery",
   "LOCATION": "15, Independence, Upper Sokponba Rd, B/City"
 },
 {
   "NAME": "Obaro Guest House ",
   "LOCATION": "66, Old Benin-Auchi Rd, B/City"
 },
 {
   "NAME": "Osagide Guest House ",
   "LOCATION": "108, Old Benin-Auchi Rd, B/City"
 },
 {
   "NAME": "Aduwawa Guest House ",
   "LOCATION": "39, College Rd Aduwawa, B/City"
 },
 {
   "NAME": "B Hotel",
   "LOCATION": "200, Ekenwan Rd, Benin City"
 },
 {
   "NAME": "Reliance Hotel",
   "LOCATION": "13, Efionayi Rd, Off Aduwawa Rd, B/City."
 },
 {
   "NAME": "Mr Votel Hotel",
   "LOCATION": "1, Agbontaen Rd, Aduwawa, Benin City"
 },
 {
   "NAME": "De Palce Bar",
   "LOCATION": "121, Igun St. B/City."
 },
 {
   "NAME": "Honie Base Bar",
   "LOCATION": "53, Wire Rd B/City"
 },
 {
   "NAME": "Greater Love Butter Bread",
   "LOCATION": "12, Akenzua Street Off Okhoro Rd B/City"
 },
 {
   "NAME": "Bj Bread ",
   "LOCATION": "11, Eweks Off Upper Siluko Road, B/City"
 },
 {
   "NAME": "Christo Bakers",
   "LOCATION": "124, Uwelu Rd, B/City."
 },
 {
   "NAME": "Oviane Bakery",
   "LOCATION": "27, Eweka Off Upper Siloku "
 },
 {
   "NAME": "Chemijar Hotel ",
   "LOCATION": "1, Ogiva, Ogivaba Avenue Off Upper Uwa B/City"
 },
 {
   "NAME": "Eldorado Hotel",
   "LOCATION": "08, Neka Street Off Ugbor, Gra B/City."
 },
 {
   "NAME": "Food Outlet ",
   "LOCATION": "10, Iwehen St, B/City."
 },
 {
   "NAME": "Edina Pure Water",
   "LOCATION": "18, Ikpopan Rd, Gra B/City"
 },
 {
   "NAME": "Gt Fast Food Plaza",
   "LOCATION": "Benin Agbor Road"
 },
 {
   "NAME": "Model Restaurent  And Elegance Hotel",
   "LOCATION": "58, Boundary Rd, B/City"
 },
 {
   "NAME": "Samsy Hotel ",
   "LOCATION": "2, Hospital Rd, Gra"
 },
 {
   "NAME": "Corea Fast Food",
   "LOCATION": "132 2nd East Circular Rd."
 },
 {
   "NAME": "Perfect Place Bar",
   "LOCATION": "179, Siluko Rd"
 },
 {
   "NAME": "Nigeria Man And Bar",
   "LOCATION": "7, Oguola St Off Mission Rd, B/City."
 },
 {
   "NAME": "Food Outlet",
   "LOCATION": "95, Wire Road B/City."
 },
 {
   "NAME": "Food Outlet ",
   "LOCATION": "28, Ready, 69 Akpakpava, B/City"
 },
 {
   "NAME": "Chinedu Baker",
   "LOCATION": "52, Siluko Rd, B/City"
 },
 {
   "NAME": "Ajero Restaurant And Bar",
   "LOCATION": "50, Siluko Rd, B/City."
 }
]

x = mycol.insert_many(mylist)

#print list of the _id values of the inserted documents:

print(x.inserted_ids)


# **Insert Multiple Documents, with Specified IDs**
# 
# If you do not want MongoDB to assign unique ids for you document, you can specify the _id field when you insert the document(s).
# 
# Remember that the values has to be unique. Two documents cannot have the same _id.

# In[36]:


import pymongo
myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["EnvironmentalIndicators"]
mycol = mydb["indicators"]
mylist = [
  { "_id": 1, "SN": 1,
   "POI": "OMOKARO JUNCTION ",
   "Address": "ALONG SILUKO ROAD",
   "Place": "SILUKO ROAD",
   "Y-Coordinate": 6.3573,
   "X-Coordinate": 5.600166667},
  { "_id": 2,"SN": 2,
   "POI": "EBO JUNCTION STREET",
   "Address": "OBA MARKET ROAD",
   "Place": "OBA MARKET  ROAD",
   "Y-Coordinate": 6.336016667,
   "X-Coordinate": 5.619183333},
  { "_id": 3, "SN": 3,
   "POI": "POLICE STATION ",
   "Address": "BY OBA MART ROAD",
   "Place": "OBA MARKET  ROAD",
   "Y-Coordinate": 6.335683333,
   "X-Coordinate": 5.620016667},
  { "_id": 4, "SN": 4,
   "POI": "IBIWE STREET",
   "Address": "OPPOSITE EBO STREET JUNCTION",
   "Place": "IBIWE",
   "Y-Coordinate": 6.338416667,
   "X-Coordinate": 5.620116667},
  { "_id": 5, "SN": 5,
   "POI": "EMOTAN COLLEGE",
   "Address": "WIRE ROAD",
   "Place": "",
   "Y-Coordinate": 6.3467,
   "X-Coordinate": 5.619333333},
  { "_id": 6,  "SN": 6,
   "POI": "BEHIND ST AUGUSTINE CHURCH",
   "Address": "SILUKO ROAD",
   "Place": "SILUKO ROAD",
   "Y-Coordinate": 6.344066667,
   "X-Coordinate": 5.614066667},
  { "_id": 7, "SN": 7,
   "POI": "IGU QUARTER",
   "Address": "",
   "Place": "OGBE",
   "Y-Coordinate": 6.279333333,
   "X-Coordinate": 5.52935},
  { "_id": 8,"SN": 8,
   "POI": "OMORUYI JUNCTION",
   "Address": "ERHUMWUNSE",
   "Place": "",
   "Y-Coordinate": 6.343916667,
   "X-Coordinate": 5.599133333},
  { "_id": 9,  "SN": 9,
   "POI": "UYINSTREET JUNCTION",
   "Address": "EGHOSA STREET",
   "Place": "",
   "Y-Coordinate": 6.344633333,
   "X-Coordinate": 5.598466667},
  { "_id": 10, "SN": 10,
   "POI": "EHENDEN STREET",
   "Address": "2ND CEMETRY",
   "Place": "",
   "Y-Coordinate": 6.34175,
   "X-Coordinate": 5.606733333},
  { "_id": 11, "SN": 11,
   "POI": "INDEPENDENT LANE",
   "Address": "EHENEDE STREETT",
   "Place": "",
   "Y-Coordinate": 6.3402,
   "X-Coordinate": 5.6054},
  { "_id": 12, "SN": 12,
   "POI": "ILLEGAL WASTE DUMP ALONG",
   "Address": "",
   "Place": "UPPER MISSION EXT",
   "Y-Coordinate": 6.377533333,
   "X-Coordinate": 5.6542},
  { "_id": 13,"SN": 13,
   "POI": "ILLEGAL WASTE DUMP BY TEMBOGA JUN",
   "Address": "",
   "Place": "UPPER MISSION EXT",
   "Y-Coordinate": 6.376783333,
   "X-Coordinate": 5.6496},
  { "_id": 14,  "SN": 14,
   "POI": "ILLEGAL WASTE DUMP BEFOR IKPOBA RIVER ALONG UPPER MIS EXT",
   "Address": "",
   "Place": "",
   "Y-Coordinate": 6.372866667,
   "X-Coordinate": 5.646583333},
  { "_id": 15, "SN": 15,
   "POI": "ILLEGAL WASTE DUMP BY MOAT B4OWOSENI JUNC ",
   "Address": "ALONG MISSION RD",
   "Place": "",
   "Y-Coordinate": 6.3472,
   "X-Coordinate": 5.630033333},
  { "_id": 16,  "SN":16,
   "POI": "ILLEGAL WASTE DUMP SITE",
   "Address": "AKPAKPAVA",
   "Place": "AKPAKPAVA",
   "Y-Coordinate": 6.34635,
   "X-Coordinate": 5.6382}
]

x = mycol.insert_many(mylist)

#print a list of the _id values of the inserted documents:
print(x.inserted_ids)


# **Find data in a collection**
# 
# *Find One*
# 
# In MongoDB we use the find and findOne methods to find data in a collection.
# 
# Just like the SELECT statement is used to find data in a table in a MySQL database.

# In[37]:


#Find the first document in the customers collection:
import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["FoodCenter"]
mycol = mydb["customers"]

x = mycol.find_one()

print(x)


# In[38]:


"""
To select data from a table in MongoDB, we can also use the find() method.
The find() method returns all occurrences in the selection.
"""

#Return all documents in the "customers" collection, and print each document:


import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["FoodCenter"]
mycol = mydb["customers"]

for x in mycol.find():
  print(x)


# In[39]:


#Return only the names and locations, not the _ids:
import pymongo
myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["FoodCenter"]
mycol = mydb["customers"]
for x in mycol.find({},{ "_id": 0, "NAME": 1, "LOCATION": 1 }):
  print(x)


# In[40]:


#This example will exclude "LOCATION" from the result:
import pymongo
myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["FoodCenter"]
mycol = mydb["customers"]
for x in mycol.find({},{ "LOCATION": 0 }):
  print(x)


# **Find document(s) with the LOCATION "No. 4, Sokponba Road, B/C.":**
# 
# Start and stop MongoDB service
# 
# 
# ```Python
# 
# C:\Program Files\MongoDB\Server\4.0\bin>net stop MongoDB
# Le service MongoDB Server s’arrête.
# Le service MongoDB Server a été arrêté.
# 
# 
# C:\Program Files\MongoDB\Server\4.0\bin>net start MongoDB
# Le service MongoDB Server démarre..
# Le service MongoDB Server a démarré.
# 
# ```
# 

# In[8]:


import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["FoodCenter"]
mycol = mydb["customers"]

myquery = { "LOCATION": "No. 4, Sokponba Road, B/C." }

mydoc = mycol.find(myquery)

for x in mydoc:
  print(x)


# **Find documents where the address starts with the letter "M" or higher:**

# In[11]:


import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["FoodCenter"]
mycol = mydb["customers"]

#LOCATION greater than L:
myquery = { "LOCATION": {"$gt": "M"} }

mydoc = mycol.find(myquery)

for x in mydoc:
  print(x)


# **Find documents where the address starts with the letter "K":**
# 
# We use use the regular expression {"$regex": "^K"}:

# In[12]:


import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["FoodCenter"]
mycol = mydb["customers"]

myquery = { "LOCATION": { "$regex": "^K" } }

mydoc = mycol.find(myquery)

for x in mydoc:
  print(x)


# **Sort the result alphabetically by NAME:**

# In[13]:


import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["FoodCenter"]
mycol = mydb["customers"]

mydoc = mycol.find().sort("NAME")

for x in mydoc:
  print(x)



# **Sort the result reverse alphabetically by name:**

# In[14]:


import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["FoodCenter"]
mycol = mydb["customers"]

mydoc = mycol.find().sort("NAME", -1)

for x in mydoc:
  print(x)


# **Delete the document with the NAME "Victory Hotel":**

# In[15]:


import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["FoodCenter"]
mycol = mydb["customers"]

myquery = { "NAME": "Victory Hotel" }

mycol.delete_one(myquery)


#print the customers collection after the deletion:
for x in mycol.find():
  print(x)



"""

Delete all documents were the LOCATION starts with the letter J:

import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["FoodCenter"]
mycol = mydb["customers"]

myquery = { "address": {"$regex": "^J"} }

x = mycol.delete_many(myquery)

print(x.deleted_count, " documents deleted.")



Delete all documents in the "customers" collection:

import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["FoodCenter"]
mycol = mydb["customers"]

x = mycol.delete_many({})

print(x.deleted_count, " documents deleted.")


"""


# **Delete the "customers" collection:**
# 
# You can delete a table, or collection as it is called in MongoDB, by using the drop() method.

# In[ ]:


"""
import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["FoodCenter"]
mycol = mydb["customers"]

mycol.drop()
"""


# **Change the Address from : "ERHUMWUNSE" to "No. 169, 1st East Circular Road, B/C.":**

# In[17]:


import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["EnvironmentalIndicators"]
mycol = mydb["indicators"]

myquery = { "Address": "ERHUMWUNSE" }
newvalues = { "$set": { "address": "No. 169, 1st East Circular Road, B/C." } }

mycol.update_one(myquery, newvalues)

#print "customers" after the update:
for x in mycol.find():
  print(x)


# **Update all documents where the address starts with the letter "O":**

# In[18]:




import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["EnvironmentalIndicators"]
mycol = mydb["indicators"]

myquery = { "Address": { "$regex": "^O" } }
newvalues = { "$set": { "name": "EBENEZER" } }

x = mycol.update_many(myquery, newvalues)

print(x.modified_count, "documents updated.")


# **Limit the result to only return 2 documents:**

# In[20]:


import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["FoodCenter"]
mycol = mydb["customers"]

myresult = mycol.find().limit(2)

#print the result:
for x in myresult:
  print(x)

