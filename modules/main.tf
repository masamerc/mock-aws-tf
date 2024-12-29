resource aws_s3_bucket "another_bucket" {
  bucket = "another-bucket"
}

locals {
  account_maps = {
    todd = "111111111111"
    james = "222222222222"
    alice = "333333333333"
    dottie = "444444444444"
  }
}

resource aws_s3_bucket "the-accounts" {
  for_each = local.account_maps
  bucket   = "${each.key}-bucket-${each.value}"
}

locals {
  cidrs = [
    "244.178.0.0/16",
    "10.0.0.0/16",
    "110.0.0.0/16",
  ]
}


resource "aws_vpc" "main" {
  for_each = toset(local.cidrs)
  cidr_block = each.value # key and value are the same for sets
  instance_tenancy = "default"
}
