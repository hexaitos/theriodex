FROM ruby:3.4-alpine
RUN apk add --no-cache build-base gcompat wget gzip

RUN bundle config --global frozen 1

WORKDIR /usr/src/app
RUN mkdir public

RUN wget -qO- https://theriodex-data.s3.nl-ams.scw.cloud/main.tar.gz | gunzip | tar xvf - -C public --strip-components=1

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY app app
COPY public public
COPY views views
COPY server.rb server.rb

RUN apk del build-base gcompat wget gzip

CMD ["bundle", "exec", "ruby", "server.rb", "-e", "production", "-p", "5678"]