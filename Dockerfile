FROM ruby:2.2.3

WORKDIR /app

RUN gem install fluentd

COPY fluent.conf /app/fluent.conf
COPY Gemfile.test /app/Gemfile
ADD . /app/vendor/fluent-newrelic-insights
RUN bundle install -j 4

EXPOSE 24224 9880

CMD bundle exec fluentd -c ./fluent.conf