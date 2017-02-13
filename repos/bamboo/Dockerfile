FROM envygeeks/alpine
COPY copy /
ENV SCHEME=""
ENV HOSTNAME=""
ENV PORT=""

RUN apk --update add openjdk8-jre@community ca-certificates curl tar xmlstarlet@community \
    docker@community go@community ruby ruby-dev build-base ruby-rdoc ruby-bigdecimal cmake ruby-json \
    ruby-io-console ruby-rake ruby-irb nodejs git shadow@community openssh python2 python2-dev \
    docker@community py-pip ttf-dejavu

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

RUN curl -Ls https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-<%= @meta.tag %>.tar.gz \
  | tar -xvz --directory /opt/bamboo --strip-components=1 \
    --no-same-owner


RUN rm -rf /usr/src/docker-template
RUN curl -Ls https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.tar.gz | tar \
    -xvz --directory /opt/bamboo/lib --no-same-owner --strip-components=1 \
    mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar

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
