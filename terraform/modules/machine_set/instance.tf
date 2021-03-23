resource "aws_instance" "linux_server_box" {
  ami             = "ami-075a72b1992cb0687"
  instance_type   = "t2.small"
  private_ip      = var.set.private_ip_server

  key_name = var.key_pair_name
  
  subnet_id = var.network_layer.private_subnet_id

  vpc_security_group_ids = [aws_security_group.set_internal.id]

  tags = {
    set_name = var.set.name
    set_role = "server"
  }
}

resource "aws_instance" "linux_client_box" {
  ami             = "ami-075a72b1992cb0687"
  instance_type   = "t2.small"
  private_ip      = var.set.private_ip_client

  key_name = var.key_pair_name
  
  subnet_id = var.network_layer.private_subnet_id

  vpc_security_group_ids = [aws_security_group.set_internal.id]

  tags = {
    set_name = var.set.name
    set_role = "client"
  }
}
