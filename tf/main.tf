resource "aws_iam_role" "iam_role" {
  name = "lambda_${var.AWS_LAMBDA_NAME}_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })

  inline_policy {
    name = "lambda_${var.AWS_LAMBDA_NAME}_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["logs:CreateLogGroup"]
          Effect   = "Allow"
          Resource = ["arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:*"]
        },
        {
          Action   = ["logs:CreateLogStream", "logs:PutLogEvents"]
          Effect   = "Allow"
          Resource = ["arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.AWS_LAMBDA_NAME}:*"]
        },
        {
          Effect = "Allow",
          Action = [
            "dynamodb:BatchGetItem",
            "dynamodb:BatchWriteItem",
            "dynamodb:PutItem",
            "dynamodb:DeleteItem",
            "dynamodb:GetItem",
            "dynamodb:Scan",
            "dynamodb:Query",
            "dynamodb:UpdateItem"
          ],
          Resource = [
            "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/${var.AWS_LAMBDA_NAME}"
          ]
        }
      ]
    })
  }
}

resource "aws_iam_role_policy_attachment" "attach_policy_vpc_access" {
  role       = aws_iam_role.iam_role.name
  policy_arn = data.aws_iam_policy.AWSLambdaVPCAccessExecutionRole.arn
}

resource "aws_lambda_function" "lambda" {
  architectures = ["arm64"]
  filename      = "${path.module}/../${var.AWS_LAMBDA_NAME}.zip"
  function_name = var.AWS_LAMBDA_NAME
  role          = aws_iam_role.iam_role.arn
  handler       = "lambda_function.lambda_handler"
  memory_size   = 512

  source_code_hash = filebase64sha256("${path.module}/../${var.AWS_LAMBDA_NAME}.zip")

  runtime = "python3.9"

  environment {
    variables = {
      AUTH = var.AUTH
    }
  }

  vpc_config {
    subnet_ids         = var.SUBNET_IDS
    security_group_ids = var.SECURITY_GROUP_IDS
  }
}

resource "aws_lambda_function_url" "lambda_url" {
  function_name      = aws_lambda_function.lambda.function_name
  authorization_type = "NONE"
}

