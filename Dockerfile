ARG RUBY_VERSION=2.5.9
ARG ALPHINE_VERSION=3.12
FROM ruby:${RUBY_VERSION}-alpine${ALPHINE_VERSION}

ENV IMAGEMAGICK_VERSION=6.9.11.48-r0
ENV POSTGRESQL_VERSION=12.7-r0
ENV AWS_CLI_VERSION=1.16.273

RUN addgroup -g 1000 ruby && \
    adduser -u 1000 -G ruby -s /bin/sh -D ruby && \
    apk update && \
    apk add --no-cache \
       less \
       build-base \
       python3-dev \
       python3 \
       ca-certificates \
       git \
       gnupg \
       tzdata \
       ffmpeg \
       ffmpeg-dev \
       imagemagick6-dev=$IMAGEMAGICK_VERSION \
       imagemagick6=$IMAGEMAGICK_VERSION \
       postgresql-dev=$POSTGRESQL_VERSION \
       # we need pg_dump to be available in the env
       postgresql=$POSTGRESQL_VERSION \
       ncurses \
       curl \
    && \
    python3 -m ensurepip --upgrade && \
    pip3 install --upgrade awscli==$AWS_CLI_VERSION && \
    gem install bundler && \
    gem update --system
