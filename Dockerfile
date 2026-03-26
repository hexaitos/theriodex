FROM ruby:4-alpine AS builder

RUN apk add --no-cache build-base gcompat wget gzip git

WORKDIR /usr/src/app
RUN mkdir public

RUN wget -qO- https://theriodex-data.s3.nl-ams.scw.cloud/main.tar.gz | gunzip | tar xvf - -C public --strip-components=1

COPY Gemfile Gemfile.lock ./
RUN bundle config set --global frozen 1 && \
    bundle install && \
    bundle clean --force && \
    rm -rf ~/.bundle/cache /usr/local/bundle/cache

COPY app app
COPY views views
COPY server.rb server.rb

FROM ruby:4-alpine

WORKDIR /usr/src/app

COPY --from=builder /usr/local/bundle /usr/local/bundle

COPY Gemfile Gemfile.lock ./

COPY --from=builder /usr/src/app/app ./app
COPY --from=builder /usr/src/app/views ./views
COPY --from=builder /usr/src/app/public ./public
COPY --from=builder /usr/src/app/server.rb ./server.rb

EXPOSE 5678
CMD ["bundle", "exec", "ruby", "server.rb", "-e", "production", "-p", "5678"]
