FROM envygeeks/ubuntu
MAINTAINER Jordon Bedwell <jordon@envygeeks.io>
ENV RAILS_ENV=production UNICORN_SIDEKIQS=1 DISCOURSE_DB_PORT=5432 DISCOURSE_DB_USER=discourse DISCOURSE_DB_HOST=postgresql DISCOURSE_DB_NAME=discourse DISCOURSE_REDIS_HOST=redis DISCOURSE_REDIS_PORT=6379 UNICORN_ENABLE_OOBGC=0 UNICORN_WORKERS=2
RUN \
  apt-get update && \
  apt-get install --no-install-recommends -y libxml2 libyaml-0-2 imagemagick libreadline6 libjpeg-turbo-progs ghostscript libxslt1.1 gifsicle jhead ruby git && \
  apt-get install --no-install-recommends -y libffi-dev libssl-dev libyaml-dev libreadline6-dev build-essential libxslt1-dev libxml2-dev libpq-dev ruby-dev && \
  gem install bundler --no-document && \

  groupadd -rg 620 discourse && \
  useradd  -u  620 -g 620 -rMd /home/discourse discourse && \
  docker-helper create-dir discourse:discourse /opt/discourse  && \
  docker-helper create-dir discourse:discourse /home/discourse && \

  cd /opt/discourse && \
  git clone --single-branch --branch v1.5.1 \
    https://github.com/discourse/discourse.git . && \

  rm -rf .git && \
  cd /opt/discourse && \
  export FORCE_BUNDLE=true && \
  export BUNDLE_ARGS="-j128 --without=development:test" && \
  docker-helper install-users-gems && \

  echo libxml2     hold | dpkg --set-selections && \
  echo libpq5      hold | dpkg --set-selections && \
  echo libssl1.0.0 hold | dpkg --set-selections && \
  echo imagemagick hold | dpkg --set-selections && \
  echo ghostscript hold | dpkg --set-selections && \
  echo libxslt1.1  hold | dpkg --set-selections && \
  echo git         hold | dpkg --set-selections && \

  docker-helper enable-stdout-logger && \
  docker-helper apt-clean libffi-dev libssl-dev libyaml-dev libreadline6-dev build-essential libxslt1-dev libxml2-dev libpq-dev ruby-dev && \
  docker-helper cleanup && \

  chown -R discourse:discourse /opt/discourse && \
  for f in production.log unicorn.stderr.log unicorn.stdout.log; do \
    ln -sf /opt/discourse/log/$f /etc/stdout.d/$f; \
  done

COPY copy /
VOLUME /opt/discourse/public/assets /opt/discourse/public/javascripts /opt/discourse/public/uploads /opt/discourse/public/images
EXPOSE 3000
