FROM ruby:3.1
ARG BUILD_ENV

# Install nodejs
RUN apt-get update -yqq
RUN apt-get install -yqq --no-install-recommends nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y yarn
RUN yarn install

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
      RAILS_ASSETS_PRECOMPILE=true bundle exec rake assets:precompile;\
    fi;

# bootsrap-icons package
RUN yarn add bootstrap-icons