find provisioning/roles/* -print0 | xargs -0  rm -rf
ansible-galaxy install -r provisioning/RoleFile -p provisioning/roles/
