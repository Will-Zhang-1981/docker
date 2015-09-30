FROM envygeeks/alpine
MAINTAINER Jordon Bedwell <jordon@envygeeks.io>
RUN \
  apk --update add nginx-lua lua-socket && \
  sed -ri 's!/var/www/localhost/htdocs!/srv/nginx!' /etc/passwd && \
  sed -ri 's!:Linux User,{3}:!:nginx:!' /etc/passwd && \
  docker-helper reset_users nginx:612 && \
  docker-helper enable_stdout_logger && \
  ln -sf /var/log/nginx/error.log  /etc/stdout.d/error.log  && \
  ln -sf /var/log/nginx/access.log /etc/stdout.d/access.log && \
  rm -rf /etc/nginx && \
  docker-helper cleanup
COPY copy /
VOLUME /srv/nginx /etc/nginx/http /var/ssl
EXPOSE 80 443
