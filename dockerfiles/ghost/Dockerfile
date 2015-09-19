FROM envygeeks/alpine
MAINTAINER Jordon Bedwell <jordon@envygeeks.io>
ADD node-v0.12.7.muslc.tar.gz /
COPY copy /
RUN \
  apk --update add git sqlite libuv libstdc++ openssl sqlite-dev python \
    build-base openssl-dev zlib-dev libuv-dev linux-headers wget && \
  version=$(git ls-remote --tags https://github.com/tryghost/ghost.git | \
    awk '{ print $2 }' | awk -F/ '{ print $3 }' | grep -E '^([0-9]+\.)+' | \
      tail -n 1) && \

  wget -nv https://ghost.org/zip/ghost-$version.zip -O ghost.zip && \
  mkdir /usr/local/lib/ghost &&  \
  unzip ghost.zip -d \
    /usr/local/lib/ghost && \

  addgroup -Sg 634 ghost && \
  adduser  -SG ghost -u 634 -h /home/ghost ghost && \
  docker-helper create_dir ghost:ghost /home/ghost && \
  docker-helper create_dir ghost:ghost  /srv/ghost && \

  cd /usr/local/lib/ghost && \
  cp /usr/local/share/ghost/config.js config.js && \
  rm -rf config.example.js npm-shrinkwrap.json && \
  mv LICENSE /usr/local/share/ghost/COPY && \
  mv PRIVACY.md /usr/local/share/ghost/PRIVACY && \
  mv content/* /srv/ghost && \
  rm -rf content/ && \

  rm -rf /srv/ghost/*/README.md && \
  chown -R ghost:ghost /srv/ghost && \

  /usr/local/share/ghost/alpinify && npm install --sqlite=/usr --production && \
  npm install pg mysql --save && \

  apk del git sqlite-dev python build-base openssl-dev zlib-dev libuv-dev linux-headers && \
  docker-helper cleanup
VOLUME /srv/ghost
