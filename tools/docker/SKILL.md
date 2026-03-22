---
name: docker-cli
description: Use the Docker CLI to build images, run containers, manage volumes, networks, and use Docker Compose for multi-container applications.
---

# Docker CLI

Container runtime and management tool. Build images, run containers, manage networks, volumes, and orchestrate with Compose.

- **Official repo:** https://github.com/docker/cli
- **Docs:** https://docs.docker.com/reference/cli/docker/

## Common Commands

### Images
```bash
docker build -t my-app:latest .
docker build -t my-app:latest -f Dockerfile.prod .
docker images
docker image prune -f                    # Remove dangling images
docker pull nginx:latest
docker push registry.example.com/my-app:latest
docker tag my-app:latest registry.example.com/my-app:v1
```

### Containers
```bash
docker run -d --name my-app -p 3000:3000 my-app:latest
docker run -it --rm ubuntu:latest bash    # Interactive, auto-remove
docker run -d -v $(pwd):/app -w /app node:20 npm start
docker ps                                 # Running containers
docker ps -a                              # All containers
docker logs my-app --follow --tail 50
docker exec -it my-app bash               # Shell into container
docker stop my-app
docker rm my-app
docker inspect my-app
```

### Docker Compose
```bash
docker compose up -d                      # Start all services
docker compose up -d --build              # Rebuild and start
docker compose down                       # Stop and remove
docker compose logs -f service-name       # Follow service logs
docker compose ps                         # List services
docker compose exec service-name bash     # Shell into service
docker compose pull                       # Pull latest images
```

### Volumes and Networks
```bash
docker volume ls
docker volume create my-data
docker network ls
docker network create my-network
```

### System
```bash
docker system df                          # Disk usage
docker system prune -f                    # Clean up everything unused
docker stats                              # Live resource usage
```

## Agent Best Practices

- Use `-d` (detach) for background containers, `--rm` for temporary ones
- Use `docker compose` over individual `docker run` for multi-service apps
- Always tag images with specific versions, not just `latest`
- Use `docker logs --tail 50` to limit log output
- Use `docker inspect --format '{{.State.Status}}'` for specific fields
- Use `docker compose --profile test up` for conditional services
- Pipe `docker ps --format json` for structured output

## Example Workflows

### Build and run a dev container
```bash
docker build -t my-app:dev .
docker run -d --name my-app -p 3000:3000 -v $(pwd)/src:/app/src my-app:dev
docker logs my-app --follow
```

### Clean up all stopped containers and unused images
```bash
docker system prune -af --volumes
```
