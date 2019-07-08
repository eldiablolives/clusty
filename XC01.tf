resource "digitalocean_droplet" "XC01" {
    image = "ubuntu-18-10-x64"
    name = "XC01"
    region = "nyc1"
    size = "s-1vcpu-1gb"
    monitoring = true
    private_networking = false
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]
    user_data = "${file("scripts/controller.sh")}"
}
