FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
COPY copy /
RUN apk --update add minidlna
RUN reset-user minidlna:1000
RUN  mkdir -p /srv/minidlna /run/minidlna
RUN  chown minidlna:minidlna /srv/minidlna /run/minidlna
RUN  cleanup
VOLUME /srv/minidlna
EXPOSE 1900/udp 8200
