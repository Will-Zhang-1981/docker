FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
RUN apk --update add h2o@communityEdge shadow@community
RUN addgroup -S h2o
RUN usermod -g h2o h2o
RUN reset-user h2o:1000
RUN mkdir -p /srv/h2o && chown h2o:h2o /srv/h2o
RUN mkdir -p /run/h2o && chown h2o:h2o /srv/h2o
RUN apk del shadow
RUN cleanup
COPY copy /
VOLUME /srv/h2o
EXPOSE 80
EXPOSE 443
