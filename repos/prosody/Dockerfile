FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
RUN \
  apk --update add prosody@community lua-sec lua libevent lua-lzlib && \
  mkdir -p /var/log/prosody && \
  mkdir -p /run/prosody && \

  touch /var/log/prosody/prosody.err && \
  touch /var/log/prosody/prosody.log && \

  chown -R prosody:prosody /var/log/prosody && \
  chown -R prosody:prosody /run/prosody && \
  reset-user prosody:1000 && \

  rm -rf /etc/prosody/conf.d \
    /etc/prosody/conf.avail/localhost.cf.lua && \
  cleanup
COPY copy /
VOLUME /var/lib/prosody
CMD ["/usr/local/bin/prosody"]
EXPOSE 5222 5269
