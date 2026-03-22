---
name: terraform-cli
description: Use Terraform CLI to define, plan, and provision infrastructure as code across any cloud provider. Use this instead of the Terraform MCP server.
---

# Terraform CLI

Infrastructure as code tool. Define cloud resources in HCL, plan changes, and apply them safely.

- **Official repo:** https://github.com/hashicorp/terraform
- **Docs:** https://developer.hashicorp.com/terraform/cli

## Core Workflow

```bash
terraform init        # Initialize working directory, download providers
terraform plan        # Preview changes
terraform apply       # Apply changes (with confirmation)
terraform apply -auto-approve  # Apply without confirmation
terraform destroy     # Destroy all managed resources
```

## Common Commands

### State Management
```bash
terraform state list                      # List all resources in state
terraform state show aws_instance.my_vm   # Show resource details
terraform state mv old_name new_name      # Rename resource
terraform state rm resource_name          # Remove from state (not destroyed)
terraform state pull                      # Download remote state
```

### Planning
```bash
terraform plan -out=plan.tfplan           # Save plan to file
terraform apply plan.tfplan               # Apply saved plan
terraform plan -target=aws_instance.my_vm # Plan specific resource
terraform plan -var="region=us-west-2"    # Pass variable
terraform plan -var-file=prod.tfvars      # Use variable file
```

### Workspace Management
```bash
terraform workspace list
terraform workspace new staging
terraform workspace select production
terraform workspace show
```

### Output and Formatting
```bash
terraform output                          # Show all outputs
terraform output -json                    # JSON format
terraform output db_endpoint              # Specific output
terraform fmt                             # Format HCL files
terraform validate                        # Validate configuration
```

### Import
```bash
terraform import aws_instance.my_vm i-1234567890abcdef0
```

## Agent Best Practices

- Always run `terraform plan` before `terraform apply` to preview changes
- Use `-out=plan.tfplan` to save plans and apply them exactly
- Use `-target` flag sparingly - only for debugging specific resources
- Use `terraform output -json` for machine-readable output
- Run `terraform fmt` before committing to keep consistent formatting
- Use `terraform validate` to check syntax without accessing providers
- Never store state files in git - use remote backends (S3, GCS, Terraform Cloud)
- Use `-auto-approve` only in automated pipelines, not for manual runs

## Example Workflows

### Initialize and deploy
```bash
terraform init
terraform plan -out=deploy.tfplan
terraform apply deploy.tfplan
```

### Check current infrastructure
```bash
terraform state list
terraform output -json | jq
```
