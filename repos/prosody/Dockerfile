FROM envygeeks/alpine
MAINTAINER Jordon Bedwell <jordon@envygeeks.io>
RUN \
  apk --update add prosody@testing lua-zlib@testing lua-event@testing lua-sec lua && \
  docker-helper reset_user prosody:1000 && \
  docker-helper create_dir prosody:prosody /run/prosody && \
  docker-helper enable_stdout_logger && \

  docker-helper create_log prosody:prosody  prosody/prosody.err && \
  docker-helper create_log prosody:prosody  prosody/prosody.log && \
  ln -sf /var/log/prosody/prosody.err /etc/stdout.d/prosody.err && \
  ln -sf /var/log/prosody/prosody.log /etc/stdout.d/prosody.log && \
  rm -rf /etc/prosody/conf.d \
    /etc/prosody/conf.avail/localhost.cf.lua

COPY copy /
EXPOSE 5222 5269
VOLUME /var/lib/prosody
