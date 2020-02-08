#!/usr/bin/env python
# coding: utf-8

# # PRACTICAL WORK 
# ********************
# ********************
# ********************
# Proposed by 
# 
# __ CARLYNA BONDIOMBOUY__
# 
# 
# ********************
# ********************
# ********************
# 
# ## Install Neo4j on Windows
# 
# 1. Visit the Neo4j official site using https://www.softpedia.com/dyn-postdownload.php/97c79d8225e5bd6d078d50b022a2d934/5c719823/3abe9/0/2. On clicking, this link will take you to the homepage of neo4j website.
# 
# 
# 2. As highlighted in the above screenshot, this page has a Download button on the top right hand side. Click it.
# 
# 
# 3. This will redirect you to the downloads page, where you can download the community edition and the enterprise edition of Neo4j. Download the community edition of the software by clicking the respective button.
# 
# 4. This will take you to the page where you can download community version of Neo4j software compatible with different operating systems. Download the file respective to the desired operating system.
#     This will download a file named neo4j-community_windows-x64_3_1_1.exe to your system as shown in the following screenshot.
#     
# 5. Double-click the exe file to install Neo4j Server.
# 
# 6. Accept the license agreement and proceed with the installation. After completion of the process, you can observe that Neo4j is installed in your system.
# 
# 
# ### Starting the Server
# 
#    1. Click the Windows startmenu and start the Neo4j server by clicking the start menu shortcut for Neo4j.
#     
#    2. On clicking the shortcut, you will get a window for Neo4j Community edition. By default, it selects c:\Users\username\Documents\Neo4j\default.graphdb. If you want, you can change your path to a different directory. 
#     Once the server starts, you can observe that the database directory is populated as shown in the following screenshot.
#     
#     
# ### Working with Neo4j
# 
# Neo4j provides an in-built browse application to work with Neo4j. You can access Neo4j using the URL http://localhost:7474/
# 
# ```Python
# 
# C:\Program Files\Python37>pip install neo4j
# 
# C:\Program Files\Python37>pip install py2neo
# 
# C:\Program Files\Python37>pip install neo4j-driver
# 
# C:\Users\carlyna.bondiombouy\neo4j-community-3.5.3>
# 
# C:\Users\carlyna.bondiombouy\neo4j-community-3.5.3>cd bin
# 
# C:\Users\carlyna.bondiombouy\neo4j-community-3.5.3\bin>ls
# 
# cypher-shell.bat  neo4j-import.bat  Neo4j-Management.psd1  tools
# 
# neo4j-admin.bat   neo4j-import.ps1  neo4j.bat
# 
# neo4j-admin.ps1   Neo4j-Management  neo4j.ps1
# 
# C:\Users\carlyna.bondiombouy\neo4j-community-3.5.3\bin>neo4j.bat install-service
# Neo4j service installed
# 
# C:\Users\carlyna.bondiombouy\neo4j-community-3.5.3\bin>net start neo4j
# 
# Le service Neo4j Graph Database - neo4j démarre.
# 
# Le service Neo4j Graph Database - neo4j a démarré.
# 
# 
# C:\Users\carlyna.bondiombouy\neo4j-community-3.5.3\bin>net stop neo4j
# 
# Le service Neo4j Graph Database - neo4j s’arrête.
# 
# Le service Neo4j Graph Database - neo4j a été arrêté.
# 
# ```
# 
# ## Mac Installation (dmg)
# 
# 1. The installer includes the Java version needed for running Neo4j.
# 2. Open the dmg file you just downloaded.
# 3. Drag the Neo4j icon into your Applications folder. Watch the video to see this in action.
# 4. Open Neo4j from your Applications folder. You might need to acknowledge that you downloaded the application from the Internet.
# 5. Click on the Start button to start the Neo4j server.
# 6. Open the provided URL in your local web browser.
# 7. Change the password for the neo4j account.
# 
# 
# ## Linux/UNIX Install (tar)
# 
# 1. Open up your terminal/shell.
# 2. Extract the contents of the archive, using: tar -xf  $<filecode>$. For example,
# 3. tar -xf neo4j-enterprise-2.3.1-unix.tar.gz  the top level directory is referred to as NEO4J_HOME
# 4. Run Neo4j using $NEO4J_HOME/bin/neo4j console. Instead of ‘neo4j console’, you can use neo4j start to start the server process in the background.
# 5. Visit http://localhost:7474 in your web browser.
# 6. Change the password for the neo4j account.

