#!/usr/bin/env python
# coding: utf-8

# # Lab 11: Part 2 - Food Inspection Forecasting: Data processing
# This file is an ipython notebook with [`R-magic`](https://ipython.org/ipython-doc/1/config/extensions/rmagic.html) to convert the data from Rds (the R programming language data dtorage sytem) to `csv` to be read into Python. If you ever find yourself in a bind with R code available for you... give `R-magic` a try. 
# 
# 
# ## **HUGE NOTE:  All code here is taken from the [food-inspections-evaluation]( https://github.com/Chicago/food-inspections-evaluation) repository** 
# ### They did a great job at cleaning the data in R so I don't want to repeat work.
# 
# All code and data is available on GitHub:
# https://github.com/Chicago/food-inspections-evaluation

# In[6]:


import rpy2
import pandas as pd
get_ipython().magic(u'load_ext rpy2.ipython')


# In[7]:


get_ipython().run_cell_magic(u'R', u'', u'# change to your local clone\ndata_dir = \'~/food-inspections-evaluation/\'\nout_dir = \'~\'\n\nlibrary("data.table", "ggplot2")\n\nsetwd(data_dir)')


# ### Food Inspection database processing

# In[8]:


get_ipython().run_cell_magic(u'R', u'', u'food = readRDS("DATA/food_inspections.Rds")\nwrite.csv(food, file = paste(out_dir, \'/food_inspections.csv\', sep = \'\'), row.names = FALSE)')


# ### Model Dataframe processing

# In[9]:


get_ipython().run_cell_magic(u'R', u'', u'dat = readRDS("DATA/dat_model.Rds")\nwrite.csv(dat, file = paste(out_dir, \'/dat_model.csv\', sep = \'\'))')


# In[10]:


get_ipython().run_cell_magic(u'R', u'', u'dat <- readRDS("DATA/dat_model.Rds")\n\n## Only keep "Retail Food Establishment"\ndat <- dat[LICENSE_DESCRIPTION == "Retail Food Establishment"]\n## Remove License Description\ndat$LICENSE_DESCRIPTION <- NULL\ndat <- na.omit(dat)\n\n## Add criticalFound variable to dat:\ndat$criticalFound <- pmin(1, dat$criticalCount)\n\n# ## Set the key for dat\nsetkey(dat, Inspection_ID)\n\n# Match time period of original results\n# dat <- dat[Inspection_Date < "2013-09-01" | Inspection_Date > "2014-07-01"]\n\n#==============================================================================\n# CREATE MODEL DATA\n#==============================================================================\n# sort(colnames(dat))\n\nxmat <- dat[ , list(Inspector = Inspector_Assigned,\n                    pastSerious = pmin(pastSerious, 1),\n                    pastCritical = pmin(pastCritical, 1),\n                    timeSinceLast,\n                    ageAtInspection = ifelse(ageAtInspection > 4, 1L, 0L),\n                    consumption_on_premises_incidental_activity,\n                    tobacco_retail_over_counter,\n                    temperatureMax,\n                    heat_burglary = pmin(heat_burglary, 70),\n                    heat_sanitation = pmin(heat_sanitation, 70),\n                    heat_garbage = pmin(heat_garbage, 50),\n                    # Facility_Type,\n                    criticalFound),\n            keyby = Inspection_ID]\nmm <- model.matrix(criticalFound ~ . -1, data=xmat[ , -1, with=F])\nmm <- as.data.table(mm)\nstr(mm)\ncolnames(mm)\n\n#==============================================================================\n# CREATE TEST / TRAIN PARTITIONS\n#==============================================================================\n# 2014-07-01 is an easy separator\n\ndat[Inspection_Date < "2014-07-01", range(Inspection_Date)]\ndat[Inspection_Date > "2014-07-01", range(Inspection_Date)]\n\niiTrain <- dat[ , which(Inspection_Date < "2014-07-01")]\niiTest <- dat[ , which(Inspection_Date > "2014-07-01")]\n\n## Check to see if any rows didn\'t make it through the model.matrix formula\nnrow(dat)\nnrow(xmat)\nnrow(mm)')


# In[11]:


get_ipython().run_cell_magic(u'R', u'', u"# Output Model Matrix and Target\nwrite.csv(mm, file = paste(out_dir, '/model_matrix.csv', sep = ''), row.names = FALSE)\nwrite.csv(xmat$criticalFound, file = paste(out_dir, '/TARGET.csv', sep = ''), row.names = FALSE)")

