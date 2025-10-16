output "site_bucket_name" {
  value = aws_s3_bucket.website.bucket
}

output "distribution_id" {
  value = aws_cloudfront_distribution.website.id
}