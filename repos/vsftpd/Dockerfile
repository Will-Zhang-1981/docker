FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
ENV FORCE_SSL=false
ENV ENABLE_SSL=false
ENV DOMAIN=example.com
ENV PUBLIC_IP=dynamic
ENV MIN_PORT=10000
ENV MAX_PORT=10012
ENV PASS=password
ENV USER=user

RUN touch /var/log/vsftpd.log
RUN reset-user ftp:1000:1000
RUN apk --update add vsftpd bind-tools \
  openssl linux-pam

COPY copy /
CMD ["/usr/local/bin/vsftpd"]
EXPOSE 21