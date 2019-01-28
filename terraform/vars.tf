terraform {
  backend "s3" {
    bucket = "jrtipton-terraform" # ! REPLACE WITH YOUR TERRAFORM BACKEND BUCKET
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
variable "S3_BACKEND_BUCKET" {
  default = "jrtipton-terraform" # ! REPLACE WITH YOUR TERRAFORM BACKEND BUCKET
}

variable "S3_BUCKET_REGION" {
  type    = "string"
  default = "us-east-1"
}

variable "AWS_REGION" {
  type    = "string"
  default = "us-east-1"
}

variable "TAG_ENV" {
  default = "dev"
}

variable "ENV" {
  default = "PROD"
}

variable "CIDR_PRIVATE" {
  default = "10.0.1.0/24,10.0.2.0/24"
}

variable "CIDR_PUBLIC" {
  default = "10.0.101.0/24,10.0.102.0/24"
}

variable "DOMAIN_ZONE_ID" {
  default = "Z1YNROBTIF0N37"
}

variable "PROD_DNS_HOST" {
  default = "tempcheck.trylinux.org"
}

variable "ECR_REPO_URL" {
  default = "226671803964.dkr.ecr.us-east-1.amazonaws.com/myapp"
}
