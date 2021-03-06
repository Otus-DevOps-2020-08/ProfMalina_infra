output "external_ip_address_app" {
  value = module.app.external_ip_address_app
}
output "external_ip_address_db" {
  value = module.db.external_ip_address_db
}
output "internal_ip_address_db" {
  value = module.db.internal_ip_address_db
}

### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
    {
      name_app                = module.app.name_app,
      external_ip_address_app = module.app.external_ip_address_app,
      external_ip_address_db  = module.db.external_ip_address_db,
      internal_ip_address_db  = module.db.internal_ip_address_db
    }
  )
  filename = "../../ansible/environments/stage/inventory"
}
