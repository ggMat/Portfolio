# Retrieve the ACM certificate in us-east-1
data "aws_acm_certificate" "cert" {
  provider = aws.us_east_1
  domain   = var.domain_name
  statuses = ["ISSUED"]
  most_recent = true
}

# Create CloudFront Origin Access Control to restrict S3 bucket access
resource "aws_cloudfront_origin_access_control" "website" {
  name               = "${var.domain_name}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior   = "always"
  signing_protocol   = "sigv4"
}

resource "aws_cloudfront_distribution" "website" {
  enabled = true
  aliases = [var.domain_name, "www.${var.domain_name}"]
  default_root_object = "index.html"
  price_class = "PriceClass_100" # Use only US, Canada and Europe edge locations
  is_ipv6_enabled = true
  wait_for_deployment = true

  origin {
    domain_name = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.website.id
    origin_access_control_id = aws_cloudfront_origin_access_control.website.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = data.aws_acm_certificate.cert.arn
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD", "OPTIONS"]
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6" # CachingOptimized
    target_origin_id = aws_s3_bucket.website.id
    viewer_protocol_policy = "redirect-to-https"
    }

  tags = var.tags

}
