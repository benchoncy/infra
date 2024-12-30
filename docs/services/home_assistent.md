# Home Assistant (HA)

---

Purpose: Home Assistant is an open-source home automation platform that acts as the central hub for all my smart devices.
Type: Self-Hosted
Address: [dalaran:8123](http://dalaran:8123)

---

# Setup

Home Assistant can be run in various platforms, currently I'm hosting this via a podman container. See [here](https://www.home-assistant.io/installation/raspberrypi) for more information.

See the [podman_containers role](../../ansible/roles/podman_containers) for the container configuration. And the [podman.yaml](../../ansible/podman.yaml) playbook for the container management.
