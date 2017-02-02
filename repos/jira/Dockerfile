FROM envygeeks/alpine
COPY copy /
RUN \
  apk --update add openjdk8-jre@community ca-certificates curl tar xmlstarlet@community && \
  mkdir -p /usr/src && cd /usr/src && mkdir -p /opt/jira && mkdir -p /var/jira && \
  curl -Ls https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-core-7.3.0.tar.gz | tar \
    -xvz --directory /opt/jira --strip-components=1 \
      --no-same-owner && \

  ls -la /opt/jira && \
  curl -Ls https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.tar.gz | tar \
    -xvz --directory /opt/jira/lib --no-same-owner --strip-components=1 \
    mysql-connector-java-5.1.40/mysql-connector-java-5.1.40-bin.jar && \

  sed -i "s/java version/openjdk version/g" "/opt/jira/bin/check-java.sh" && \
  printf "\njira.home=/var/jira" >> "/opt/jira/atlassian-jira/WEB-INF/classes/jira-application.properties" && \
  touch /opt/jira/conf/server.xml && \

  addgroup -Sg 1000 jira && \
  adduser -HSg 1000 -u 1000 jira && \
  chown -R jira:jira /opt/jira /var/jira && \
  apk del tar curl && \
  ls -la /opt/jira && \
  cleanup
  VOLUME /opt/jira/logs
  VOLUME /var/jira
  CMD ["/usr/local/bin/jira"]