output "machine_set" {
    value = {
        linux_server_dns_name = aws_route53_record.linux_server_box_record.name
        linux_server_box_id = aws_instance.linux_server_box.id
        linux_server_box_private_ip = aws_instance.linux_server_box.private_ip

        linux_client_dns_name = aws_route53_record.linux_client_box_record.name
        linux_client_box_id = aws_instance.linux_client_box.id
        linux_client_box_private_ip = aws_instance.linux_client_box.private_ip        
    }
}
