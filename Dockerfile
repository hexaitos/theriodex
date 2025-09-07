FROM ruby:3.4-alpine
RUN apk add --no-cache build-base gcompat wget gzip

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY app app
COPY public public
COPY views views
COPY server.rb server.rb

RUN wget -qO- https://git.hexaitos.eu/hexaitos/pokemon-data/archive/main.tar.gz | gunzip | tar xvf - -C public --strip-components=1

RUN apk del build-base gcompat wget gzip

CMD ["bundle", "exec", "ruby", "server.rb", "-e", "production", "-p", "5678"]