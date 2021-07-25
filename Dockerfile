FROM ruby:2.7.2
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /docker-test
WORKDIR /docker-test
COPY Gemfile /docker-test/Gemfile
COPY Gemfile.lock /docker-test/Gemfile.lock
RUN bundle install
COPY . /docker-test

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 8000

CMD ["rails", "server", "-b", "0.0.0.0"]