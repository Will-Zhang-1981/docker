FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
COPY copy /
RUN \
  apk --update add minidlna && \
  docker-helper reset-users minidlna:1000 && \
  docker-helper enable_stdout_logger && \
  mkdir -p /srv/minidlna /run/minidlna && \
  docker-helper create_log minidlna:minidlna minidlna.log && \
  ln -s /var/log/minidlna.log /etc/stdout.d/minidlna.log && \
  chown minidlna:minidlna /srv/minidlna /run/minidlna && \
  docker-helper cleanup
VOLUME /srv/minidlna
EXPOSE 1900/udp 8200
