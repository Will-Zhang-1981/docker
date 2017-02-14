FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
ENV PASSWORD=password
ENV USER=user
RUN apk --update add openssh
RUN cleanup
COPY copy /
CMD ["/usr/local/sbin/sshd", "-dD"]
VOLUME /etc/ssh
EXPOSE 22
