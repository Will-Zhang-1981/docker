FROM envygeeks/alpine:3.3
MAINTAINER <%= @meta.maintainer %>
RUN apk --update add nodejs sqlite openssl libuv git sqlite-dev build-base \
  linux-headers openssl-dev libuv-dev zlib-dev python wget

RUN mkdir -p /usr/src
RUN mkdir -p /opt/ghost
WORKDIR cd /usr/src

RUN wget -nv https://github.com/TryGhost/Ghost/releases/download/<%= @meta.release %>/Ghost-<%= \
  @meta.release %>.zip -O ghost.zip

RUN unzip ghost.zip -d /opt/ghost
RUN rm -rf /usr/src/ghost.zip

RUN addgroup -Sg 1000 ghost
RUN adduser -SHg 1000 ghost
RUN mkdir -p /srv/ghost && chown ghost:ghost /srv/ghost
RUN cp -R /opt/ghost/content/* /srv/ghost
RUN rm -rf /opt/ghost/content
RUN chown -R ghost:ghost \
  /opt/ghost

WORKDIR /opt/ghost
RUN npm install -g yarn
RUN yarn --sqlite=/usr --production
RUN yarn add pg mysql --production --save
RUN apk del sqlite-dev build-base linux-headers openssl-dev \
  libuv-dev zlib-dev python wget

RUN cleanup
COPY copy /
VOLUME /srv/ghost
EXPOSE 4000
