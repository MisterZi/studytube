# syntax=docker/dockerfile:1
FROM ruby:3.1.0-alpine3.15

RUN apk --no-cache add bash \
    tzdata \
    libcurl \
    less \
    postgresql-client \
    libpq \
    build-base \
    git \
    postgresql-dev \
    zlib-dev

WORKDIR /studytube
COPY Gemfile /studytube/Gemfile
COPY Gemfile.lock /studytube/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]