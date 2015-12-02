FROM martinrusev/tdd-chef


WORKDIR /tmp
ADD cookbooks cookbooks

RUN chef-client -o "recipe[apache2]" -z


