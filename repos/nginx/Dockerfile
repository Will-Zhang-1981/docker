FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
RUN apk --update add nginx-lua lua5.1-socket lua-socket gettext
RUN sed -ri 's!/var/www/localhost/htdocs!/srv/nginx!' /etc/passwd
RUN sed -ri 's!:Linux User,{3}:!:nginx:!' /etc/passwd
RUN reset-user nginx:1000
RUN mkdir -p /var/lib/nginx/cache
RUN chown -R nginx.nginx /var/lib/nginx
RUN rm -rf /etc/nginx
RUN cleanup
COPY copy /
VOLUME /srv/nginx
VOLUME /etc/nginx/site.d
VOLUME /etc/nginx/include.d
VOLUME /etc/nginx/conf.d
CMD ["/usr/sbin/nginx"]
EXPOSE 443
EXPOSE 80
