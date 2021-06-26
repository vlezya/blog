FROM ruby:2.4.2-slim

# Common dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    curl \
    less \
    git \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

RUN curl -fsSL https://deb.nodesource.com/setup_12.x | bash -

# Application dependencies
# libpq-dev - postgres dependency
# openssh-client - using capistrano inside docker container

RUN apt-get update -qq \
  && apt-get install -yq --force-yes --no-install-recommends \
    glib-2.0 \
    libpq-dev \
    nodejs \
    openssh-client \
    postgresql-client \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

WORKDIR /Lessons/VladRomanyuk/my_blog

COPY Gemfile /my_blog/Gemfile
COPY Gemfile.lock /my_blog/Gemfile.lock

RUN bundle install
