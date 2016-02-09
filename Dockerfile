FROM ruby:2-alpine

RUN \
  gem install htty

ENTRYPOINT [ "htty" ]
