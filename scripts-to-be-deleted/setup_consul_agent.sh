#!/usr/bin/env bash
set -ex

echo '##########################################################################'
echo '############## About to run setup_consul_agent.sh script #################'
echo '##########################################################################'


# Creating the folder that will house all the consul configurations. 
mkdir -p /etc/consul/consul-agent
chown --recursive consul /etc/consul

# need to populate this file. 
cp /vagrant/files/consul-agent/consul-agent-config.json /etc/consul/consul-agent/
chmod 640 /etc/consul/consul-agent/consul-agent-config.json

exit 0

consul agent -config-dir /etc/consul/consul-agent


# Need to use the following"
# https://medium.com/@wenhuanglin/tutorial-on-running-nomad-and-consul-as-a-systemd-daemon-service-part-2-d1b999c73bdd 
cp /vagrant/files/consul-agent.service /etc/systemd/system/consul-agent.service
chmod 0555 /etc/systemd/system/consul-agent.service


# need to uncomment this once config.json is in place
#systemctl enable consul
#systemctl start consul

# the consul deamon requires the following folder to exist before it can start.
mkdir /opt/consul
chown consul /opt/consul



cp /vagrant/files/logrotate/consul-agent /etc/logrotate.d/consul-agent
chmod 0644 /etc/logrotate.d/consul-agent


# the following starts the agent:


exit 0