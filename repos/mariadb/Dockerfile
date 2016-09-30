FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
RUN \
  apk --update add mariadb mariadb-client apg && \
  reset-user mysql:1000 && \

  rm -rf /srv/mysql /etc/mysql /etc/my.cnf && \
  mkdir -p /srv/mysql /run/mysqld && \
  chown mysql:mysql /srv/mysql && \
  chown mysql:mysql /run/mysqld && \
  chmod og-rwx /srv/mysql && \
  cleanup
ADD copy /
CMD ["/usr/local/bin/mysqld"]
VOLUME /srv/mysql
EXPOSE 3306
