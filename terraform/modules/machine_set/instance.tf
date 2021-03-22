resource "aws_instance" "linux_server_box" {
  ami             = "ami-075a72b1992cb0687"
  instance_type   = "t2.small"
  private_ip      = var.set.private_ip

  key_name = var.key_pair_name
  
  subnet_id = var.network_layer.private_subnet_id

  vpc_security_group_ids = [aws_security_group.set_allow_ssh.id]

  tags = {
    set_name = var.set.name
  }
}
