FROM envygeeks/ubuntu
MAINTAINER <%= @meta.maintainer %>
RUN \
  apt-get update && \
  apt-get install git ca-certificates \
    --no-install-recommends -y && \
  cd /opt && \

  git clone --single-branch --depth=1 --branch v<%= @meta.tag %> \
    https://github.com/certbot/certbot.git && \
  cd /opt/certbot && yes | ./certbot-auto || true && \
  ln -s /opt/certbot/certbot-auto /usr/local/bin/certbot && \
  docker-helper cleanup
VOLUME /etc/letsencrypt
VOLUME /etc/certbot
