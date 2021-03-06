## 👋 Welcome to ProjectName 🚀  

GEN_README_REPLACE_DESCRIBE  
  
  
## Run container

```shell
dockermgr update ProjectName
```

### via command line

```shell
docker pull casjaysdevdocker/ProjectName:latest && \
docker run -d \
--restart always \
--name casjaysdevdocker-ProjectName \
--hostname casjaysdev-ProjectName \
-e TZ=${TIMEZONE:-America/New_York} \
-v $HOME/.local/share/docker/storage/ProjectName/ProjectName/data:/data \
-v $HOME/.local/share/docker/storage/ProjectName/ProjectName/config:/config \
-p 80:80 \
casjaysdevdocker/ProjectName:latest
```

### via docker-compose

```yaml
version: "2"
services:
  ProjectName:
    image: casjaysdevdocker/ProjectName
    container_name: ProjectName
    environment:
      - TZ=America/New_York
      - HOSTNAME=casjaysdev-ProjectName
    volumes:
      - $HOME/.local/share/docker/storage/ProjectName/data:/data:z
      - $HOME/.local/share/docker/storage/ProjectName/config:/config:z
    ports:
      - 80:80
    restart: always
```

## Authors  

🤖 AuthorName: [Github](https://github.com/AuthorName) [Docker](https://hub.docker.com/r/AuthorName) 🤖  
⛵ CasjaysDevdDocker: [Github](https://github.com/casjaysdev) [Docker](https://hub.docker.com/r/casjaysdevdocker) ⛵  
