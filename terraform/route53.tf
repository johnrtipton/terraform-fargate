# -- PROD --
resource "aws_route53_record" "cname_route53_record" {
  zone_id = "${var.DOMAIN_ZONE_ID}" # Replace with your zone ID
  name    = "${var.PROD_DNS_HOST}" # Replace with your name/domain/subdomain
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_alb.myapp.dns_name}"]

  depends_on = [
    "aws_alb_listener.myapp"
  ]
}

//resource "aws_route53_record" "cname_test_report_record" {
//  zone_id = "${var.DOMAIN_ZONE_ID}" # Replace with your zone ID
//  name    = "${var.REPORT_BUCKET_URL}" # Replace with your name/domain/subdomain
//  type    = "CNAME"
//  ttl     = "60"
//  records = ["{aws_cloudfront_distribution.report_bucket_cf.domain_name}"]
//
//  depends_on = [
//    "aws_cloudfront_distribution.report_bucket_cf"
//  ]
//}

# -- DEV --
resource "aws_route53_record" "dev_cname_route53_record" {
  zone_id = "${var.DOMAIN_ZONE_ID}" # Replace with your zone ID
  name    = "${var.DEV_DNS_HOST}" # Replace with your name/domain/subdomain
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_alb.myapp_dev.dns_name}"]

  depends_on = [
    "aws_alb_listener.myapp_dev"
  ]
}
