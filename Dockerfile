FROM ruby:3.1.3-alpine3.17 as base

WORKDIR /usr/src/app

RUN apk add --no-cache gcompat tzdata make g++ linux-headers

COPY Gemfile* ./

RUN bundle install

COPY . .

CMD ["rspec", "spec", "--require", "spec_helper"]