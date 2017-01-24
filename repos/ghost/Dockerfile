FROM envygeeks/alpine:3.3
MAINTAINER <%= @meta.maintainer %>
RUN \
  apk --update add nodejs sqlite openssl libuv git sqlite-dev build-base \
    linux-headers openssl-dev libuv-dev zlib-dev python wget && \

  mkdir -p /opt/ghost &&  \
  mkdir -p /usr/src && cd /usr/src && \
  wget -nv https://github.com/TryGhost/Ghost/releases/download/<%= @meta.release %>/Ghost-<%= \
    @meta.release %>.zip -O ghost.zip && \
  unzip ghost.zip -d /opt/ghost && \
  rm -rf /usr/src/ghost.zip && \

  addgroup -Sg 1000 ghost && \
  adduser -SHg 1000 ghost && \
  mkdir -p /srv/ghost && chown ghost:ghost /srv/ghost && \
  cp -R /opt/ghost/content/* /srv/ghost && \
  rm -rf /opt/ghost/content && \
  chown -R ghost:ghost \
    /opt/ghost && \

  cd /opt/ghost && \
  npm install -g yarn && \
  yarn --sqlite=/usr --production && \
  yarn add pg mysql --production --save && \
  apk del sqlite-dev build-base linux-headers openssl-dev \
    libuv-dev zlib-dev python wget && \
  cleanup
COPY copy /
VOLUME /srv/ghost
EXPOSE 4000
