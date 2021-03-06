FROM envygeeks/alpine
COPY copy /
ENV SCHEME=""
ENV HOSTNAME=""
ENV PORT=""

RUN apk update
RUN apk add openjdk8-jre@community ca-certificates curl tar xmlstarlet@community \
    docker@community go@community ruby ruby-dev build-base ruby-rdoc ruby-bigdecimal cmake ruby-json \
    ruby-io-console ruby-rake ruby-irb nodejs git shadow@community openssh python2 python2-dev \
    docker@community py-pip ttf-dejavu util-linux go-tools@community go-doc@community

RUN gem install docker-template bundler --no-ri --no-rdoc
RUN npm install -g yarn gulp grunt webpack typescript uglify-js
RUN pip install awscli

RUN addgroup -Sg 1000 bamboo
RUN adduser -HSG bamboo -u 1000 bamboo
RUN groupdel docker

RUN groupmod -n docker ping
RUN usermod -aG docker bamboo
RUN mkdir -p /opt/bamboo
RUN mkdir -p /var/bamboo

RUN echo 'bamboo ALL=NOPASSWD:ALL' >> /etc/sudoers
RUN curl -L "https://github.com/docker/compose/releases/download/<%=
  @meta.compose_version %>docker-compose-Linux-x86_64" \
    -o /usr/local/bin/docker-compose && chmod uog+rx /usr/local/bin/docker-compose

RUN curl -Ls https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-<%= @meta.tag %>.tar.gz \
  | tar -xvz --directory /opt/bamboo --strip-components=1  --no-same-owner

RUN rm -rf /usr/src/docker-template
RUN curl -Ls https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.tar.gz | tar \
    -xvz --directory /opt/bamboo/lib --no-same-owner --strip-components=1 \
    mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar

RUN GOPATH=$HOME/go go get github.com/golang/example/hello
RUN rm -rf $HOME/go

RUN printf "\nbamboo.home=/var/bamboo" >> "/opt/bamboo/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties"
RUN chown -R bamboo:bamboo /opt/bamboo
RUN chown -R bamboo:bamboo /var/bamboo
RUN apk del tar shadow
RUN cleanup

VOLUME /opt/bamboo/logs
CMD ["/usr/local/bin/bamboo"]
VOLUME /tmp/docker-template
VOLUME /var/bamboo
EXPOSE 8085
