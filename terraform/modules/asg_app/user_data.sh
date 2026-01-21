#!/bin/bash
yum update -y
yum install -y docker
systemctl start docker
systemctl enable docker

sleep 10

docker run -d -p 8000:8000 --name identity ${IDENTITY_IMAGE}
docker run -d -p 8001:8000 --name user ${USER_IMAGE}
