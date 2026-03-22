---
name: kubectl-cli
description: Use kubectl to manage Kubernetes clusters, deploy applications, inspect pods, view logs, and manage resources.
---

# kubectl (Kubernetes CLI)

Official CLI for Kubernetes. Manage clusters, deployments, pods, services, and configurations.

- **Official repo:** https://github.com/kubernetes/kubectl
- **Docs:** https://kubernetes.io/docs/reference/kubectl/

## Configuration

```bash
kubectl config current-context            # Show active cluster
kubectl config get-contexts               # List all contexts
kubectl config use-context my-cluster     # Switch context
kubectl cluster-info                      # Show cluster info
```

## Common Commands

### Viewing Resources
```bash
kubectl get pods                          # List pods in default namespace
kubectl get pods -A                       # All namespaces
kubectl get pods -n my-namespace          # Specific namespace
kubectl get deployments
kubectl get services
kubectl get nodes
kubectl get all                           # All resource types
kubectl describe pod my-pod               # Detailed pod info
kubectl top pods                          # Resource usage
```

### Deploying
```bash
kubectl apply -f manifest.yaml            # Apply config
kubectl apply -f ./k8s/                   # Apply directory of configs
kubectl create deployment my-app --image=my-app:latest
kubectl set image deployment/my-app my-app=my-app:v2   # Update image
kubectl rollout status deployment/my-app
kubectl rollout undo deployment/my-app    # Rollback
kubectl scale deployment/my-app --replicas=3
```

### Debugging
```bash
kubectl logs my-pod                       # Pod logs
kubectl logs my-pod -c my-container       # Specific container
kubectl logs -f my-pod --tail=100         # Follow logs
kubectl exec -it my-pod -- bash           # Shell into pod
kubectl port-forward my-pod 8080:80       # Port forward
kubectl get events --sort-by='.lastTimestamp'
```

### Managing Resources
```bash
kubectl delete pod my-pod
kubectl delete -f manifest.yaml
kubectl edit deployment my-app
kubectl patch deployment my-app -p '{"spec":{"replicas":2}}'
```

## Agent Best Practices

- Use `-o json` or `-o jsonpath` for structured output
- Always specify namespace with `-n` to avoid mistakes
- Use `kubectl diff -f manifest.yaml` before `apply` to preview changes
- Use `--dry-run=client -o yaml` to generate manifests without applying
- Use `kubectl get pods -o wide` for node placement info
- Watch resources with `kubectl get pods -w` for real-time updates
- Use labels: `kubectl get pods -l app=my-app`

## Example Workflows

### Check deployment health
```bash
kubectl rollout status deployment/my-app
kubectl get pods -l app=my-app -o json | jq '.items[] | {name: .metadata.name, status: .status.phase}'
```

### Debug a crashing pod
```bash
kubectl describe pod my-pod | tail -20
kubectl logs my-pod --previous --tail=50
```
