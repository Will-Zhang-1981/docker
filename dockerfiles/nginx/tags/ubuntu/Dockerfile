FROM envygeeks/ubuntu:lts
MAINTAINER Jordon Bedwell <jordon@envygeeks.io>
RUN \
  apt-get update && apt-get install --no-install-recommends -y nginx-extras lua-socket && \
  
    usermod  -l nginx www-data && \
    groupmod -n nginx www-data && \
  
  sed -ri 's!/var/www/localhost/htdocs!/srv/nginx!' /etc/passwd && \
  sed -ri 's!:Linux User,{3}:!:nginx:!' /etc/passwd && \
  docker-helper reset_users nginx:612 && \
  docker-helper enable_stdout_logger && \
  ln -sf /var/log/nginx/error.log  /etc/stdout.d/error.log  && \
  ln -sf /var/log/nginx/access.log /etc/stdout.d/access.log && \
  rm -rf /etc/nginx && \
  docker-helper cleanup
COPY copy /
EXPOSE 80 443
