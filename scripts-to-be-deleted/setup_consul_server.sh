#!/usr/bin/env bash
set -ex

echo '##########################################################################'
echo '############# About to run setup_consul_server.sh script #################'
echo '##########################################################################'

# Creating the folder that will house all the consul configurations. 
mkdir -p /etc/consul/consul-server
cp /vagrant/files/consul-server/consul-server-config.json /etc/consul/consul-server/
chown --recursive consul /etc/consul



exit 0


# The following starts consul in server mode:
#consul agent -dev -client=0.0.0.0

# -dev : this is done so to run consul server in debug mode. Also any k/v data will be lost when you restart the consul server process.
# also see: https://www.consul.io/docs/agent/options.html

# or you can do:
#consul agent -dev -advertise 10.2.5.110 -bind 10.2.5.110 -client=0.0.0.0 
# -advertise - this tells other consul agents what ip address they should use to contact the consul server.  



# in prod environment you would do:
#consul agent -server -advertise 10.2.5.110 -bind 10.2.5.110 -client=0.0.0.0 
# need to put this ip address in the config file. 

# or do: 
consul agent -dev -config-dir /etc/consul/consul-server




exit 0