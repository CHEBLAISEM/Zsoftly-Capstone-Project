terraform {
  backend "s3" {
    bucket  = "zsoftly-capstone-bucket123"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
