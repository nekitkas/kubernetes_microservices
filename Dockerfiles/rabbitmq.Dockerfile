FROM alpine:3.20

RUN apk add --no-cache rabbitmq-server \
    bash

EXPOSE 5672 15672

COPY ./../Scripts/rabbit-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/rabbit-entrypoint.sh

ENTRYPOINT ["rabbit-entrypoint.sh"]

CMD ["rabbitmq-server"]
