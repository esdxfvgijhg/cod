# server-docker
Docker-compose of server's python scripts, LEMP stack, separated on multiple containers.  
This supports both old and new sensor protocols.

## Instructions
1. Install Docker Compose.  
https://docs.docker.com/compose/install/  

2. Clone/copy, then `cd` to this `server-docker` directory.   

3. Edit `docker-compose.yml` to assign your MySQL password  

4. Start server for the first time.  
> $ docker-compose up -d  

  Test the server by opening your web browser to `http://localhost` or `http://YOUR_SERVER_IP`

5. To start/stop server on the next time.
  - Start server  
> $ docker-compose start  

  - Stop server  
> $ docker-compose stop  

6. (optional) Make the server to auto start at boot. (example for Linux)  
  - Open crontab file  
> $ crontab -e  

  - Add a new line to the file. (replace `~/server-docker` with your path)  
> @reboot cd ~/server-docker && /usr/local/bin/docker-compose start  

  - Save, exit and reboot.  
> $ sudo reboot  

## Directories
- html: Web server root
- python: Python server for receiving data from sensors (new protocol)
- python_old: Python server for receiving data from sensors (old protocol)
- mysql: (auto create on first run) Contains MySQL database files 
- logs: (auto create on first run) Contains NGINX logs
- conf: Contains configuration files for nginx, php, mysql
- docker-files: Contains Dockerfiles for building docker images

