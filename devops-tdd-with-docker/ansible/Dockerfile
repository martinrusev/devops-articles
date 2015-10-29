FROM martinrusev/tdd-ansible

WORKDIR /tmp
COPY  spec  /tmp/spec

COPY Rakefile Rakefile

RUN bundle exec rake spec
	