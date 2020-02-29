#!/usr/bin/env python
# coding: utf-8

# In[3]:


import os 


# In[7]:


os.mkdir('tempdir')


# In[8]:


dirName = 'tempDir'
 
try:
    # Create target Directory
    os.mkdir(dirName)
    print("Directory " , dirName ,  " Created ") 
except FileExistsError:
    print("Directory " , dirName ,  " already exists")


# In[13]:


import gzip 
dir_in = open('C:/Users/carlyna.bondiombouy/Desktop/Cotonou/test_nifi.zip')
dir_out = gzip.open('C:/Users/carlyna.bondiombouy/Desktop/Cotonou/test_nifi.gz', 'wb')
#f_out.writelines(f_in)
dir_out.close()
dir_in.close()


# In[21]:


from shutil import make_archive
import os
archive_name = os.path.expanduser(os.path.join('~', 'myarchive'))
root_dir = os.path.expanduser(os.path.join('~', 'C:/Users/carlyna.bondiombouy/Desktop/Cotonou/test_nifi'))
#make_archive(archive_name, 'gztar', root_dir)
make_archive(archive_name, 'gztar')
'C:/Users/carlyna.bondiombouy/Desktop/Cotonou/test_nifi'


# In[ ]:




