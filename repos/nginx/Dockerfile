FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
RUN \
  apk --update add nginx-lua lua5.1-socket lua-socket gettext && \
  sed -ri 's!/var/www/localhost/htdocs!/srv/nginx!' /etc/passwd && \
  sed -ri 's!:Linux User,{3}:!:nginx:!' /etc/passwd && \
  reset-user nginx:1000 && \

  mkdir -p /var/lib/nginx/cache && \
  chown -R nginx.nginx /var/lib/nginx && \
  rm -rf /etc/nginx && \
  cleanup
COPY copy /
VOLUME /srv/nginx
VOLUME /etc/nginx/site.d
VOLUME /etc/nginx/include.d
VOLUME /etc/nginx/conf.d
CMD ["/usr/local/bin/nginx"]
EXPOSE 443
EXPOSE 80
