## 2.0.0

BREAKING CHANGES:

- Require Vagrant 1.8.0

IMPROVEMENTS:

- Switch to ansible-local provisioner (no more need for Ansible on host machine)
- Use new ansible-galaxy support in Vagrant 1.8.0
- Upgrade Roles
- Remove dependency of Vagrant Triggers plugin
- Remove dependency of Ansible on host machine

CHANGES:

- Rename boxes and change private ips

## 1.0.8

IMPROVEMENTS:

- Add js box for nodejs projects.
- Update to Ruby 2.1.6 and Ruby 2.2.2.

## 1.0.7

CHANGES:

- Remove pablocrivella.nodejs from site roles.
- Add ANXS.nodejs from ansible-galaxy.
- Remove pablocrivella.heroku-toolbelt from site-roles.
- Add pablocrivella.heroku-toolbelt from ansible-galaxy.
- Update pablocrivella.rbenv role to version 2.0.0.

## 1.0.6

FEATURES:

- Add role for installing heroku-toolbelt with plugins on ruby-devbox.
