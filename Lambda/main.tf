provider "aws" {
  region = "ap-south-1"  # Update to your desired region
}

# Replace with the ARN of your existing IAM role
data "aws_iam_role" "IAMRoleWithLamdaFullS3Access" {
  role_name = "LamdaFullS3Access"  # Replace with your IAM role name
}

# Lambda Function
resource "aws_lambda_function" "my_lambda" {
  function_name = "MyLambdaFunction"
  role          = data.aws_iam_role.existing_lambda_role.arn  # Use the ARN of the existing role
  handler       = "index.handler"  # Your Lambda function entry point (adjust as needed)
  runtime       = "python3.9"     # Update this to the appropriate runtime (e.g., python3.8, etc.)
  timeout       = 300               # Timeout in seconds
  memory_size   = 128              # Memory allocated for the Lambda function

  # Path to your Lambda function deployment package
  filename = "lambda_function_payload.zip"  # Path to your Lambda deployment package

  environment {
    variables = {
      EXAMPLE_VAR = "value"
    }
  }
}
