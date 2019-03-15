#!/usr/bin/env bash
set -ex

echo '##########################################################################'
echo '############# About to run setup_consul_template.sh script ###############'
echo '##########################################################################'


ConsulTemplateVersion=0.19.4
ConsulTemplateDownload=https://releases.hashicorp.com/consul-template/${ConsulTemplateVersion}/consul-template_${ConsulTemplateVersion}_linux_amd64.zip

echo "INFO: Downloading Consul Template"
curl  --location --verbose $ConsulTemplateDownload -o /tmp/consul_template.zip

curl --location --verbose $ConsulDownloadLink -o /tmp/consul.zip


echo "INFO: Installing Consul Template"
unzip /tmp/consul_template.zip -d /usr/local/bin && \
chmod +x /usr/local/bin/consul-template

cp /vagrant/files/logrotate/consul-template /etc/logrotate.d/consul-template
chmod 0644 /etc/logrotate.d/consul-template

# configure the consul-template daemon
cp /vagrant/consul-template/initd-consul-template /etc/init.d/consul-template
chmod 0755 /etc/init.d/consul-template

systemctl enable consul-template
systemctl start consul-template

exit 0