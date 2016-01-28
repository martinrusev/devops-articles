FROM martinrusev/tdd-chef


WORKDIR /tmp
ADD cookbooks cookbooks


# Copy test suite
COPY  spec  /tmp/spec
COPY Rakefile Rakefile
COPY goss.json /tmp/goss.json


RUN chef-client -o "recipe[apache2]" -z


# run test suite
RUN bundle exec rake spec
RUN goss -g goss.json validate
