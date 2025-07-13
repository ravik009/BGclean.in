#!/bin/bash

# BGclean Docker Deployment Script

set -e

echo "🐳 Starting BGclean Docker Deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    print_error "Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Create uploads directory if it doesn't exist
if [ ! -d "./uploads" ]; then
    print_status "Creating uploads directory..."
    mkdir -p ./uploads
fi

# Function to deploy with Docker Compose
deploy_compose() {
    local compose_file=$1
    local profile=$2
    
    print_status "Deploying with Docker Compose using $compose_file..."
    
    if [ -n "$profile" ]; then
        docker-compose -f $compose_file --profile $profile up -d --build
    else
        docker-compose -f $compose_file up -d --build
    fi
    
    print_status "Deployment completed successfully!"
    print_status "Application is running on http://localhost:7860"
}

# Function to deploy with Docker directly
deploy_docker() {
    print_status "Deploying with Docker directly..."
    
    # Build the image
    print_status "Building Docker image..."
    docker build -t bgclean .
    
    # Stop and remove existing container if it exists
    if docker ps -a --format 'table {{.Names}}' | grep -q "bgclean-app"; then
        print_status "Stopping existing container..."
        docker stop bgclean-app || true
        docker rm bgclean-app || true
    fi
    
    # Run the container
    print_status "Starting container..."
    docker run -d \
        --name bgclean-app \
        -p 7860:7860 \
        -v $(pwd)/uploads:/app/uploads \
        --restart unless-stopped \
        bgclean
    
    print_status "Deployment completed successfully!"
    print_status "Application is running on http://localhost:7860"
}

# Function to show logs
show_logs() {
    print_status "Showing application logs..."
    if [ -f "docker-compose.yml" ]; then
        docker-compose logs -f bgclean
    else
        docker logs -f bgclean-app
    fi
}

# Function to stop deployment
stop_deployment() {
    print_status "Stopping deployment..."
    if [ -f "docker-compose.yml" ]; then
        docker-compose down
    else
        docker stop bgclean-app || true
        docker rm bgclean-app || true
    fi
    print_status "Deployment stopped."
}

# Function to clean up
cleanup() {
    print_status "Cleaning up Docker resources..."
    docker system prune -f
    print_status "Cleanup completed."
}

# Function to show status
show_status() {
    print_status "Checking deployment status..."
    if [ -f "docker-compose.yml" ]; then
        docker-compose ps
    else
        docker ps --filter "name=bgclean-app"
    fi
}

# Main script logic
case "${1:-deploy}" in
    "deploy")
        if [ -f "docker-compose.yml" ]; then
            deploy_compose "docker-compose.yml"
        else
            deploy_docker
        fi
        ;;
    "deploy-prod")
        if [ -f "docker-compose.prod.yml" ]; then
            deploy_compose "docker-compose.prod.yml"
        else
            print_error "Production compose file not found."
            exit 1
        fi
        ;;
    "deploy-proxy")
        if [ -f "docker-compose.prod.yml" ]; then
            deploy_compose "docker-compose.prod.yml" "proxy"
        else
            print_error "Production compose file not found."
            exit 1
        fi
        ;;
    "logs")
        show_logs
        ;;
    "stop")
        stop_deployment
        ;;
    "status")
        show_status
        ;;
    "cleanup")
        cleanup
        ;;
    "restart")
        stop_deployment
        sleep 2
        if [ -f "docker-compose.yml" ]; then
            deploy_compose "docker-compose.yml"
        else
            deploy_docker
        fi
        ;;
    *)
        echo "Usage: $0 {deploy|deploy-prod|deploy-proxy|logs|stop|status|cleanup|restart}"
        echo ""
        echo "Commands:"
        echo "  deploy       - Deploy with Docker Compose (default)"
        echo "  deploy-prod  - Deploy production version"
        echo "  deploy-proxy - Deploy with nginx reverse proxy"
        echo "  logs         - Show application logs"
        echo "  stop         - Stop the deployment"
        echo "  status       - Show deployment status"
        echo "  cleanup      - Clean up Docker resources"
        echo "  restart      - Restart the deployment"
        exit 1
        ;;
esac 