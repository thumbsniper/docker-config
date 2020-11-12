# Deprecation notice:
**This project is closed and no longer maintained. Updates are not expected.**

**The project code will remain publicly available, but could disappear at any time.**

# Getting started

## Learn how to install a ThumbSniper test-drive in your own environment
This guide should enable you to easily deploy a working ThumbSniper instance by using Docker containers. Although it's (technically) possible to do everything on your own, using Docker is a great way to simplify tasks.  Please be aware that the Docker images are pre-configured with a lot of default options. These are not meant for production environments, so you should modify these options accordingly.

### Requirements
- a system with a working Docker environment:
  - Docker 1.10.0+
  - Docker Compose 1.6.0+
- Docker containers should be allowed to reach the internet

### Domain & IP setup
The Docker images are pre-configured with the domain ```example.com```. Please add the following line to the file ```/etc/hosts``` on the machine that is accessing the ThumbSniper environment (commonly the machine with your web browser):

```
docker-host-ip   api.example.com img.example.com panel.example.com
```

### Create and prepare host directories
This guide assumes that the Docker Compose project is kept within the directory ```/data/thumbsniper``` on your Docker host, so this directory is required and needs to be created. Run as user ```root```:
```
mkdir -p /data/thumbsniper
chmod 750 /data/thumbsniper
```
The name of this directory is used as the Docker Compose project name and may also contain additional files in the future.

### Set up Docker images
The following steps describe how to fetch and run the example Docker containers.

#### Download docker-compose configuration
Download the latest https://github.com/thumbsniper/docker-config/blob/master/run/docker-compose.yml (docker-compose.yml) file  as shown below:
```
curl -o /data/thumbsniper/docker-compose.yml \
https://raw.githubusercontent.com/thumbsniper/docker-config/master/run/docker-compose.yml
```
#### (optional) Pull Docker images prior running the project
You may want to fetch the images defined in ```docker-compose.yml``` as a single step. This has to be done from the working directory ```/data/thumbsniper```. If this step is skipped, the Docker images will be pulled automatically upon project start.
```
cd /data/thumbsniper
docker-compose pull
```
#### Start Docker containers
Your environment should now be ready to start. The following command will (pull and) create all required containers. The option ```-d``` starts all project containers in detached (background) mode:
```
cd /data/thumbsniper
docker-compose up -d
```
You should then see log messages about the container creation similar to this:
```
Creating network "thumbsniper_default" with the default driver
Creating volume "thumbsniper_web_thumbnails" with default driver
Creating volume "thumbsniper_mongo_data" with default driver
Creating thumbsniper_mongo_1
Creating thumbsniper_redis_1
Creating thumbsniper_web_1
Creating thumbsniper_agent-normal_1
Creating thumbsniper_agent-image_1
Creating thumbsniper_agent-longrun_1
```
If this worked, examine the docker-compose process list with the command ```docker-compose ps```. It should look like this:
```
           Name                         Command              State         Ports
----------------------------------------------------------------------------------------
thumbsniper_mongo_1          /entrypoint.sh mongod           Up    27017/tcp
thumbsniper_redis_1          /entrypoint.sh redis-serve ...  Up    6379/tcp
thumbsniper_web_1            /init.sh                        Up    0.0.0.0:80->80/tcp
thumbsniper_agent-normal_1   /start.sh                       Up
thumbsniper_agent-longrun_1  /start.sh                       Up
thumbsniper_agent-image_1    /start.sh                       Up
```
Your project should now be ready. Do you see state "Up" for all containers, too? Well done!

#### Create an admin account for Panel
Visit http://panel.example.com with your browser (remember the ```/etc/hosts``` settings) and register a new user account. Please use the e-mail address ```my-admin-address@example.com```.  This is a pre-configured address which currently does not need to be a real address within this test-drive context. It will give you administrative permissions for your account. The admin-view mode can be toggled on the top-right menu after clicking on your user name.
