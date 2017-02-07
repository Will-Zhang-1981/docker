FROM envygeeks/alpine
ENV SLACK_API_TOKEN=""
RUN \
  apk --update add ruby ruby-dev build-base openssl ruby-bigdecimal ca-certificates ruby-io-console && \
  gem install slack-ruby-client thor --no-ri --no-rdoc && \
  apk del build-base && \
  cleanup
COPY copy /
CMD ["/usr/local/bin/slack"]