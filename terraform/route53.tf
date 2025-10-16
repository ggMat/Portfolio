# Fetch the Route53 hosted zone
data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}

# Create Route53 A record to point to CloudFront distribution
resource "aws_route53_record" "website" {
  name    = var.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.main.zone_id
  

  alias {
    name                   = aws_cloudfront_distribution.website.domain_name
    zone_id                = aws_cloudfront_distribution.website.hosted_zone_id
    evaluate_target_health = false
  }
}

/*
# Create Route53 A record for www subdomain to point to CloudFront distribution
resource "aws_route53_record" "www_website" {
  name    = "www.${var.domain_name}"
  type    = "A"
  zone_id = data.aws_route53_zone.main.zone_id

  alias {
    name                   = aws_cloudfront_distribution.website.domain_name
    zone_id                = aws_cloudfront_distribution.website.hosted_zone_id
    evaluate_target_health = false
  }
  
}*/
