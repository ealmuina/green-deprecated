FROM ruby:3.1

WORKDIR /usr/src/app

COPY . .
RUN bundle install --without development test

# Set Rails to run in production
ENV RAILS_ENV production
ENV RACK_ENV production

# Precompile Rails assets
RUN bundle exec rake assets:precompile
