resource "aws_iam_role" "ecs_task_assume" {
  name = "ecs_task_assume"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ecs_task_assume" {
  name = "ecs_task_assume"
  role = "${aws_iam_role.ecs_task_assume.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

# -- REPORT BUCKET

data "aws_iam_policy_document" "report-bucket" {
  statement {
    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${var.REPORT_BUCKET_NAME}"
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]

    resources = [
      "arn:aws:s3:::${var.REPORT_BUCKET_NAME}/*"
    ]
  }
}

resource "aws_iam_user" "codefres-report" {
  name = "tf_codefres_report"
  path = "/system/"
  tags = {
    created_by = "terraform"
    project = "temp_check"
  }
}


resource "aws_iam_user_policy" "report_bucket_policy" {
  name = "tf-iam-role-policy-s3-report-bucket-rw"
  user = "${aws_iam_user.codefres-report.name}"
  policy = "${data.aws_iam_policy_document.report-bucket.json}"
}


# -- REPORT BUCKET ACCESS KEY

resource "aws_iam_access_key" "report_bucket" {
  user    = "${aws_iam_user.codefres-report.name}"
  pgp_key = "keybase:jrtipton"
}

output "report_bucket_secret_key" {
  value = "${aws_iam_access_key.report_bucket.id}"
}

output "report_bucket_encrypted_secret" {
  value = "${aws_iam_access_key.report_bucket.encrypted_secret}"
}
