ARG RUBY_VERSION=2.5.5
ARG ALPHINE_VERSION=3.8
FROM ruby:${RUBY_VERSION}-alpine${ALPHINE_VERSION}

ENV IMAGEMAGICK_VERSION=6.9.6.8-r1
ENV POSTGRESQL_VERSION=10.8-r0
ENV AWS_CLI_VERSION=1.16.91

RUN apk update \
    # older imagemagick lies in the 3.5 ahphine registry
    && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.5/main' >> /etc/apk/repositories \
    # POSTGRESQL_VERSION 10.7-r0 in the 3.6 ahphine registry
    && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.7/main' >> /etc/apk/repositories \
    && apk add --no-cache \
       build-base \
       python-dev \
       python \
       ca-certificates \
       git \
       gnupg \
       tzdata \
       imagemagick-dev=$IMAGEMAGICK_VERSION \
       imagemagick=$IMAGEMAGICK_VERSION \
       # in alpine3.7 postgresql is 10.5
       postgresql-dev=$POSTGRESQL_VERSION \
       # we need pg_dump to be available in the env
       postgresql=$POSTGRESQL_VERSION \
       py-pip \
    && \
    pip install --upgrade awscli==$AWS_CLI_VERSION && \
    apk --purge del py-pip
