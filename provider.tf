variable "do_token" {}
variable "private_key_path" {}
variable "ssh_fingerprint" {}
variable "region" {}

provider "digitalocean" {
  token = "${var.do_token}"
}
