FROM <%= @meta.distro %>
MAINTAINER <%= @meta.maintainer %>
RUN \
  apk --update add nodejs && \
  npm install -g netlify-cli@~<%=
    @meta.tag
  %>
