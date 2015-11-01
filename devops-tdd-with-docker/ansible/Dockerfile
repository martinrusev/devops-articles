FROM martinrusev/tdd-ansible

WORKDIR /tmp

COPY  spec  /tmp/spec
COPY ansible /tmp


COPY Rakefile Rakefile


# ==> Creating inventory file...
RUN echo localhost > inventory


RUN ls -lh /tmp

# ==> Executing Ansible...
RUN ansible-playbook -i inventory apache.yml --connection=local

RUN /etc/init.d/apache2 start


RUN bundle exec rake spec
	