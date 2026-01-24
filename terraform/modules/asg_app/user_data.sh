#!/bin/bash
# 1. Preparar el servidor
yum update -y
yum install -y docker
systemctl start docker
systemctl enable docker
usermod -a -G docker ec2-user

# Crear archivo de logs
LOGFILE="/var/log/uniforum.log"
echo "🚀 INICIANDO DESPLIEGUE UNIFORUM..." > $LOGFILE

# 2. Crear red privada para los contenedores
docker network create uniforum-net

# 3. Bases de Datos (Postgres, Mongo, Redis)
echo "--- Desplegando Bases de Datos ---" >> $LOGFILE

docker run -d --restart always \
  --name postgres \
  --network uniforum-net \
  -e POSTGRES_DB=uniforum \
  -e POSTGRES_USER=uniforum \
  -e POSTGRES_PASSWORD=uniforum \
  postgres:15-alpine >> $LOGFILE 2>&1

docker run -d --restart always \
  --name mongo \
  --network uniforum-net \
  mongo:6.0 >> $LOGFILE 2>&1

docker run -d --restart always \
  --name redis \
  --network uniforum-net \
  redis:7-alpine >> $LOGFILE 2>&1

# Esperar 15 segundos para que las BDs inicien
sleep 15

# 4. Tus 10 Microservicios
# Nota: Terraform reemplazará las variables ${IDENTITY}, etc. con tus imágenes
echo "--- Desplegando Microservicios ---" >> $LOGFILE

docker run -d --restart always --name identity --network uniforum-net \
  -e DB_HOST=postgres -e DB_NAME=uniforum -e DB_USER=uniforum -e DB_PASSWORD=uniforum -e JWT_SECRET=uniforum-secret \
  ${IDENTITY} >> $LOGFILE 2>&1

docker run -d --restart always --name user --network uniforum-net \
  -e DB_HOST=postgres -e DB_NAME=uniforum -e DB_USER=uniforum -e DB_PASSWORD=uniforum -e JWT_SECRET=uniforum-secret \
  ${USER} >> $LOGFILE 2>&1

docker run -d --restart always --name forum --network uniforum-net \
  -e DB_HOST=postgres -e DB_NAME=uniforum -e DB_USER=uniforum -e DB_PASSWORD=uniforum -e JWT_SECRET=uniforum-secret \
  ${FORUM} >> $LOGFILE 2>&1

docker run -d --restart always --name post --network uniforum-net \
  -e MONGO_URL=mongodb://mongo:27017 -e JWT_SECRET=uniforum-secret \
  ${POST} >> $LOGFILE 2>&1

docker run -d --restart always --name reply --network uniforum-net \
  -e MONGO_URL=mongodb://mongo:27017 -e JWT_SECRET=uniforum-secret \
  ${REPLY} >> $LOGFILE 2>&1

docker run -d --restart always --name academic --network uniforum-net \
  -e DB_HOST=postgres -e DB_NAME=uniforum -e DB_USER=uniforum -e DB_PASSWORD=uniforum \
  ${ACADEMIC} >> $LOGFILE 2>&1

docker run -d --restart always --name reaction --network uniforum-net \
  -e REDIS_HOST=redis -e REDIS_PORT=6379 \
  ${REACTION} >> $LOGFILE 2>&1

docker run -d --restart always --name search --network uniforum-net \
  -e REDIS_HOST=redis -e REDIS_PORT=6379 \
  ${SEARCH} >> $LOGFILE 2>&1

docker run -d --restart always --name notification --network uniforum-net \
  -e REDIS_HOST=redis -e REDIS_PORT=6379 \
  ${NOTIFICATION} >> $LOGFILE 2>&1

docker run -d --restart always --name moderation --network uniforum-net \
  -e DB_HOST=postgres -e DB_NAME=uniforum -e DB_USER=uniforum -e DB_PASSWORD=uniforum \
  ${MODERATION} >> $LOGFILE 2>&1

# 5. API GATEWAY (NGINX) - EL ENRUTADOR
# Esto recibe el tráfico del puerto 80 y lo manda al microservicio correcto
echo "--- Configurando Nginx Gateway ---" >> $LOGFILE

cat <<EOF > /home/ec2-user/nginx.conf
events {}
http {
    server {
        listen 80;
        
        # Rutas a tus microservicios
        # El nombre "http://identity" funciona porque están en la misma red Docker
        location /identity/ { proxy_pass http://identity:8000/; }
        location /user/     { proxy_pass http://user:8000/; }
        location /forum/    { proxy_pass http://forum:8000/; }
        location /post/     { proxy_pass http://post:8000/; }
        location /reply/    { proxy_pass http://reply:8000/; }
        location /academic/ { proxy_pass http://academic:8000/; }
        location /reaction/ { proxy_pass http://reaction:8000/; }
        location /search/   { proxy_pass http://search:8000/; }
        location /notif/    { proxy_pass http://notification:8000/; }
        location /mod/      { proxy_pass http://moderation:8000/; }

        # Healthcheck para el Load Balancer
        location / { return 200 'OK - Uniforum Running'; }
    }
}
EOF

# Iniciar Nginx
docker run -d --restart always \
  --name api-gateway \
  --network uniforum-net \
  -p 80:80 \
  -v /home/ec2-user/nginx.conf:/etc/nginx/nginx.conf \
  nginx:alpine >> $LOGFILE 2>&1

echo "✅ DESPLIEGUE COMPLETADO EXITOSAMENTE" >> $LOGFILE