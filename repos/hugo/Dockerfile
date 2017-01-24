FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
RUN \
  apk --update add curl ca-certificates && \
  mkdir -p /usr/src && cd /usr/src && \
  docker-helper add-user-1000 hugo && \
  curl -L -o hugo.tar.gz https://github.com/spf13/hugo/releases/download/v<%= \
    @meta.tag %>/hugo_<%= @meta.tag %>_linux-64bit.tgz && \
  tar xzvf hugo.tar.gz && mv hugo /usr/local/bin && \
  docker-helper create-dir hugo:hugo /srv/hugo && \
  rm -rf ./* && cd - && chpst -u hugo:hugo \
    hugo new site /srv/hugo && \

  apk del curl ca-certificates && \
  cleanup
WORKDIR /srv/hugo
VOLUME  /srv/hugo
