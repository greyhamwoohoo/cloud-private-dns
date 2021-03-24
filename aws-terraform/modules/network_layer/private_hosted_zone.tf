#
# Private Hosted Zone
#
resource "aws_route53_zone" "private_zone" {
  name = "${var.private_domain_name}"

  vpc {
    vpc_id = aws_vpc.testytesty_vpc.id
  }
}
