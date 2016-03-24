variable "public_key" {}

variable "project" {}

variable "image" {
  default = "ubuntu-14-04-x64"
}

variable "size" {
  default = "4gb"
}

resource "digitalocean_droplet" "node" {
  count = "2"
  image = "${var.image}"
  name = "${var.project}-minio-ha-${count.index+1}"
  region = "${var.region}"
  size = "${var.size}"
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
  user_data = "${template_file.user_data.rendered}"

  connection {
    user = "root"
    type = "ssh"
    key_file = "${var.private_key_path}"
    timeout = "2m"
  }
    
  provisioner "remote-exec" {
    inline = [ "# droplet up" ]
  }    
}

resource "template_file" "user_data" {
  template = "${file("${path.module}/conf/cloud-config.yaml")}"
  
  vars {
    public_key = "${var.public_key}"
  }  
}

resource "digitalocean_floating_ip" "fip" {
  region = "${var.region}"
  droplet_id = "${digitalocean_droplet.node.0.id}"
}