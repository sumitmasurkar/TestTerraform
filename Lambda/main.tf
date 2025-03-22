#terraform {
#  required_providers {
#    aws = {
#      source  = "hashicorp/aws"
#      version = "~> 4.0"  # Specify a version range or exact version
#    }
#  }
#  required_version = ">= 1.0"  # Optionally specify a minimum Terraform version
#}


#provider "aws" {
#  region = "ap-south-1"  # Update to your desired region
#  version = "~> 4.0"  # Example version constraint
#}


# Replace with the ARN of your existing IAM role
#data "aws_iam_role" "IAMRoleWithLamdaFullS3Access" {
#  name = "LamdaFullS3Access"  # Replace with your IAM role name
#}
#data "archive_file" "PythonLambdaPackage" {
#  type = "zip"  
#  source_file = "LambdaFile.py"
#  output_path = "LambdaFile.zip"
#}

# Lambda Function
#resource "aws_lambda_function" "my_lambda" {
#  function_name = "MyLambdaFunction"
#  role          = data.aws_iam_role.IAMRoleWithLamdaFullS3Access.arn  # Use the ARN of the existing role
#  handler       = "index.handler"  # Your Lambda function entry point (adjust as needed)
#  runtime       = "python3.8"     # Update this to the appropriate runtime (e.g., python3.8, etc.)
##  timeout       = 300               # Timeout in seconds
##  memory_size   = 128              # Memory allocated for the Lambda function

  # Path to your Lambda function deployment package
#  filename = "LambdaFile.zip"  # Path to your Lambda deployment package

#  environment {
#    variables = {
#      EXAMPLE_VAR = "value"
#    }
# }
#}




# Provider configuration
provider "aws" {
  region = "ap-south-1"  # Update to your desired region
  version = "~> 4.0"  # Example version constraint
}

# Define the security group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create the EC2 instance
resource "aws_instance" "my_ec2" {
  ami           = "ami-05c179eced2eb9b5b"  # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"               # Instance type, for example, t2.micro
  key_name      = "mywebserver"       # The name of the key pair in AWS

  # Associate the security group
  security_groups = [aws_security_group.allow_ssh.test]

  # Tag the instance
  tags = {
    Name = "MyEC2InstanceUsingTF"
  }
}
