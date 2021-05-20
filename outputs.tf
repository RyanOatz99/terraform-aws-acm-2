output "certificate_arns" {
  value = toset([
    for v in aws_acm_certificate.this : v.arn
  ])
}

output "certificate_domain_names" {
  value = toset([
    for v in aws_acm_certificate.this : v.domain_name
  ])
}
