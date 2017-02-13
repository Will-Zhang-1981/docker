FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
ENV ENABLE_SSL=false
RUN apk --update add vsftpd
RUN reset-user ftp:1000:1000
RUN mkdir -p /home/ftp
RUN chown -R ftp:ftp /home/ftp
COPY copy /
CMD ["/usr/local/bin/vsftpd"]
EXPOSE 990
EXPOSE 22