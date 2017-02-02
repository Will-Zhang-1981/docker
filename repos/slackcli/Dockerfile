FROM envygeeks/alpine
ENV SLACK_API_TOKEN=""
RUN \
  apk --update add ruby ruby-dev build-base openssl ruby-bigdecimal ca-certificates && \
  gem install slack-ruby-client --no-ri --no-rdoc && \
  apk del build-base && \
  cleanup
CMD ["/usr/local/bin/slack"]