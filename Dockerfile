FROM postgres:16



ENV APP_VERSION=0.0.2


RUN apt update -y
RUN apt install python3 python3-pip postgresql-plpython3-16 wget vim git iputils-ping htop screen postgresql-16-cron -y 


RUN pip3 install --upgrade --break-system-packages pip


COPY ./requirements.txt /code/requirements.txt
RUN pip3 install --no-cache-dir --upgrade --break-system-packages -r /code/requirements.txt


RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./pginit/* /docker-entrypoint-initdb.d/
RUN chmod 777 /usr/local/bin/docker-entrypoint.sh



RUN mkdir -p /pg
RUN mkdir /pg/pylib
RUN mkdir /pg/data
RUN chown -R postgres:postgres /pg
RUN chmod 777 -R /pg 


ENV POSTGRES_DB=$POSTGRES_DB
ENV POSTGRES_USER=$POSTGRES_USER
ENV POSTGRES_PASSWORD=$POSTGRES_PASSWORD

ENV PYTHONPATH=/pg/pylib


USER postgres

