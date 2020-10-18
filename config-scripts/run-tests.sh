#!/bin/bash
#curl -L "$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -o tflint.zip && unzip tflint.zip && rm tflint.zip
packer validate -var-file=packer/variables.json.example packer/app.json
packer validate -var-file=packer/variables.json.example packer/db.json
packer validate -var-file=packer/variables.json.example packer/ubuntu16.json
packer validate -var-file=packer/variables.json.example packer/immutable.json
cd terraform/prod && tflint && terraform validate
cd ../stage && tflint && terraform validate
cd ../../ansible && ansible-lint playbooks/app.yml
ansible-lint playbooks/db.yml
ansible-lint playbooks/deploy.yml
ansible-lint playbooks/packer_app.yml
ansible-lint playbooks/packer_db.yml
ansible-lint playbooks/site.yml
ansible-lint playbooks/users.yml
