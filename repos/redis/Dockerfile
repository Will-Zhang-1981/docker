FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
RUN \
  apk --update add redis && \
  rm -rf /etc/redis /etc/redis.conf \
    /srv/redis && \

  reset-user redis:1000 && \
  mkdir -p /srv/redis && chown -R redis:redis \
    /srv/redis && \
  cleanup
#
COPY copy /
CMD ["/usr/local/bin/redis-server", "/etc/redis/redis.conf"]
VOLUME /srv/redis
EXPOSE 6379
