# terraform-k8s

I'm learning terraform and this is my first small sample project. The idea is to create a kubernetes-cluster on Google cloud platform with terraform for infrastructure provisioning and ansible for host configuration.


# How to use

You need terraform and ansbile installs and also a GCP service account key named terraform-test-key.json in the root directory

1. Setup the terraform ressources with: terraform apply
2. Configure ressources with ansible: ansible-playbook -v -i inventory.gcp.yml --ask-become-pass playbook.yml