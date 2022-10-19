locals {
  use_dynamodb = true
}

resource "aws_dynamodb_table" "table" {
  count            = local.use_dynamodb ? 1 : 0
  name             = var.AWS_LAMBDA_NAME
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  hash_key         = "pk"
  range_key        = "sk"

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }
}
