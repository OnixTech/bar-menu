FROM ruby:3.2.2-alpine

RUN adduser -D developer

# Install required packages
RUN apk update \
    && apk add --virtual build-dependencies build-base \
    git \
    nodejs \
    postgresql postgresql-contrib libpq-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /barmenu

RUN gem install bundler:2.5.6

COPY --chown=developer Gemfile Gemfile.lock ./
RUN bundle install

COPY --chown=developer . .

