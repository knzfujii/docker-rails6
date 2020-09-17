FROM ruby:2.6.6-alpine

ENV ROOT="/app"
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

WORKDIR ${ROOT}

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        gcc \
        g++ \
        libc-dev \
        libxml2-dev \
        linux-headers \
        make \
        nodejs \
        mysql-client \
        mysql-dev \
        tzdata \
        yarn && \
    apk add --virtual build-packs --no-cache \
        build-base \
        curl-dev

COPY Gemfile ${ROOT}
COPY Gemfile.lock ${ROOT}

RUN bundle install
RUN apk del build-packs

COPY . ${ROOT}

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
