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
