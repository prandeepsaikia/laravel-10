FROM nginx:alpine AS nginx
COPY ../ /var/www
COPY ../dev/docker-compose/nginx /etc/nginx/conf.d/