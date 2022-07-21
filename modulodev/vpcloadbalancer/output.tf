output "IP_ADDRES" {
  value = aws_instance.webservers[*].public_ip
}

output "elb-dns-name" {
  value = aws_elb.terra-elb.dns_name
}
