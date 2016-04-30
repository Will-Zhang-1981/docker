FROM envygeeks/ubuntu
MAINTAINER Jordon Bedwell <jordon@envygeeks.io>
ENV PG_HOSTNAME=postgresql PG_USERNAME=dovefix PG_DATABASE=dovefix
RUN \
  apt-get update && \
  apt-get install --no-install-recommends -y <%= @meta.packages %> && \
  docker-helper reset-users postfix:603 postdrop:604 dovecot:605 \
    dovenull:606 opendkim:607 postgrey:619 && \

  groupadd -g 610 vmail && \
  useradd  -g 610 -ru 610 \
    -d /var/mail vmail && \

  rm -rf /etc/dovecot/* && \
  rm -rf /etc/postfix/* && \

  docker-helper enable-stdout-logger && \
  docker-helper create-log syslog:syslog mail.log && \
  docker-helper create-log syslog:syslog mail.err && \
  docker-helper create-log syslog:syslog syslog && \
  ln -s /var/log/syslog /etc/stdout.d/syslog && \
  ln -s /var/log/mail.log /etc/stdout.d/mail.log && \
  ln -s /var/log/mail.err /etc/stdout.d/mail.err && \
  mv /etc/rsyslog.d/postfix.conf \
     /etc/rsyslog.d/99-postfix.conf && \

  docker-helper create-dir opendkim:postfix /var/spool/postfix/opendkim && \
  docker-helper create-dir postgrey:postfix /var/spool/postfix/postgrey && \
  docker-helper create-dir opendkim:opendkim /var/opendkim && \
  docker-helper create-dir vmail:vmail /var/sieve && \
  docker-helper cleanup

ADD copy /
EXPOSE 143 993 25 587
VOLUME /var/mail /var/ssl