# ## Exercise
# 
# ### Create Node with Properties
# 
#   1. Create nodes
#   
# 
#     CREATE (node:label { key1: value, key2: value, . . . . . . . . .  }) 
#     
#     
#   2. Verification
#   
# To verify the creation of the node, type and execute the following query in the dollar prompt.
# 
#     MATCH (n) RETURN n 
#     
# ****************
# 
# ```Python
# CREATE (Ebohon:Attraction {name:'Chief Priest Osemwengie Ebohon Botanical Garden', location:'Benin City',  status:'functional'})
# CREATE (Ogbe:Person {name:'Ogbe Oronsaye ', born:1964})
# CREATE (Uyiosa:Person {name:'Uyiosa Idehen', born:1967})
# CREATE (Igbinosa:Person {name:'Igbinosa Bello', born:1961})
# CREATE (Abeni:Person {name:'Abeni Davies', born:1960})
# CREATE (Oriafo:Person {name:'Oriafo Osigbemhe', born:1967})
# CREATE (Bello:Person {name:'Bello Ogbeide', born:1965})
# CREATE (Adizie:Person {name:'Adizie Solomon', born:1952})
# CREATE
#   (Ogbe)-[:VISITED]->(Ebohon),
#   (Uyiosa)-[:VISITED]->(Ebohon),
#   (Igbinosa)-[:VISITED]->(Ebohon),
#   (Abeni)-[:VISITED]->(Ebohon),
#   (Oriafo)-[:MANAGED]->(Ebohon),
#   (Bello)-[:MANAGED]->(Ebohon),
#   (Adizie)-[:CONTRIBUTE]->(Ebohon)
#   
#   
# CREATE (Abulu:Person {name:" Abulu Cole", born:1978})
# CREATE (Abulu)-[:CLEANED {roles:["Abulu"]}]->(Ebohon)  
# 
# 
# CREATE (Ogiamen:Attraction {name:'Ogiamen Palace', location:'Benin City',  status:'functional'})
# CREATE (historical:Place {name:'historical places'})
# CREATE (monuments:Place {name:'monuments'})
# CREATE (temples:Place {name:'ancient temples'})
# CREATE (zoos:Place {name:'zoos'})
# CREATE (aquaria:Place {name:'aquaria'})
# CREATE (museums:Place {name:'museums and art galleries'})
# CREATE (parks:Place {name:'theme parks and carnivals'})
# CREATE
#   (historical)-[:INCLUDE]->(Ogiamen),
#   (monuments)-[:INCLUDE]->(Ogiamen),
#   (temples)-[:INCLUDE]->(Ogiamen),
#   (zoos)-[:INCLUDE]->(Ogiamen),
#   (aquaria)-[:INCLUDE]->(Ogiamen),
#   (museums)-[:INCLUDE]->(Ogiamen),
#   (parks)-[:INCLUDE]->(Ogiamen)
#   
# 
# CREATE (gardens:Place {name:'botanical gardens'})
# CREATE (buildings:Place {name:'buildings and structures'})
# CREATE (art:Place {name:'public art'})
# CREATE
#   (historical)-[:INCLUDE]->(Ebohon),
#   (monuments)-[:INCLUDE]->(Ebohon),
#   (temples)-[:INCLUDE]->(Ebohon),
#   (gardens)-[:INCLUDE]->(Ebohon),
#   (buildings)-[:INCLUDE]->(Ebohon),
#   (art)-[:INCLUDE]->(Ebohon),
#   (zoos)-[:INCLUDE]->(Ebohon),
#   (aquaria)-[:INCLUDE]->(Ebohon)
#   
# RETURN Ebohon,Ogbe,Uyiosa,Igbinosa,Abeni,Oriafo,Bello,Adizie,Abulu,Ogiamen,historical,monuments,temples,zoos,aquaria,museums,parks,gardens,buildings,art
# 
# ```

# In[8]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/create.png')


# In[9]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/graph.png')


# In[5]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/table.png')


