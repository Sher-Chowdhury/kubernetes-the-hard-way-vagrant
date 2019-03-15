#!/usr/bin/env bash
# exit 0
set -ex


ConsulVersion=1.4.0
ConsulDownloadLink=https://releases.hashicorp.com/consul/${ConsulVersion}/consul_${ConsulVersion}_linux_amd64.zip

echo "INFO: Downloading Consul"
curl --location --verbose $ConsulDownloadLink -o /tmp/consul.zip

echo "INFO: Installing Consul"
unzip /tmp/consul.zip -d /usr/local/bin
chmod +x /usr/local/bin/consul


useradd consul --system --shell /bin/bash



exit 0