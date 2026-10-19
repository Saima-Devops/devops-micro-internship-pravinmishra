output "web_public_ips" {
  description = "Public IP addresses of the web servers"

  value = {
    web1 = azurerm_public_ip.web[0].ip_address
    web2 = azurerm_public_ip.web[1].ip_address
  }
}

output "ssh_username" {
  description = "SSH username"
  value       = var.admin_username
}
