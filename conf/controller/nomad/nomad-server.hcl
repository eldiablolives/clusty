# Increase log verbosity
log_level = "INFO"

# Setup data dir
data_dir = "/var/nomad"

bind_addr = "0.0.0.0"
region = "us"
datacenter = "dony"
leave_on_terminate = true

advertise {
  http = "{{ inventory_hostname }}:4646"
  rpc = "{{ inventory_hostname }}:4647"
  serf = "{{ inventory_hostname }}:4648"
}

# Enable the server
server {
    enabled = true

    # Self-elect, should be 3 or 5 for production
    bootstrap_expect = 3
    authoritative_region = "us"
}

consul {
  address             = "127.0.0.1:8500"
  server_service_name = "nomad"
  client_service_name = "nomad-client"
  auto_advertise      = true
  server_auto_join    = true
  client_auto_join    = true
  token               = "{{consul_master_token}}"
  // token               = "{{consul_token}}"
  // token               = "aa2b31c1-7f62-b273-666f-7b919fcbe8bb"
}

vault {
  enabled          = true
#  ca_path          = "/etc/certs/ca"
#  cert_file        = "/var/certs/vault.crt"
#  key_file         = "/var/certs/vault.key"
#  address          = "http://vault.service.consul:8200"
  address          = "http://localhost:8200"
  create_from_role = "nomad"
  token = "{{vault_token}}"
}

acl {
  enabled = true
  token_ttl = "30s"
  policy_ttl = "60s"
}