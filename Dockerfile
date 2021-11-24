FROM ruby:3-slim

LABEL “app_type”=“backend”
LABEL “service_type”=“API”

USER root

ENV APP /usr/src/app
ENV RAILS_ENV production

RUN mkdir -p $APP
RUN apt-get -y update && apt-get install -y \
libgmp-dev \
gcc make git \
postgresql-client \
dnsutils \
libpq-dev libglib2.0-dev build-essential patch zlib1g-dev liblzma-dev \
&& rm -rf /var/lib/apt/lists/*

WORKDIR $APP
COPY Gemfile $APP/Gemfile
COPY Gemfile.lock $APP/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . $APP
RUN apt-get autoremove && rm -rf /var/lib/apt/lists/*

CMD [ "bundle", "exec", "puma", "-C", "config/puma.rb", "config.ru" ]
