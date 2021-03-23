#
# Bastion (available on the Internet)
#
resource "aws_instance" "bastion_linux" {
  ami           = "ami-075a72b1992cb0687"
  instance_type = "t2.small"

  vpc_security_group_ids = [aws_security_group.bastion_allow_ssh.id]
  subnet_id              = aws_subnet.testytesty_public_subnet.id
  key_name               = var.bastion_key_pair_name

  tags = {
    Name = "Bastion"
  }
}
