#
# Keypair (same key will be used to access the Bastion and the Linux instances)
# See https://towardsdatascience.com/connecting-to-an-ec2-instance-in-a-private-subnet-on-aws-38a3b86f58fb for how to set up a ProxyCommand
#
resource "aws_key_pair" "key_pair_for_everything" {
  key_name   = "key_pair_everything"
  public_key = file("./ssh-cloud-private-dns.pub")
}