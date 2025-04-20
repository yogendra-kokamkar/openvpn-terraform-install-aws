output "public_ip" {
  value = aws_instance.vpn_server.public_ip
}

output "ovpn_path" {
  value = "./client.ovpn"
}
