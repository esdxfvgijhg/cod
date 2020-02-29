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
# ## The previous two steps only need to be performed once. The next steps must to be performed every time you create a new cluster (unless noted otherwise).
# 
# ---
# 
# ## Create an EC2 SSH key pair
# 
# ### Only perform the step bellow if this is the first time you are creating the SSH keys, or if you deleted the keys created on a previous iteration of these instructions.
# 
# * Run the following on the command line:
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
# --release-label emr-4.1.0 --applications Name=Spark --ec2-attributes KeyName=CS109 \
# --instance-type m1.large --instance-count 3 --use-default-roles \
# --bootstrap-actions Path=s3://cs109-2015/install-anaconda-emr,Name=Install_Anaconda \
# --query 'ClusterId' --output text` && echo $CLUSTER_ID
# ```
# 
# The output of this command will be something like the following (your actual value will be different):
# ```
# j-33S87OUETACNK
# ```
# 
# It will take a few minutes for your cluster to be ready. Go watch some cat videos on YouTube and come back in 20 minutes or so.
# 
# ---
# 
# ## Check cluster status
# 
# * Run the following on the command line:
# ```
# aws emr describe-cluster --cluster-id $CLUSTER_ID --query 'Cluster.Status.State' --output text
# ```
# 
# If the output is anything but _WAITING_, your cluster is not ready yet. Wait a few more minutes and run the command again. Do not proceeed until the cluster is ready.
# 
# ---
# 
# ## Connect to the iPython Notebook:
# 
# #### Make sure the cluster is ready before proceedeing.
# 
# 1. Get the cluster master's IP:
# ```
# export DNS_NAME=`aws emr describe-cluster --cluster-id $CLUSTER_ID \
# --query 'Cluster.MasterPublicDnsName' --output text` && echo $DNS_NAME
# ```
# 
# 2. Run the script to configure Spark:
# ```
# ssh -o ServerAliveInterval=10 -i CS109.pem hadoop@$DNS_NAME 'sh configure-spark.sh'
# ```
# 
# 3. Create an SSH tunel to the AWS box (this assumes your SSH key is on the same directory you are invoking the SSH command from).
# ```
# ssh -o ServerAliveInterval=10 -i CS109.pem hadoop@$DNS_NAME -L 8989:localhost:8888
# ```
# 
# 4. The previous command will create an SSH connection to the Spark cluster and a tunnel to access the notebook. Run the following command on the SSH section:
# ```
# pyspark
# ```
# 
# 5. Open your browser and got to http://localhost:8989 (or just click on this link)
# 
# ---
# 
# ## Do your thing...
# 
# ---
# 
# ## Terminate the Spark cluster
# 
# 1. Press _CTRL-C_ twice to terminate iPython.
# 
# 2. Type _exit_ on the command line to exit the SSH session.
# 
# 3. Run the following on the command line:
# ```
# aws emr terminate-clusters --cluster-ids $CLUSTER_ID
# ```
# 
# * Optionally, run the following two commands to remove your keys. This is only needed if you don't plan on creating new clusters.
# 
# ```
# aws ec2 delete-key-pair --key-name CS109
# rm CS109.pem
# ```
# 
# ---
# 
# ## Make sure the cluster was terminated
# 
# * Run the following on the command line:
# ```
# aws emr describe-cluster --cluster-id $CLUSTER_ID --query 'Cluster.Status.State' --output text
# ```
# 
# If the output is anything different from _TERMINATING_ or _TERMINATED_, re-run the command above or go to the AWS console and terminate the cluster manually.
# 
# ### YOU MUST TERMINATE THE CLUSTER OR YOU WILL BE CHARGED!!!

# In[ ]:




