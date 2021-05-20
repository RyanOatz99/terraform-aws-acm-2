data "aws_route53_zone" "this" {
  name         = var.hosted_zone_name
  private_zone = false
}

resource "aws_acm_certificate" "this" {
  for_each = { for v in var.subdomain_names : v => v }

  domain_name       = "${each.value}.${data.aws_route53_zone.this.name}"
  validation_method = "DNS"

  tags = {
    Name = "${each.value}.${data.aws_route53_zone.this.name} - certificate"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = { for v in var.subdomain_names : v => v }

  zone_id         = data.aws_route53_zone.this.zone_id
  ttl             = 60
  name            = element(tolist(aws_acm_certificate.this[each.key].domain_validation_options), 0).resource_record_name
  type            = element(tolist(aws_acm_certificate.this[each.key].domain_validation_options), 0).resource_record_type
  records         = [element(tolist(aws_acm_certificate.this[each.key].domain_validation_options), 0).resource_record_value]
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "this" {
  for_each = { for v in var.subdomain_names : v => v }

  certificate_arn         = aws_acm_certificate.this[each.key].arn
  validation_record_fqdns = [aws_route53_record.cert_validation[each.key].fqdn]
}
