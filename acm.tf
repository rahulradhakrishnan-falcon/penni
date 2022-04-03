#SSL Certificate

resource "aws_acm_certificate" "ssl_certificate" {
  provider          = aws.acm_provider
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = var.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

#SSL Certificate Validation

resource "aws_acm_certificate_validation" "cert_validation" {
  provider                = aws.acm_provider
  certificate_arn         = aws_acm_certificate.ssl_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.certificate_validation : record.fqdn]
}