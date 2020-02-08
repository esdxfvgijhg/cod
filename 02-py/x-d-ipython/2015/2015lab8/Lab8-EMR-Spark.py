#!/usr/bin/env python
# coding: utf-8

# ## WARNING: MAKE SURE YOU TERMINATE YOUR AWS INSTANCES WHEN YOU'RE DONE!!! OTHERWISE YOU WILL GET CHARGED (PROBABLY A LOT) BY AMAZON.

# ## Create an AWS account
# 
# * Go to https://aws.amazon.com acn click on the "Sign In to the Console" button on the upper right.
# 
# ---
# 
# ## Create an IAM user
# 
# 1. Log in (or create a new account) and click on the _Identity & Access Management_ link under the __Security & Identity__ section.
# 2. Select _Users_ on the menu on the left and click on the _Create New Users_ button.
# 3. Use __cs109__ for the user name and make sure the _Generate an access key for each user_ checkbox is selected.
# 4. Click the _Download Credentials_ button to get the new credential keys. Once the file is downloaded, click the _Close_ button.
# 5. Click on the newly created __cs109__ user.
# 6. Scroll down until you see the _Attach Policy_ button and click on it.
# 7. Search and select the __AdministratorAccess__ policy, and click the _Attach Policy_ button.
# 
# #### You should now have a file called __credentials.csv__ on your default download path and a new user with the necessary permissions to perform the next actions.
# 
# ---
# 
# ## Download and configure the AWS CLI tools
# 
# 1. Go to http://docs.aws.amazon.com/cli/latest/userguide/installing.html and find the instructions for the platform you're using.
# 2. Run the following on the command line: ```aws configure```
# 3. Fill out the requested information (replace the ??? bellow with the values from the credentials file):
# ```
# AWS Access Key ID [None]: ???
# AWS Secret Access Key [None]: ???
# Default region name [None]: us-east-1
# Default output format [None]: json
# ```
# 4. Run the following on the command line: ```aws emr create-default-roles```
# 
# #### You should get a big JSON string as the output of this command.
# 
# ---
# 
# ## Create an EC2 SSH key pair
# 
# 1. Run the following on the command line:
# 
# ```
# aws ec2 create-key-pair --key-name CS109 --query 'KeyMaterial' --output text > CS109.pem
# chmod 400 CS109.pem
# ```
# 
# #### You should now have a file called __CS109.pem__ on your current directory.
# 
# ---
# 
# ## Create the Spark cluster
# 
# * Run the following on the command line:
# ```
# export CLUSTER_ID=`aws emr create-cluster --name "CS109 Spark cluster" \
# --ami-version 3.10 --applications Name=Spark --ec2-attributes KeyName=CS109 \
# --instance-type m1.medium --instance-count 3 --use-default-roles \
# --bootstrap-actions Path=s3://cs109-2015/install-anaconda,Name=Install_Anaconda \
# --query 'ClusterId' --output text` && echo $CLUSTER_ID
# ```
# 
# The output of this command will be something like the following (your actual value will be different):
# ```
# j-33S87OUETACNK
# ```
# 
# It will take a few minutes for your cluster to be ready. Go watch some cat videos on YouTube and come back in 10 minutes or so.
# 
# ---
# 
# ## Connect to the iPython Notebook:
# 
# 1. Get the cluster master's IP:
# ```
# export DNS_NAME=`aws emr describe-cluster --cluster-id $CLUSTER_ID \
# --query 'Cluster.MasterPublicDnsName' --output text` && echo $DNS_NAME
# ```
# If the output of this command is __None__, your cluster is not ready yet. Wait a few minutes and run it again. Repeat until you get something different from __None__.
# 
# 2. Create an SSH tunel to the AWS box (this assumes your SSH key is on the same directory you are invoking the SSH command from).
# ```
# ssh -o ServerAliveInterval=10 -i CS109.pem hadoop@$DNS_NAME -N -L 8989:localhost:8888
# ```
# 
# 3. Open your browser and got to http://localhost:8989
# 
# ---
# 
# ## Run a Spark job
# 
# 1. Copy and paste the following on a notebook cell and run it:
# ```
# !hdfs dfs -copyFromLocal /home/hadoop/spark/README.md /user/hadoop/
# ```
# 2. Now do the same with the following snippet:
# 
# ```
# text_file = sc.textFile("/user/hadoop/README.md")
# 
# word_counts = text_file \
#     .flatMap(lambda line: line.split()) \
#     .map(lambda word: (word, 1)) \
#     .reduceByKey(lambda a, b: a + b)
# 
# word_counts.collect()
# ```
# 
# ---
# 
# ## Terminate the Spark cluster
# 
# * Run the following on the command line:
# ```
# aws emr terminate-clusters --cluster-ids $CLUSTER_ID
# aws ec2 delete-key-pair --key-name CS109
# rm CS109.pem
# ```

# In[ ]:




