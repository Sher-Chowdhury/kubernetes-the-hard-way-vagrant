# Intro

you can access the gui gui from your macos web browser, by going to:

[http://127.0.0.1:8500](http://127.0.0.1:8500)

```bash
consul members
```

dns lookup examples:

Here's how to lookup an ip address for a given node:

```bash
dig @localhost -p 8600 consul-server.node.consul
```

The following should give different IPs if in the same cluster:

```bash
dig @localhost -p 8600 consul.service.consul
```

The following also gives the port number the requested service is listening on (in this example it will be port 8300):

```bash
dig @localhost -p 8600 consul.service.consul SRV
```

Consul commands you can run:

```bash
consul info
consul members
consul monitor
```

## Useful links

[https://learn.hashicorp.com/consul/](https://learn.hashicorp.com/consul/)
