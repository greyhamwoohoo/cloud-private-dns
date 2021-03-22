#
# Security Groups
#
# TODO: Connect from bastion; or from machines in same set
resource "aws_security_group" "set_allow_ssh" {
  vpc_id      = var.network_layer.vpc_id
  name        = "${var.set.name}-allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
