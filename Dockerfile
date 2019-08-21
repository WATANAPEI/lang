FROM ruby:2.5.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        mysql-client \
    && rm -rf /var/lib/apt/lists/* \
    && useradd --user-group --create-home --shell /bin/false app \
    && gem install bundler

ENV HOME=/home/app
ENV BUNDLER_VERSION=2.0.2

WORKDIR $HOME/lang

COPY Gemfile ./
RUN bundle install --path vendor/cache --without test development
COPY . .

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-e", "production"]
