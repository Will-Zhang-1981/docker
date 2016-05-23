FROM envygeeks/alpine:<%= @meta.release %>
MAINTAINER Jordon Bedwell <jordon@envygeeks.io>
RUN \
  apk --update add <%= @meta.packages %> && \
  <% if @meta.tag == "ubuntu" %>usermod -l nginx www-data && groupmod -n nginx www-data && \<% end %>
  sed -ri 's!/var/www/localhost/htdocs!/srv/nginx!' /etc/passwd && \
  sed -ri 's!:Linux User,{3}:!:nginx:!' /etc/passwd && \
  docker-helper reset_users nginx:1000 && \
  docker-helper enable_stdout_logger && \
  ln -sf /var/log/nginx/error.log  /etc/stdout.d/error.log  && \
  ln -sf /var/log/nginx/access.log /etc/stdout.d/access.log && \
  chown -R nginx.nginx /var/lib/nginx && \
  rm -rf /etc/nginx && \
  docker-helper cleanup
COPY copy /
VOLUME /srv/nginx
VOLUME /etc/nginx/site.d
VOLUME /etc/nginx/include.d
VOLUME /etc/nginx/conf.d
EXPOSE 80 443
