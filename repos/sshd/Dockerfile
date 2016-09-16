FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
RUN \
  apk --update add openssh && \
  cleanup
#
COPY copy /
CMD ["/usr/local/sbin/sshd", "-dD"]
VOLUME /etc/ssh
EXPOSE 22
