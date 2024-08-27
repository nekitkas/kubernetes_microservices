FROM alpine:3.20

RUN apk update && \
    apk add --no-cache \
    postgresql \
    postgresql-contrib \
    su-exec \
    tzdata && \
    mkdir -p /var/lib/pgsql/16/data /run/postgresql && \
    chown -R postgres:postgres /var/lib/pgsql /run/postgresql

ENV PGDATA /var/lib/pgsql/16/data

EXPOSE 5432

COPY ./../Scripts/docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["postgres"]
