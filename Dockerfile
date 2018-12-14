FROM ruby:2.3.0
ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y nodejs \
                       nano \
                       sudo \
                       mysql-client \
                       --no-install-recommends && \
rm -rf /var/lib/apt/lists/*

#Cache bundle install
WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle install

#Copy app code to container
ENV APP_ROOT /workspace
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
COPY . $APP_ROOT

#Configure production environment variables
#ENV RAILS_ENV=production     RACK_ENV=production

EXPOSE  3000
#Run puma server by default
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
#CMD ["rails", "server", "-b", "0.0.0.0"]
