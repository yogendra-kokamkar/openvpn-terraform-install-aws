resource "null_resource" "vpn_setup" {
  depends_on = [aws_instance.vpn_server]

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for /root/client.ovpn to be created...'",
      "while ! sudo test -f /root/client.ovpn; do sleep 5; done",
      "echo 'Copying to /home/ubuntu/client.ovpn...'",
      "sudo cp /root/client.ovpn /home/ubuntu/client.ovpn",
      "sudo chown ubuntu:ubuntu /home/ubuntu/client.ovpn",
      "sudo chmod 644 /home/ubuntu/client.ovpn",
      "echo 'Waiting 10 seconds to ensure file is visible to next provisioner...'",
      "sleep 10"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = aws_instance.vpn_server.public_ip
    }
  }

  provisioner "local-exec" {
    command = "scp -i ${var.private_key_path} -o StrictHostKeyChecking=no ubuntu@${aws_instance.vpn_server.public_ip}:/home/ubuntu/client.ovpn ./client.ovpn"
  }
}
