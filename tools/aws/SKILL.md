---
name: aws-cli
description: Use the AWS CLI to manage S3 buckets, Lambda functions, EC2 instances, IAM, DynamoDB, and all AWS services from the terminal. Use this instead of the AWS MCP server.
---

# AWS CLI

Official CLI for Amazon Web Services. Manage all AWS services from the terminal.

- **Official repo:** https://github.com/aws/aws-cli
- **Docs:** https://docs.aws.amazon.com/cli/

## Authentication

```bash
aws configure                        # Set up credentials interactively
aws configure --profile staging      # Configure named profile
aws sts get-caller-identity          # Verify current identity
aws sso login --profile my-sso       # SSO-based login
```

Environment variables: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_DEFAULT_REGION`

## Common Commands

### S3
```bash
aws s3 ls                                    # List buckets
aws s3 ls s3://my-bucket/                    # List objects
aws s3 cp file.txt s3://my-bucket/           # Upload file
aws s3 cp s3://my-bucket/file.txt ./         # Download file
aws s3 sync ./dist s3://my-bucket/ --delete  # Sync directory
aws s3 rm s3://my-bucket/file.txt            # Delete object
aws s3 mb s3://new-bucket                    # Create bucket
```

### Lambda
```bash
aws lambda list-functions --query 'Functions[].FunctionName'
aws lambda invoke --function-name my-func --payload '{}' output.json
aws lambda update-function-code --function-name my-func --zip-file fileb://deploy.zip
aws lambda get-function --function-name my-func
aws logs tail /aws/lambda/my-func --follow   # Tail CloudWatch logs
```

### EC2
```bash
aws ec2 describe-instances --query 'Reservations[].Instances[].[InstanceId,State.Name,PublicIpAddress]' --output table
aws ec2 start-instances --instance-ids i-xxx
aws ec2 stop-instances --instance-ids i-xxx
```

### IAM
```bash
aws iam list-users
aws iam list-roles --query 'Roles[].RoleName'
aws iam get-role --role-name my-role
```

### DynamoDB
```bash
aws dynamodb list-tables
aws dynamodb scan --table-name my-table --max-items 10
aws dynamodb put-item --table-name my-table --item '{"id":{"S":"123"}}'
aws dynamodb query --table-name my-table --key-condition-expression "id = :v" --expression-attribute-values '{":v":{"S":"123"}}'
```

### CloudFormation
```bash
aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE
aws cloudformation describe-stacks --stack-name my-stack
```

## Agent Best Practices

- Always use `--output json` with `--query` (JMESPath) for structured output
- Use `--dry-run` flag where available before destructive operations
- Use `--profile` to target specific accounts
- Use `aws sts get-caller-identity` to confirm which account you're operating on
- Prefer `aws s3` (high-level) over `aws s3api` (low-level) for common operations
- Use `--no-paginate` or `--max-items` to control output size

## Example Workflows

### Deploy static site to S3
```bash
aws s3 sync ./build s3://my-site-bucket/ --delete
aws cloudfront create-invalidation --distribution-id E1234 --paths "/*"
```

### Check Lambda function status
```bash
aws lambda get-function --function-name my-func --query 'Configuration.{State:State,Runtime:Runtime,Memory:MemorySize}' --output table
```