# 
# ****************
# 
# ```Python
# 
# CREATE (Oba:Attraction {name:'Oba Palace and Walls', location:'Benin City', status:'functional'})
# CREATE (Edoka:Person {name:'Edoka Adolphuse', born:1970})
# CREATE (Adolor:Person {name:'Adolor Aiwerioba', born:1977})
# CREATE (Abrose:Person {name:'Ambrose Anegbette', born:1967})
# CREATE (Ebelle:Person {name:'Dagbala Ebelle', born:1969})
# CREATE (Oriafo:Person {name:'Oriafo Osigbemhe', born:1966})
# CREATE (Bello:Person {name:' Edeki Edokpolo ', born:1969})
# CREATE (Adizie:Person {name:'Adizie Solomon', born:1976})
# CREATE
#   (Ogbe)-[:VISITED]->(Oba),
#   (Uyiosa)-[:VISITED]->(Oba),
#   (Igbinosa)-[:VISITED]->(Oba),
#   (Abeni)-[:VISITED]->(Oba),
#   (Oba)-[:VISITED]->(Oba),
#   (Adolor)-[:VISITED]->(Oba),
#   (Abrose)-[:VISITED]->(Oba),
#   (Ebelle)-[:VISITED]->(Oba),
#   (Oriafo)-[:INVEST]->(Oba),
#   (Bello)-[:MANAGED]->(Oba),
#   (Adizie)-[:EMPLOY]->(Oba)
#   
# CREATE (art:Place {name:'public art'})
# CREATE (museums:Place {name:'living history museums'})
# CREATE (events:Place {name:'historic trains and cultural events'})
# CREATE (ethnic:Place {name:'ethnic enclave communities'})
# CREATE (signs:Place {name:'signs'})
# CREATE
#   (art)-[:INCLUDE]->(Oba),
#   (museums)-[:INCLUDE]->(Oba),
#   (events)-[:INCLUDE]->(Oba),
#   (ethnic)-[:INCLUDE]->(Oba),
#   (signs)-[:INCLUDE]->(Oba)
#     
# RETURN Oba,Edoka,Adolor,Abrose,Ebelle,Oriafo,Bello,Adizie,art,museums,events,ethnic,signs
#   
#     ```

# ### Create an index
# 
# An index is a data structure that improves the speed of data retrieval operations in a database.
# 
# To create an index, use the CREATE INDEX ON statement. Like this:
# 
# ```Python
# CREATE INDEX ON :Person(Name)
#       ```

# In[1]:


from IPython.display import Image
Image(filename='C:/Users/carlyna.bondiombouy/Desktop/IMSP SPARK/index.png')


# ### Create a constraint and query data
# 
# 1. Constraints help enforce data integrity.
# 
# ```Python
# $ CREATE CONSTRAINT ON (Oba:Attraction) ASSERT Oba.Name IS UNIQUE
#    ```
#    
# 2. The MATCH statement is used to match a given criteria, but it doesn't actually return the data. To return any data from a MATCH statement, we still need to use the RETURN clause.
# 
# ```Python
# $ MATCH (person:Person)-[:VISITED]->(place:Attraction)
# WHERE person.name = "Bello" 
# RETURN person
# 
# $ MATCH (n) RETURN n
# 
# 
# $ MATCH (p:Person)
# WHERE p.name = "Adolor"
# RETURN p
#    ```

# ### Import data from a csv
# 
# 
# ```Python
# $ LOAD CSV FROM 'https://www.quackit.com/neo4j/tutorial/genres.csv' AS line
# CREATE (:Genre { GenreId: line[0], Name: line[1]})
# 
# $ LOAD CSV WITH HEADERS FROM 'https://www.quackit.com/neo4j/tutorial/tracks.csv' AS line
# CREATE (:Track { TrackId: line.Id, Name: line.Track, Length: line.Length})
# 
# $ USING PERIODIC COMMIT
# LOAD CSV WITH HEADERS FROM 'https://www.quackit.com/neo4j/tutorial/tracks.csv' AS line
# CREATE (:Track { TrackId: line.Id, Name: line.Track, Length: line.Length})
# 
#    ```

# ### Drop and delete
# 
# 1. Drop an index
# 
#   ```Python
#   $ DROP INDEX ON :Attraction(name)
#         
#   $ :schema
#    ```
# 2. Drop a constraint
# 
#  ```Python
#   $ DROP CONSTRAINT ON (Oba:Attraction) ASSERT Oba.Name IS UNIQUE
#    ```
# 3. Delete node
# 
# ```Python
#    $ MATCH (Oba:Attraction {name: "Oba Palace and Walls"}) DELETE Oba
#   ```
# 4. Relationship 
# 
# ```Python
#    $ MATCH ()-[v:VISITED]-() 
#   DELETE v
# ```
