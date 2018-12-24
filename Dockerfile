FROM ruby:2.3.1
ENV LANG C.UTF-8
ENV APP_ROOT /workspace

RUN apt-get update && \
    apt-get install -y nodejs \
                       nano \
                       sudo \
                       mysql-client \
                       --no-install-recommends && \
rm -rf /var/lib/apt/lists/*

#Cache bundle install
#WORKDIR /tmp
#ADD ./Gemfile Gemfile
#ADD ./Gemfile.lock Gemfile.lock
#RUN bundle install

#Copy app code to container
#ENV APP_ROOT /workspace
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT
ADD Gemfile* $APP_HOME/
RUN bundle install
COPY . $APP_ROOT
#RUN rake db:migrate

#Configure production environment variables
#ENV RAILS_ENV=production     RACK_ENV=production

EXPOSE  3001

#Run puma server by default
#CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
#CMD ["rails", "server", "-b", "0.0.0.0"]
CMD bundle exec rails s -b '0.0.0.0'

