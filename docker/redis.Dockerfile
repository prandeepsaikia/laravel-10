FROM redis:alpine

WORKDIR /redis

COPY ./dev/docker-compose/redis/init.sh /redis/init.sh

RUN chmod +x /redis/init.sh

USER root
CMD ["sh", "-c", "/redis/init.sh"]

COPY ../dev/docker-compose/redis/redis.conf /usr/local/etc/redis/redis.conf

EXPOSE 6379