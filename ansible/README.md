# Ansible

This directory contains the Ansible playbooks and roles used to configure the hosts in the lab environment.

## Playbooks
### baseline.yaml
This playbook is used to apply a baseline to all hosts in the lab environment. Use this playbook on a fresh host to ensure it is configured to the baseline standard. With this, some host variables will need to be set depending on the host. `node_exporter_arch` is a commonly required override.

Playbook outcome: The host will be configured to the baseline standard.
- The host will have an `ansible` user created, acessible via SSH with a lab key.
- The host will have the `ssh` service running.
- The host will lock down SSH to only allow the `ansible` user to login.
- The host will have the `node_exporter` service running.
- Timezone will be set to `Europe/Dublin`.
- Hostname will be set to the inventory hostname.

#### Baselining a host
Firstly, run the playbook against the host using a sudoer user, example:
```bash
ansible-playbook ./baseline.yaml -i "<new_hostname>," --extra-vars "ansible_host=<current_hostname> ansible_connection=ssh ansible_user=<user> ansible_password=<password>"
```
If other variable overrides are required, use the `--extra-vars`.

After the playbook has run, the host will be baselined. The next step, if the host is bare metal; is to add the host to the static inventory file `inventory/static.yaml`.

### podman.yaml
This playbook is used to manage "podman hosts", hosts whos primary purpose is to run containers under podman quadlets. This playbook will install podman and configure the host to run containers. The playbook will then configure the quadlets to run on the host.

Playbook outcome: The host will be configured to run containers under podman quadlets and have select quadlets running.

The playbook runs against the `podman` inventory group, each host should set a `podman_containers` list variable to define the containers to run on the host.
