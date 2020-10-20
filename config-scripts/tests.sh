#!/bin/bash
set -e
echo 'Packer test'
packer validate -var-file=packer/variables.json.example packer/app.json
packer validate -var-file=packer/variables.json.example packer/db.json
packer validate -var-file=packer/variables.json.example packer/ubuntu16.json
packer validate -var-file=packer/variables.json.example packer/immutable.json
echo 'Terraform test'
cd terraform/prod && terraform init -backend=false && tflint && terraform validate
cd ../stage && terraform init -backend=false && tflint && terraform validate
echo 'Ansible test'
cd ../../ansible && ansible-lint playbooks/app.yml --exclude=roles/jdauphant.nginx
ansible-lint playbooks/db.yml
ansible-lint playbooks/deploy.yml
ansible-lint playbooks/packer_app.yml
ansible-lint playbooks/packer_db.yml
ansible-lint playbooks/site.yml --exclude=roles/jdauphant.nginx
ansible-lint playbooks/users.yml
