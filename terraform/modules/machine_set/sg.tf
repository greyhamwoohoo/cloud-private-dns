#
# Security Groups
# 

#
# Security group for rules WITHIN a set. 
# A set can only SSH to other machines within the same set. 
#
resource "aws_security_group" "set_internal" {
  vpc_id      = var.network_layer.vpc_id
  name        = "${var.set.name}-set-internal"
  description = "Allow SSH from the Bastion server or instances within the same set"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { 
    self        = true
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Allow SSH from instances in the same set only"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [var.network_layer.bastion_security_group_id]
    description = "Allow SSH from the Bastion only"
  }
}
