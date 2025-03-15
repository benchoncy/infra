# Podman Hosts

Podman hosts are set to run rootless containers under the user `podman` (by default).

See the [ansible inventory](../../inventory/podman.yaml) for the podman hosts.
See the [podman.yaml](../../ansible/podman.yaml) playbook for host management.
To configure new containers, see the [podman_containers role](../../ansible/roles/podman_containers).

## Troubleshooting
To access the podman user with access to systemctl/journalctl, use machinectl:
```
sudo machinectl shell --uid podman
```

Once inside the podman user, you can run systemctl/journalctl commands as you would normally for user services.

### Checking service status
```
systemctl --user status home-assistant
```

### Checking service logs
```
journalctl --user -eu home-assistant
```

### Restarting a service
```
systemctl --user restart home-assistant
```
