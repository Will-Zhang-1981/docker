FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
ENV FORCE_SSL=false
ENV DOMAIN=example.com
ENV ENABLE_SSL=false
ENV PASSWORD=password
ENV USER=user

RUN reset-user ftp:1000:1000
RUN apk --update add vsftpd \
  openssl

COPY copy /
CMD ["/usr/local/bin/vsftpd"]
EXPOSE 990
EXPOSE 22