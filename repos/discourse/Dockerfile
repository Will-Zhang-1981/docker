FROM envygeeks/ubuntu
MAINTAINER <%= @meta.maintainer %>
ENV \
  RAILS_ENV=production \
  UNICORN_SIDEKIQS=1 \
  DISCOURSE_DB_PORT=5432 \
  DISCOURSE_DB_USER=discourse \
  DISCOURSE_DB_HOST=postgresql \
  DISCOURSE_DB_NAME=discourse \
  DISCOURSE_REDIS_HOST=redis \
  DISCOURSE_REDIS_PORT=6379 \
  UNICORN_ENABLE_OOBGC=0 \
  UNICORN_WORKERS=2
RUN \
  apt-get update && apt-get install ucf bash -y && \
  apt-get install --no-install-recommends -y libffi-dev libssl-dev libyaml-dev \
    libreadline6-dev build-essential libxslt1-dev libxml2-dev libpq-dev ruby-dev libxml2 \
    optipng libyaml-0-2 imagemagick libreadline6 libjpeg-turbo-progs postgresql-client \
    nodejs-legacy ghostscript libxslt1.1 jpegoptim gifsicle nodejs jhead ruby \
    git npm && \

  groupadd -rg 1000 discourse && \
  useradd -rMu 1000 -g 1000 discourse && \
  mkdir -p /opt/discourse && chown discourse:discourse /opt/discourse && \
  gem install bundler --no-document && \
  npm install -g svgo && \

  cd /opt/discourse && \
  git clone --single-branch --depth=1 --branch v<%= @meta.release %> \
    https://github.com/discourse/discourse.git . && \

  echo 'gem "rails_12factor", :group => :production' >> Gemfile && \
  bundle install --without=development test profile && \
  chown -R discourse:discourse \
    /opt/discourse && \

  echo libxml2           hold | dpkg --set-selections && \
  echo libssl1.0.0       hold | dpkg --set-selections && \
  echo libxslt1.1        hold | dpkg --set-selections && \
  echo libpq5            hold | dpkg --set-selections && \

  mv /opt/discourse/plugins /opt/discourse/.plugins && \
  mkdir -p /opt/discourse/plugins && chown discourse:discourse /opt/discourse/plugins && \
  apt-get autoremove --purge -y libffi-dev libssl-dev libyaml-dev \
    libreadline6-dev build-essential libxslt1-dev libxml2-dev \
    libpq-dev ruby-dev && cleanup
COPY copy /
VOLUME \
  /opt/discourse/public/assets \
  /opt/discourse/public/javascripts \
  /opt/discourse/public/uploads \
  /opt/discourse/public/images \
  /opt/discourse/plugins
CMD ["/usr/local/bin/discourse"]
EXPOSE 3000
