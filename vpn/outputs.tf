output "public_ip" {
  value = aws_instance.vpn_wireguard.public_ip
}

output "vpn_sg_id" {
  value = aws_security_group.vpn_sg.id
}
