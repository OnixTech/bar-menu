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

RUN npm install -g heroku

# Add Heroku CLI to PATH
ENV PATH="/usr/local/lib/node_modules/heroku/bin:${PATH}"

WORKDIR /app

RUN gem install bundler:2.5.6

COPY --chown=developer . ./

# Set correct permissions for the app directory
RUN mkdir -p /usr/local/bundle/cache/bundler/git && \
    chown -R developer:developer /usr/local/bundle /app

USER developer

RUN bundle install

RUN yarn install --check-files

# Precompile assets
RUN bundle exec rails assets:precompile

# Precompile assets
RUN yarn run build
RUN bundle exec rails assets:precompile

# Expose port 3000
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
