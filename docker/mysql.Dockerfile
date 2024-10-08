FROM mysql

CMD ["mysqld", "--sql_mode="]

ENV MYSQL_DATABASE=${DB_DATABASE}
ENV MYSQL_ROOT_PASSWORD=${DB_PASSWORD}
ENV MYSQL_PASSWORD=${DB_PASSWORD}
ENV MYSQL_USER=${DB_USERNAME}
ENV SERVICE_TAGS=dev
ENV SERVICE_NAME=mysql

COPY  ../dev/docker-compose/mysql /docker-entrypoint-initdb.d

EXPOSE 3306