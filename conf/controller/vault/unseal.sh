curl --request PUT --data "{\"key\": \"$(jq -r '.keys[0]' /tmp/vault.json)\"}" http://127.0.0.1:8200/v1/sys/unseal > /tmp/unseal
curl --request PUT --data "{\"key\": \"$(jq -r '.keys[1]' /tmp/vault.json)\"}" http://127.0.0.1:8200/v1/sys/unseal >> /tmp/unseal
curl --request PUT --data "{\"key\": \"$(jq -r '.keys[2]' /tmp/vault.json)\"}" http://127.0.0.1:8200/v1/sys/unseal >> /tmp/unseal