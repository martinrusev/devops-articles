FROM martinrusev/tdd-puppet

WORKDIR /tmp

COPY apache.pp /tmp


# Copy test suite
COPY  spec  /tmp/spec
COPY Rakefile Rakefile
COPY goss.json /tmp/goss.json


RUN puppet apply apache.pp


# run test suite
RUN bundle exec rake spec
RUN goss -g goss.json validate
