FROM envygeeks/ubuntu
MAINTAINER <%= @meta.maintainer %>
ENV RAILS_ENV=production
ENV UNICORN_SIDEKIQS=1
ENV DISCOURSE_DB_PORT=5432
ENV DISCOURSE_DB_USER=discourse
ENV DISCOURSE_DB_HOST=postgresql
ENV DISCOURSE_DB_NAME=discourse
ENV DISCOURSE_REDIS_HOST=redis
ENV DISCOURSE_REDIS_PORT=6379
ENV UNICORN_ENABLE_OOBGC=0
ENV UNICORN_WORKERS=2

RUN apt-get update
RUN apt-get install ucf bash
RUN apt-get install --no-install-recommends -y libffi-dev libssl-dev libyaml-dev \
  libreadline6-dev build-essential libxslt1-dev libxml2-dev libpq-dev ruby-dev libxml2 \
  optipng libyaml-0-2 imagemagick libreadline6 libjpeg-turbo-progs postgresql-client \
  nodejs-legacy ghostscript libxslt1.1 jpegoptim gifsicle nodejs jhead ruby \
  git npm

RUN groupadd -rg 1000 discourse
RUN useradd -rMu 1000 -g 1000 discourse
RUN mkdir -p /opt/discourse && chown discourse:discourse /opt/discourse
RUN gem install bundler --no-document
RUN npm install -g svgo

WORKDIR /opt/discourse
RUN git clone --single-branch --depth=1 --branch v<%= @meta.release %> \
  https://github.com/discourse/discourse.git .

RUN echo 'gem "rails_12factor", :group => :production' >> Gemfile
RUN bundle install --without=development test profile
RUN chown -R discourse:discourse \
    /opt/discourse

RUN echo libxml2     hold | dpkg --set-selections
RUN echo libssl1.0.0 hold | dpkg --set-selections
RUN echo libxslt1.1  hold | dpkg --set-selections
RUN echo libpq5      hold | dpkg --set-selections

RUN mv /opt/discourse/plugins /opt/discourse/.plugins
RUN mkdir -p /opt/discourse/plugins && chown discourse:discourse /opt/discourse/plugins
RUN apt-get autoremove --purge -y libffi-dev libssl-dev libyaml-dev \
  libreadline6-dev build-essential libxslt1-dev libxml2-dev \
  libpq-dev ruby-dev

RUN cleanup
COPY copy /
VOLUME /opt/discourse/public/assets
VOLUME /opt/discourse/public/javascripts
VOLUME /opt/discourse/public/uploads
VOLUME /opt/discourse/public/images
VOLUME /opt/discourse/plugins
CMD ["/usr/local/bin/discourse"]
EXPOSE 3000
