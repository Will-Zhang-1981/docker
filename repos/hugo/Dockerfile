FROM envygeeks/alpine
MAINTAINER <%= @meta.maintainer %>
RUN apk --update add curl ca-certificates
RUN  mkdir -p /usr/src
WORKDIR /usr/src

RUN addgroup -Sg 1000 hugo
RUN adduser -HSG hugo -u 1000 hugo
RUN  curl -L -o hugo.tar.gz https://github.com/spf13/hugo/releases/download/v<%= @meta.tag %>/hugo_<%=
  @meta.tag %>_linux-64bit.tgz

RUN  tar xzvf hugo.tar.gz && mv hugo /usr/local/bin

RUN  mkdir -p /srv/hugo
RUN chown -R hugo.hugo /srv/hugo
RUN  rm -rf ./*

WORKDIR /
RUN sudo -HEu hugo hugo new site /srv/hugo
RUN apk del curl ca-certificates
RUN  cleanup
WORKDIR /srv/hugo
VOLUME  /srv/hugo
