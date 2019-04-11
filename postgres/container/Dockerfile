FROM postgres:9.6

VOLUME /etc/postgresql
VOLUME /var/lib/postgresql/data
VOLUME /var/log/postgresql
VOLUME /home/postgres

RUN apt-get update && apt-get install -y vim


COPY entrypoint.sh /entrypoint.sh

USER "postgres"
WORKDIR /home/postgres

ENTRYPOINT ["/entrypoint.sh"]
