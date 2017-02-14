FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
ENV PASS=password
ENV USER=user
RUN apk --update add openssh linux-pam
RUN cleanup
COPY copy /
CMD ["/usr/local/sbin/sshd", "-D"]
VOLUME /etc/ssh
EXPOSE 22
