FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
RUN \
  apk --update add shadow@community h2o@community && \

  addgroup -S h2o && \
  usermod -g h2o h2o && \
  reset-user h2o:1000 && \
  mkdir -p /srv/h2o && chown h2o:h2o /srv/h2o && \
  mkdir -p /run/h2o && chown h2o:h2o /srv/h2o && \
  apk del shadow && \
  cleanup
COPY copy /
VOLUME /srv/h2o
EXPOSE 80
EXPOSE 443
