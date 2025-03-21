# Create Route 53 Hosted Zone
resource "aws_route53_zone" "zsoftly_zone" {
  name = "chebm.click"
}

# Create an A record pointing to ALB
resource "aws_route53_record" "zsoftly_record" {
  zone_id = aws_route53_zone.zsoftly_zone.id
  name    = "chebm.click"
  type    = "A"

  alias {
    name                   = aws_lb.zsoftly_alb.dns_name
    zone_id                = aws_lb.zsoftly_alb.zone_id
    evaluate_target_health = true
  }
}
