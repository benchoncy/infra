# Ansible

This directory contains the Ansible playbooks and roles used to configure the hosts in the lab environment.

## Playbooks
### baseline.yaml
This playbook is used to apply a baseline to all hosts in the lab environment. Use this playbook on a fresh host to ensure it is configured to the baseline standard. With this, some host variables will need to be set depending on the host. `node_exporter_arch` is a commonly required override.

#### Baselining a host
Firstly, run the playbook against the host using a sudoer user, example:
```bash
ansible-playbook ./baseline.yaml -i "<new_hostname> ansible_host=<current_hostname> ansible_connection=ssh ansible_user=<user> ansible_password=<password>"
```
If variable overrides are required, use the `--extra-vars`.

After the playbook has run, the host will be baselined. The next step, if the host is bare metal; is to add the host to the static inventory file `inventory/static.yaml`.
