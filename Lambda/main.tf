terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"  # Specify a version range or exact version
    }
  }
  required_version = ">= 1.0"  # Optionally specify a minimum Terraform version
}


provider "aws" {
  region = "ap-south-1"  # Update to your desired region
  version = "~> 4.0"  # Example version constraint
}


# Replace with the ARN of your existing IAM role
data "aws_iam_role" "IAMRoleWithLamdaFullS3Access" {
  name = "LamdaFullS3Access"  # Replace with your IAM role name
}
data "archive_file" "PythonLambdaPackage" {
  type = "zip"  
  source_file = "LambdaFile.py"
  output_path = "LambdaFile.zip"
}

# Lambda Function
resource "aws_lambda_function" "my_lambda" {
  function_name = "MyLambdaFunction"
  role          = data.aws_iam_role.IAMRoleWithLamdaFullS3Access.arn  # Use the ARN of the existing role
  handler       = "index.handler"  # Your Lambda function entry point (adjust as needed)
  runtime       = "python3.8"     # Update this to the appropriate runtime (e.g., python3.8, etc.)
  timeout       = 300               # Timeout in seconds
  memory_size   = 128              # Memory allocated for the Lambda function

  # Path to your Lambda function deployment package
  filename = "LambdaFile.zip"  # Path to your Lambda deployment package

  environment {
    variables = {
      EXAMPLE_VAR = "value"
    }
  }
}
