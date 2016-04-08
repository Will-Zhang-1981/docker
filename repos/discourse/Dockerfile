FROM envygeeks/ubuntu
MAINTAINER Jordon Bedwell <jordon@envygeeks.io>
ENV <%= @metadata.env %>
RUN \
  apt-get update && \
  apt-get install --no-install-recommends -y <%= @metadata.packages %> && \
  apt-get install --no-install-recommends -y <%= @metadata.development_packages %> && \
  gem install bundler --no-document && \

  groupadd -rg 620 discourse && \
  useradd  -u  620 -g 620 -rMd /home/discourse discourse && \
  docker-helper create-dir discourse:discourse /opt/discourse  && \
  docker-helper create-dir discourse:discourse /home/discourse && \

  cd /opt/discourse && \
  git clone --single-branch --branch v<%= @metadata.version %> \
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
  docker-helper apt-clean <%= @metadata.development_packages %> && \
  docker-helper cleanup && \

  chown -R discourse:discourse /opt/discourse && \
  for f in production.log unicorn.stderr.log unicorn.stdout.log; do \
    ln -sf /opt/discourse/log/$f /etc/stdout.d/$f; \
  done

COPY copy /
VOLUME <%= @metadata.volumes %>
EXPOSE 3000