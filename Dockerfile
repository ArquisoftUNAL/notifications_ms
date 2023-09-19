FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs
RUN apt-get install -y supervisor

WORKDIR /docker/app

RUN gem install bundler

COPY Gemfile* ./

RUN bundle install

ADD . /docker/app

ARG DEFAULT_PORT 3000

EXPOSE 3000

# Run cronjob and rails server in parallel
RUN mkdir -p /var/log/supervisor
# COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/docker/app/supervisord.conf"]
