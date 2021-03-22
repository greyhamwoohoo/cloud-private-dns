#
# Private Hosted Zone
#
resource "aws_route53_zone" "private_zone" {
  name = "testytesty.com"

  vpc {
    vpc_id = aws_vpc.testytesty_vpc.id
  }
}
