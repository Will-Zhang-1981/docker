FROM envygeeks/alpine
MAINTAINER Jordon Bedwell <jordon@envygeeks.io>
RUN \
  apk --update add redis && \
  rm -rf /etc/redis /etc/redis.conf \
    /srv/redis && \

  docker-helper reset_users redis:615 && \
  docker-helper create_dir redis:redis /srv/redis && \
  docker-helper cleanup && \

  docker-helper enable_stdout_logger && \
  ln -sf /var/log/redis.log /etc/stdout.d/redis.log && \
  docker-helper create_log redis:redis redis.log
COPY copy /
VOLUME /srv/redis
EXPOSE 6379
