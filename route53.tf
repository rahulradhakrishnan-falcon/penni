# Route 53 for domain 

resource "aws_route53_zone" "main" {
  name = var.domain_name
  tags = var.common_tags
}
resource "aws_route53_record" "root_zone" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "static.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3.domain_name
    zone_id                = aws_cloudfront_distribution.s3.hosted_zone_id
    evaluate_target_health = false
  }
}


resource "aws_route53_record" "certificate_validation" {
  for_each = {
    for dvo in aws_acm_certificate.ssl_certificate.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = aws_route53_zone.main.zone_id
    }
  }
  depends_on = [
    aws_route53_zone.main,
    aws_acm_certificate.ssl_certificate
  ]
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}