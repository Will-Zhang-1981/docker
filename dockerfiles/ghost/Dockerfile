FROM envygeeks/alpine
MAINTAINER Jordon Bedwell <jordon@envygeeks.io>
COPY copy /
RUN \
  apk --update add nodejs git sqlite libuv libstdc++ openssl sqlite-dev python \
    build-base openssl-dev zlib-dev libuv-dev linux-headers wget && \
  version=$(git ls-remote --tags https://github.com/tryghost/ghost.git | \
    awk '{ print $2 }' | awk -F/ '{ print $3 }' | grep -E '^([0-9]+\.)+' | \
      tail -n 1) && \

  wget -nv https://ghost.org/zip/ghost-$version.zip -O ghost.zip && \
  mkdir /usr/local/lib/ghost &&  \
  unzip ghost.zip -d \
    /usr/local/lib/ghost > /dev/null && \

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

  # SQLite < 3.1 has trouble on Alpine, we need to force it to update. Once we
  # see the already updated message next time we will remove this so that this
  # no longer needs to happen.

  node -e ' \
    var a = require("/usr/local/lib/ghost/package.json"), fs = require("fs"); \
    if ( "3.1.0" > a.dependencies.sqlite3 ) { \
      a.dependencies.sqlite3 = "3.1.0"; \
      fs.writeFile("/usr/local/lib/ghost/package.json", JSON.stringify( \
        a, null, 2 \
      )); \
    } \
    \
    else { \
      console.log( \
        "It looks like you are already updated." \
      ); \
    } \
  ' && \

  # Ghost is slow to update so we need to check and see if it finally supports
  # NodeJS that Alpine has by default and if it doesn't then we need to use
  # legacy node 0.12.*, the way we detect this discrepency is by telling node
  # that we want strict engines, so that it bails if our engine isn't supported
  # rather than carrying on like it normally would.

  npm config set engine-strict true && \
  npm install --sqlite=/usr --production || { \
    set -e; \
    apk --update del nodejs || \
      true; \
    \
    cdir=$(pwd); \
    mkdir -p /usr/src; \
    sha=b23d64df051c9c969b0c583f802d5d71de342e53067127a5061415be7e12f39d; \
    version=0.12.7; \
    \
    cd /usr/src; \
    wget -nv https://nodejs.org/dist/v0.12.7/node-v$version.tar.gz; \
    if [ "$(sha256sum node-v$version.tar.gz)" = "$sha  node-v$version.tar.gz" ]; then \
      tar xzf node-v$version.tar.gz; \
      cd node-v$version; \
      \
      ./configure --prefix=/usr \
        --without-ssl2 \
        --without-ssl3 \
        --shared-zlib \
    		--shared-libuv \
    		--shared-openssl; \
      make install; \
    else \
      >&2 echo "It looks like we had trouble with downloading Node, bailing."; \
      >&2 echo "Seriously, there was a problem."; \
      exit 1; \
    fi; \
    \
    cd $cdir; \
    rm -rf node_modules; \
    npm install --sqlite=/usr \
      --production; \
  } && \

  npm install pg mysql --save && \
  apk del git sqlite-dev python build-base openssl-dev zlib-dev libuv-dev \
    linux-headers wget && \
  docker-helper cleanup
VOLUME /srv/ghost
