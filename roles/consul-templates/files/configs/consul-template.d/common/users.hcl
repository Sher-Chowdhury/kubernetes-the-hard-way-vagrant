template {
  source = "/etc/consul-template/ctmpl-files/common/users.ctmpl"
  destination = "/etc/consul-template/ansible/rendered-templates/group_vars/common/users.yml"
  command = "/bin/bash -c '/bin/ansible-playbook -i 127.0.0.1, /etc/consul-template/ansible/playbooks/common/users.yml || true'"
  command_timeout = "60s"
  perms = 0600
  wait {
    min = "5s"
    max = "10s"
  }
}