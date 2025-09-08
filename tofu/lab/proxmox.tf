resource "proxmox_virtual_environment_download_file" "truenas_scale_img" {
  content_type       = "iso"
  datastore_id       = "local"
  node_name          = "pve"
  url                = "https://download.sys.truenas.net/TrueNAS-SCALE-Fangtooth/25.04.2.1/TrueNAS-SCALE-25.04.2.1.iso"
  checksum           = "1843386be5a11252e0dd19543d991f981f9304e156d0d2e6d8be4a5e95717f15"
  checksum_algorithm = "sha256"
}

resource "proxmox_virtual_environment_vm" "truenas" {
  name        = "truenas"
  description = "TrueNAS SCALE for storage and backups"
  node_name   = "pve"

  protection = false

  startup {
    order    = 0
    up_delay = 60
  }

  cdrom {
    file_id = proxmox_virtual_environment_download_file.truenas_scale_img.id
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 8192
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 8
    ssd          = true
  }

  dynamic "disk" { # Pass-through disks for NAS storage
    for_each = ["/dev/sda", "/dev/sdb"]

    content {
      backup            = false
      replicate         = false
      interface         = "scsi${disk.key + 1}"
      datastore_id      = ""
      path_in_datastore = disk.value
      file_format       = "raw"
      size              = 3726
    }
  }

  network_device {}

  boot_order = ["scsi0", "ide3"] # Try boot from existing install before opening installer

  tags = ["managedby-opentofu", "project-${var.project_name}", "module-${local.module_name}"]
}
