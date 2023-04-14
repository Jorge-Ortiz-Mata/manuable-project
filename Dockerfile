FROM ruby:3.0.4

WORKDIR /workspaces/manuable-project

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client imagemagick libvips

RUN gem install rails