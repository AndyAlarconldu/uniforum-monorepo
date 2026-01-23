#!/bin/bash
yum update -y
yum install -y docker
systemctl start docker
systemctl enable docker

echo "Starting microservices..." > /var/log/microservices.log

docker run -d \
  --name identity \
  -p 8000:8000 \
  ${IDENTITY_IMAGE} >> /var/log/microservices.log 2>&1

docker run -d \
  --name user \
  -p 8001:8000 \
  ${USER_IMAGE} >> /var/log/microservices.log 2>&1
