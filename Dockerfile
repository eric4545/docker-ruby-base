ARG RUBY_VERSION=2.5.8
ARG ALPHINE_VERSION=3.13
FROM ruby:${RUBY_VERSION}-alpine${ALPHINE_VERSION}

ENV IMAGEMAGICK_VERSION=6.9.11.55-r0
ENV POSTGRESQL_VERSION=13.2-r0
ENV AWS_CLI_VERSION=1.16.273

RUN addgroup -g 1000 ruby && \
    adduser -u 1000 -G ruby -s /bin/sh -D ruby && \
    apk update \
    && apk add --no-cache --update \
            less \
    && apk add --no-cache \
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
       py-pip \
       ncurses \
       curl \
    && \
    pip install --upgrade awscli==$AWS_CLI_VERSION && \
    apk --purge del py-pip && \
    gem install bundler && gem update --system
