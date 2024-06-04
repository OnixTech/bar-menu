FROM ruby:3.2.2-alpine

# Install required packages
RUN apk update \
    && apk add --virtual build-dependencies build-base \
    git \
    nodejs npm \
    yarn \
    postgresql postgresql-contrib libpq-dev \
    && rm -rf /var/lib/apt/lists/*

RUN adduser -D developer

# Install Heroku CLI
RUN npm install -g heroku

# Add Heroku CLI to PATH
ENV PATH="/usr/local/lib/node_modules/heroku/bin:${PATH}"
ENV PATH="$PATH:$(yarn global bin)"

WORKDIR /barmenu

RUN gem install bundler:2.5.6

COPY --chown=developer . ./

RUN bundle install

# Precompile assets
RUN bundle exec rails assets:precompile

# Expose port 3000
EXPOSE 3000
