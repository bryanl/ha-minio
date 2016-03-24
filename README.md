# HA Minio

Demonstration of how to configure [Minio](https://minio.io/), a S3 compatible
Cloud Storage Server for DigitalOcean in a highly available fashion.

This installation requires Terraform and Ansible.

# Prerequisites

## Terraform
 
Install [Terraform](https://www.terraform.io/downloads.html) on your system. If you are using
MacOS X and Homebrew, you can install it with `brew install terraform`

## Ansible

Install [Ansible](http://docs.ansible.com/ansible/intro_installation.html) on your system. If
you are using MacOS X and Homebrew, you can install it with `brew install ansible`

Since inventory is managed by Terraform, you can use [terraform-inventory](https://github.com/adammck/terraform-inventory) to supply 
Ansible with the Droplet configuration. If you are using MacOS X and Homebrew, you can
install it with `brew install terraform-inventory`. 

# Install Minio on Droplets

## Provision Droplets

1. Terraform is configured through `terraform.tvfars`. A sample file, `terraform.tfvars.sample`,
has been included.

1. Use Terraform to build Droplets and Floating IP. `terraform apply`.
1. Once Droplets and Floating IP have been created, retrieve the assigned Floating IP.
1. Assign a hostname to the Floating IP that was created. This hostname will be used to
   automatically generate a TLS certificate when configuring the Droplet.

## Configure Droplets

1. Copy `group_vars/node.sample` to `group_vars/node`.
1. Create Ansible node configuration:
    1. Un-comment and fill in `floating_ip`.
    1. Un-comment and fill in `do_token` with your DigitalOcean Access Token.
    1. Un-comment and fill in `minio_host` with the hostname you assigned to your Floating IP.
    1. Use `gen_auth_key` to generate an auth key for the cluster. Un-comment and 
       fill in `ha_auth_key` with the generated key.
1. Use Ansible to configure the Droplets for Minio. `ansible-playbook -i /usr/local/bin/terraform-inventory site.yml`

## Using Minio

Once Ansible has completed running your Cloud Storage site will be available at 
https://<floating ip hostname>.  

  

 ## Extras
 
 Generating a fingerprint for your public ssh key:
 
 ```sh
 ssh-keygen -E md5 -lf ~/.ssh/id_rsa.pub
 ```

 
