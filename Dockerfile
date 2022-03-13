FROM ruby:3.1
ARG BUILD_ENV

WORKDIR /usr/src/app

COPY . .

# bundle install
RUN if [ "$BUILD_ENV" = "development" ]; then \
      bundle install;\
    else \
      bundle install --without development test; \
    fi;

# Precompile Rails assets if building in production
RUN if [ "$BUILD_ENV" = "production" ]; then \
      bundle exec rake assets:precompile;\
    fi;
