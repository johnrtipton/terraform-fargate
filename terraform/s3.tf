resource "aws_s3_bucket" "report_bucket" {
  bucket = "${var.REPORT_BUCKET_NAME}"
  acl = "private"

  website {
    index_document = "index.html"
  }

  tags = {
    Name = "Report bucket"
    Environment = "Dev"
  }
}
