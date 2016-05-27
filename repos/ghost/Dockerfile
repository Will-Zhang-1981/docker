FROM envygeeks/alpine:3.3
MAINTAINER <%= @meta.maintainer %>
RUN \
  apk --update add nodejs sqlite openssl libuv git sqlite-dev build-base \
    linux-headers openssl-dev libuv-dev zlib-dev python wget && \

  mkdir -p /opt/ghost &&  \
  mkdir -p /usr/src && cd /usr/src && \
  wget -nv https://ghost.org/zip/ghost-<%= @meta.release %>.zip -O ghost.zip && \
  unzip ghost.zip -d /opt/ghost && \
  rm -rf /usr/src/ghost.zip && \

  docker-helper add-user-1000 ghost && \
  docker-helper create_dir ghost:ghost /srv/ghost && \
  cp -R /opt/ghost/content/* /srv/ghost && \
  rm -rf /opt/ghost/content && \
  chown -R ghost:ghost \
    /opt/ghost && \

  cd /opt/ghost && \
  npm install --sqlite=/usr --production && \
  npm install pg mysql --production --save && \
  apk del sqlite-dev build-base linux-headers openssl-dev \
    libuv-dev zlib-dev python wget && \
  docker-helper cleanup
COPY copy /
VOLUME /srv/ghost
EXPOSE 4000
