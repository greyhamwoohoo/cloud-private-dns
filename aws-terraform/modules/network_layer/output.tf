output "network_layer" {
    value = {
        vpc_id = aws_vpc.testytesty_vpc.id
        public_subnet_id = aws_subnet.testytesty_public_subnet.id
        private_subnet_id = aws_subnet.testytesty_private_subnet.id
        bastion_id = aws_instance.bastion_linux.id
        bastion_public_ip = aws_instance.bastion_linux.public_ip
        bastion_security_group_id = aws_security_group.bastion_allow_ssh.id
        private_hosted_zone_id = aws_route53_zone.private_zone.id
        private_domain_name = aws_route53_zone.private_zone.name
    }
}
