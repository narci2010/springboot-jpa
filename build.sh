#!/bin/bash

source /etc/profile

MYIMAGE=192.168.3.188:8082/springboot/springboot-jpa

# uncomment if you need push
#docker login 192.168.3.188:8082 -u admin -p admin123

# stop all container
if [ -n "$(docker ps -q)" ]; then
　　docker kill $(docker ps -q)
fi

# remove all container
if [ -n "$(docker ps -aq)" ]; then
　　docker rm $(docker ps -aq)
fi

# remove old images
#docker images | grep 192.168.3.188:8082/springboot/springboot-jpa | awk '{print $3}' | xargs docker rmi

if [ -n "$(docker images -q| grep 192.168.3.188:8082/springboot/springboot-jpa | awk '{print $3}')" ]; then
　　docker images -q| grep 192.168.3.188:8082/springboot/springboot-jpa | awk '{print $3}' | xargs docker rmi
fi
# build jar and image
sudo mvn package -e -X docker:build -DskipTest

# running container
docker run -dp 8080:8080 --name springboot-jpa ${MYIMAGE}

# push image
#docker push ${MYIMAGE}


