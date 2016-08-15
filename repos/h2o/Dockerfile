FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
RUN \
  apk --update add shadow@testing h2o@community && \

  addgroup -S h2o && \
  usermod -g h2o h2o && \
  docker-helper reset_users h2o:1000 && \
  docker-helper create_dir h2o:h2o /srv/h2o && \
  docker-helper create_dir h2o:h2o /run/h2o && \

  docker-helper enable_stdout_logger && \
  ln -sf /var/log/h2o/access.log /etc/stdout.d/h2o_access.log && \
  ln -sf /var/log/h2o/error.log /etc/stdout.d/h2o_error.log && \
  apk del shadow && \
  docker-helper cleanup
COPY copy /
VOLUME /srv/h2o
EXPOSE 80
EXPOSE 443
