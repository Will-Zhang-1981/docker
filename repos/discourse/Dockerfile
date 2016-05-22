FROM envygeeks/ubuntu
MAINTAINER Jordon Bedwell <jordon@envygeeks.io>
ENV <%= @meta.env %>
RUN \
  apt-get update && \
  apt-get install --no-install-recommends -y <%= @meta.packages %> && \
  apt-get install --no-install-recommends -y <%= @meta.development_packages %> && \
  npm install -g <%= @meta.nodejs_packages %> && \
  gem install bundler --no-document && \

  groupadd -rg 1000 discourse && \
  useradd  -u  1000 -g 1000 -rMd /home/discourse discourse && \
  docker-helper create-dir discourse:discourse /opt/discourse  && \
  docker-helper create-dir discourse:discourse /home/discourse && \

  cd /opt/discourse && \
  git clone --single-branch --branch v<%= @meta.version %> \
    https://github.com/discourse/discourse.git . && \

  cd /opt/discourse && \
  export FORCE_BUNDLE=true && \
  mkdir -p /usr/share/ruby && \
  echo "<%= @meta.gems %>" > /usr/share/ruby/default-gems && \
  export BUNDLE_ARGS="-j 128 --without=development:test" && \
  docker-helper install-users-gems && \

  <% @meta["keeps"].to_a.each do |keep| %>
    echo <%= keep %> hold | dpkg --set-selections && \
  <% end %>

  docker-helper enable-stdout-logger && \
  docker-helper apt-clean <%= @meta.development_packages %> && \
  docker-helper cleanup && \

  ln -sf /opt/discourse/log/unicorn.stderr.log /etc/stdout.d/unicorn.stderr.log && \
  ln -sf /opt/discourse/log/unicorn.stdout.log /etc/stdout.d/unicorn.stdout.log && \
  chown -R discourse:discourse /opt/discourse

COPY copy /
VOLUME <%= @meta.volumes %>
EXPOSE 3000
