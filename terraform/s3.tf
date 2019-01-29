resource "aws_s3_bucket" "report_bucket" {
  bucket = "${var.REPORT_BUCKET_URL}"
  acl = "private"

  website {
    index_document = "index.html"
  }

  tags = {
    Name = "Report bucket"
    Environment = "Dev"
  }
}

//output "report_bucket_dns_name" {
//  value = "${aws_s3_bucket.report_bucket.bucket_regional_domain_name}"
//}
//
//locals {
//  s3_origin_id = "ReportBucketS3Origin"
//}
//
//resource "aws_cloudfront_distribution" "report_bucket_cf" {
//  origin {
//    domain_name = "${aws_s3_bucket.report_bucket.bucket_regional_domain_name}"
//    origin_id   = "${local.s3_origin_id}"
//
////    s3_origin_config {
////      origin_access_identity = "origin-access-identity/cloudfront/ABCDEFG1234567"
////    }
//  }
//
//  enabled             = true
////  is_ipv6_enabled     = true
////  comment             = "Some comment"
//  default_root_object = "index.html"
//
////  logging_config {
////    include_cookies = false
////    bucket          = "mylogs.s3.amazonaws.com"
////    prefix          = "myprefix"
////  }
//
//  aliases = ["${var.REPORT_BUCKET_URL}"]
//
//  default_cache_behavior {
//    allowed_methods  = ["GET", "HEAD"]
//    cached_methods   = ["GET", "HEAD"]
//    target_origin_id = "${local.s3_origin_id}"
//
//    forwarded_values {
//      query_string = false
//
//      cookies {
//        forward = "none"
//      }
//    }
//
//    viewer_protocol_policy = "allow-all"
//    min_ttl                = 0
//    default_ttl            = 3600
//    max_ttl                = 86400
//  }
//
//  price_class = "PriceClass_200"
//
//  restrictions {
//    geo_restriction {
//      restriction_type = "whitelist"
//      locations        = ["US", "CA", "GB", "DE"]
//    }
//  }
//
//  tags = {
//    Environment = "production"
//  }
//
//  viewer_certificate {
//    cloudfront_default_certificate = true
//  }
//}
//
//output "cloudfront_url" {
//  value = "${aws_cloudfront_distribution.report_bucket_cf.domain_name}"
//}