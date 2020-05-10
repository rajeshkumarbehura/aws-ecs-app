# outputs.tf

output "webcore_alb_hostname" {
  value = aws_alb.webcore_lb.dns_name
}

