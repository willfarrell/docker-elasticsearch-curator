FROM alpine:3.4

ENV CURATOR_VERSION 5.1.1

RUN apk --update add python py-setuptools py-pip && \
  pip install elasticsearch-curator==$CURATOR_VERSION && \
  apk del py-pip && \
  rm -rf /var/cache/apk/*

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

COPY actions.yml /opt/.curator/
COPY curator.yml /opt/.curator/

CMD [ "curator", "--config", "/opt/.curator/curator.yml", "/opt/.curator/actions.yml" ]