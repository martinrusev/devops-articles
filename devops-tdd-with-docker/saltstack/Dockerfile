FROM saltstack/ubuntu-14.04
RUN sudo apt-get update
RUN sudo apt-get install -y salt-minion 

RUN mkdir -p /srv/salt
ADD vim.sls /srv/salt/vim.sls
ADD minion.yml /etc/salt/minion
RUN /etc/init.d/salt-minion restart

RUN salt-call --local state.sls vim