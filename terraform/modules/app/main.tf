resource "yandex_compute_instance" "app" {
  count = var.instsnce_count
  name = "reddit-app-${count.index}"
  labels = {
    tags = "reddit-app-${count.index}"
  }
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
    # security_group_ids = var.sec_group
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }
}
