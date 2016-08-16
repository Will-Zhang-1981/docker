FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
RUN \
  apk --update add openssh && \
  docker-helper reset_users sshd:1000 && \
  docker-helper enable_stdout_logger && \
  docker-helper cleanup
COPY copy /
EXPOSE 22
