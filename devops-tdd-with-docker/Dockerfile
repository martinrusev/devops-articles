FROM martinrusev/tdd-ansible

WORKDIR /tmp
COPY  spec  /tmp/spec

# RUN gem install bundle --no-ri --no-rdoc

COPY Rakefile Rakefile
# RUN bundle install 

RUN bundle exec rake spec
