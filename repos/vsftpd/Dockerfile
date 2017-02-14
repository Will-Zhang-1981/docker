FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
ENV FORCE_SSL=false
ENV DOMAIN=example.com
ENV ENABLE_SSL=false
ENV PASS=password
ENV USER=user

RUN touch /var/log/vsftpd.log
RUN reset-user ftp:1000:1000
RUN apk --update add vsftpd \
  openssl linux-pam

COPY copy /
CMD ["/usr/local/bin/vsftpd"]
EXPOSE 21