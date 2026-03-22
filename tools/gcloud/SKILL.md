---
name: gcloud-cli
description: Use the Google Cloud CLI (gcloud) to manage GCP projects, compute instances, Cloud Run, Cloud Functions, GCS, and BigQuery. Use this instead of the Google Cloud MCP server.
---

# Google Cloud CLI (gcloud)

Official CLI for Google Cloud Platform. Manage all GCP services from the terminal.

- **Official repo:** https://github.com/google-cloud-sdk/google-cloud-sdk
- **Docs:** https://cloud.google.com/sdk/docs

## Authentication

```bash
gcloud auth login                      # Browser-based login
gcloud auth application-default login  # Set up ADC for libraries
gcloud auth list                       # List authenticated accounts
gcloud config set project PROJECT_ID   # Set active project
gcloud config list                     # Show current config
```

## Common Commands

### Projects
```bash
gcloud projects list
gcloud projects describe PROJECT_ID
gcloud config set project PROJECT_ID
```

### Compute Engine
```bash
gcloud compute instances list
gcloud compute instances create my-vm --machine-type=e2-medium --zone=us-central1-a
gcloud compute instances start my-vm --zone=us-central1-a
gcloud compute instances stop my-vm --zone=us-central1-a
gcloud compute ssh my-vm --zone=us-central1-a
```

### Cloud Run
```bash
gcloud run deploy my-service --source . --region us-central1
gcloud run services list
gcloud run services describe my-service --region us-central1
gcloud run services logs read my-service --region us-central1
```

### Cloud Functions
```bash
gcloud functions deploy my-func --runtime nodejs20 --trigger-http --entry-point handler
gcloud functions list
gcloud functions logs read my-func
gcloud functions call my-func --data '{"key":"value"}'
```

### Cloud Storage
```bash
gcloud storage ls
gcloud storage cp file.txt gs://my-bucket/
gcloud storage cp gs://my-bucket/file.txt ./
gcloud storage rm gs://my-bucket/file.txt
```

### BigQuery
```bash
bq ls                                    # List datasets
bq query --use_legacy_sql=false 'SELECT * FROM dataset.table LIMIT 10'
bq show dataset.table
```

## Agent Best Practices

- Use `--format=json` for machine-readable output
- Use `--quiet` to suppress interactive prompts
- Always check `gcloud config list` to confirm active project
- Use `--project=PROJECT_ID` flag to target specific projects without switching context
- Use `gcloud services enable SERVICE` to enable APIs before using them
- Filter with `--filter` flag: `gcloud compute instances list --filter="status=RUNNING"`

## Example Workflows

### Deploy to Cloud Run
```bash
gcloud run deploy my-app --source . --region us-central1 --allow-unauthenticated --quiet
```

### Get all running VMs
```bash
gcloud compute instances list --filter="status=RUNNING" --format="json" | jq '.[].name'
```
