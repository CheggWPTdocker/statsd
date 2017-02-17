FROM cheggwpt/alpine:3.5

ENV DEBUG 1
ENV librato_version 2.0.2
ENV nodejs_version 6.9.2-r1
ENV statsd_version master

WORKDIR /statsd

RUN apk --update --no-cache add git nodejs=${nodejs_version} && \
  git clone --depth 1 --branch ${statsd_version} https://github.com/etsy/statsd.git . && \
  npm install --no-optional && \
  npm install statsd-librato-backend@${librato_version} && \
  apk del git && \
  rm -rf /var/cache/apk

EXPOSE 8125/udp
EXPOSE 8126

ENTRYPOINT ["node", "node_modules/.bin/statsd-librato", "config.js"]
