FROM envygeeks/alpine
MAINTAINER Jordon Bedwell <jordon@envygeeks.io>
RUN \
  apk --update add nodejs git sqlite libuv libstdc++ openssl sqlite-dev python \
    build-base openssl-dev zlib-dev libuv-dev linux-headers wget git && \

  mkdir -p /usr/src && cd /usr/src && \
  wget -nv https://ghost.org/zip/ghost-<%= @metadata.version %>.zip -O ghost.zip && \
  mkdir /usr/local/lib/ghost &&  \
  unzip ghost.zip -d /usr/local/lib/ghost && \

  addgroup -Sg 634 ghost && \
  adduser  -SG ghost -u 634 -h /home/ghost ghost && \
  docker-helper create_dir ghost:ghost /home/ghost && \
  docker-helper create_dir ghost:ghost  /srv/ghost && \

  cd /usr/local/lib/ghost && \
  mkdir -p /usr/local/share/ghost && \
  rm -rf config.example.js npm-shrinkwrap.json && \
  mv LICENSE /usr/local/share/ghost/COPY && \
  mv PRIVACY.md /usr/local/share/ghost/PRIVACY && \
  mv content/* /srv/ghost && \
  rm -rf README.md content/ \
    Gruntfile.js && \

  rm -rf /srv/ghost/*/README.md && \
  chown -R ghost:ghost /srv/ghost && \
  npm install --sqlite=/usr --production && \
  npm install pg mysql --save && \
  apk del git sqlite-dev python build-base openssl-dev zlib-dev libuv-dev \
    linux-headers wget && \
  rm -rf .git && docker-helper cleanup
COPY copy /
VOLUME /srv/ghost
EXPOSE 4000
