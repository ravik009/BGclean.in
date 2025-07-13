# Docker Deployment Guide for BGclean

## 🐳 Docker Files Created

- `Dockerfile` - Main Docker image configuration
- `docker-compose.yml` - Multi-container deployment
- `.dockerignore` - Files to exclude from Docker build

## 🚀 Quick Start with Docker

### Option 1: Using Docker Compose (Recommended)

1. **Build and run with Docker Compose:**
```bash
docker-compose up --build
```

2. **Run in background:**
```bash
docker-compose up -d --build
```

3. **Stop the application:**
```bash
docker-compose down
```

### Option 2: Using Docker directly

1. **Build the Docker image:**
```bash
docker build -t bgclean .
```

2. **Run the container:**
```bash
docker run -p 7860:7860 bgclean
```

3. **Run in background:**
```bash
docker run -d -p 7860:7860 --name bgclean-app bgclean
```

## 📁 Volume Mounts

The Docker setup includes volume mounts for:
- `./uploads:/app/uploads` - Uploaded files
- `model_cache:/root/.u2net` - AI model cache

## 🔧 Environment Variables

You can customize the deployment with these environment variables:

```bash
# In docker-compose.yml or docker run command
- PORT=7860                    # Application port
- PYTHONUNBUFFERED=1          # Python output buffering
```

## 🐳 Docker Commands Reference

### Build Commands
```bash
# Build image
docker build -t bgclean .

# Build with no cache
docker build --no-cache -t bgclean .

# Build with specific platform
docker build --platform linux/amd64 -t bgclean .
```

### Run Commands
```bash
# Run container
docker run -p 7860:7860 bgclean

# Run with custom port
docker run -p 8080:7860 bgclean

# Run with volume mounts
docker run -p 7860:7860 -v $(pwd)/uploads:/app/uploads bgclean

# Run with environment variables
docker run -p 7860:7860 -e PORT=8000 bgclean
```

### Management Commands
```bash
# List running containers
docker ps

# Stop container
docker stop bgclean-app

# Remove container
docker rm bgclean-app

# View logs
docker logs bgclean-app

# Execute commands in container
docker exec -it bgclean-app bash
```

## 🚀 Production Deployment

### Using Docker Compose for Production

1. **Create production docker-compose file:**
```yaml
version: '3.8'
services:
  bgclean:
    build: .
    ports:
      - "80:7860"  # Map to port 80
    environment:
      - PORT=7860
    volumes:
      - ./uploads:/app/uploads
      - model_cache:/root/.u2net
    restart: always
    deploy:
      resources:
        limits:
          memory: 2G
        reservations:
          memory: 1G

volumes:
  model_cache:
```

2. **Run production deployment:**
```bash
docker-compose -f docker-compose.prod.yml up -d
```

### Using Docker Swarm

1. **Initialize Docker Swarm:**
```bash
docker swarm init
```

2. **Deploy stack:**
```bash
docker stack deploy -c docker-compose.yml bgclean
```

## 🔍 Monitoring and Logs

### View Application Logs
```bash
# Docker Compose
docker-compose logs -f bgclean

# Docker
docker logs -f bgclean-app
```

### Health Check
The container includes a health check that monitors the application:
```bash
# Check container health
docker ps --format "table {{.Names}}\t{{.Status}}"
```

## 🛠️ Troubleshooting

### Common Issues:

1. **Port already in use:**
```bash
# Check what's using the port
lsof -i :7860

# Use different port
docker run -p 8080:7860 bgclean
```

2. **Permission issues:**
```bash
# Fix volume permissions
sudo chown -R $USER:$USER ./uploads
```

3. **Memory issues:**
```bash
# Increase memory limit
docker run -m 2g -p 7860:7860 bgclean
```

4. **Build fails:**
```bash
# Clean build
docker system prune -a
docker build --no-cache -t bgclean .
```

## 📊 Performance Optimization

### Resource Limits
```yaml
# In docker-compose.yml
services:
  bgclean:
    deploy:
      resources:
        limits:
          memory: 2G
          cpus: '1.0'
        reservations:
          memory: 1G
          cpus: '0.5'
```

### Multi-stage Build (Optional)
For smaller images, you can use multi-stage builds:

```dockerfile
# Build stage
FROM python:3.10-slim as builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Runtime stage
FROM python:3.10-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY . .
ENV PATH=/root/.local/bin:$PATH
EXPOSE 7860
CMD ["python", "app.py"]
```

## 🔒 Security Considerations

1. **Run as non-root user:**
```dockerfile
RUN useradd -m -u 1000 appuser
USER appuser
```

2. **Use specific base image versions**
3. **Scan for vulnerabilities:**
```bash
docker scan bgclean
```

## 📝 Next Steps

1. **Test locally** with Docker Compose
2. **Deploy to production** server
3. **Set up monitoring** and logging
4. **Configure reverse proxy** (nginx/apache)
5. **Set up SSL certificates**

Your application is now ready for Docker deployment! 🎉 