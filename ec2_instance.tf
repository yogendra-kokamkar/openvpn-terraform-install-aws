resource "aws_instance" "vpn_server" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.vpn_key.key_name
  vpc_security_group_ids      = [aws_security_group.vpn_sg.id]
  associate_public_ip_address = true
  user_data                   = file("${path.module}/user_data.sh")

  tags = {
    Name = "OpenVPN-Server"
  }
}
