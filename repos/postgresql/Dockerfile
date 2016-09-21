FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
RUN \
  apk --update add postgresql postgresql-contrib apg && \
  reset-user postgres:1000 && \

  rm -rf /srv/postgresql /etc/postgresql /etc/postgresql.conf && \
  mkdir -p /srv/postgresql /run/postgresql && \
  chown postgres:postgres  /srv/postgresql && \
  chown postgres:postgres  /run/postgresql && \
  chmod og-rwx /srv/postgresql && \
  cleanup
ADD copy /
CMD ["/usr/local/bin/postgres"]
VOLUME /srv/postgresql
EXPOSE 5432
