resource "aws_route53_record" "linux_server_box_record" {
  zone_id = var.network_layer.private_hosted_zone_id
  name    = "${var.set.name}-server.testytesty.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.linux_server_box.private_ip]
}

resource "aws_route53_record" "linux_client_box_record" {
  zone_id = var.network_layer.private_hosted_zone_id
  name    = "${var.set.name}-client.testytesty.com"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.linux_client_box.private_ip]
}
