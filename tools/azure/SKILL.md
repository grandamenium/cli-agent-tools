---
name: azure-cli
description: Use the Azure CLI (az) to manage Azure resources including App Service, Functions, VMs, storage, and databases. Use this instead of the Azure MCP server.
---

# Azure CLI (az)

Official CLI for Microsoft Azure. Manage all Azure services from the terminal.

- **Official repo:** https://github.com/Azure/azure-cli
- **Docs:** https://learn.microsoft.com/en-us/cli/azure/

## Authentication

```bash
az login                    # Browser-based login
az login --use-device-code  # Device code flow (headless)
az account show             # Show current subscription
az account list --output table
az account set --subscription SUB_ID
```

## Common Commands

### Resource Groups
```bash
az group list --output table
az group create --name my-rg --location eastus
az group delete --name my-rg --yes
```

### App Service
```bash
az webapp list --output table
az webapp create --resource-group my-rg --plan my-plan --name my-app --runtime "NODE:20-lts"
az webapp deploy --resource-group my-rg --name my-app --src-path ./app.zip
az webapp log tail --resource-group my-rg --name my-app
az webapp config appsettings set --resource-group my-rg --name my-app --settings KEY=value
```

### Functions
```bash
az functionapp list --output table
az functionapp create --resource-group my-rg --consumption-plan-location eastus --runtime node --name my-func --storage-account mystorage
func azure functionapp publish my-func
```

### Virtual Machines
```bash
az vm list --output table
az vm create --resource-group my-rg --name my-vm --image Ubuntu2204 --admin-username azureuser --generate-ssh-keys
az vm start --resource-group my-rg --name my-vm
az vm stop --resource-group my-rg --name my-vm
```

### Storage
```bash
az storage account list --output table
az storage blob upload --account-name mystorage --container-name mycontainer --file ./data.txt --name data.txt
az storage blob list --account-name mystorage --container-name mycontainer --output table
```

## Agent Best Practices

- Use `--output json` with `--query` (JMESPath) for structured output
- Use `--no-wait` for long-running operations to avoid blocking
- Always check `az account show` to confirm active subscription
- Use `--yes` flag to skip confirmation prompts in automation
- Use `az find "keyword"` to discover commands
- Use `az interactive` for command exploration (human use)

## Example Workflows

### Deploy a web app
```bash
az webapp up --resource-group my-rg --name my-app --runtime "NODE:20-lts" --sku F1
```

### List all resources in a resource group
```bash
az resource list --resource-group my-rg --output json --query '[].{name:name, type:type}'
```
