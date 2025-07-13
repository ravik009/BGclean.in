#!/bin/bash

# Docker Hub Upload Script for BGclean

echo "🐳 Docker Hub पर BGclean Project Upload कर रहे हैं..."

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Function to print status
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    print_error "Docker नहीं चल रहा है। Docker Desktop start करें।"
    exit 1
fi

# Get Docker username
echo "Docker Hub username enter करें:"
read DOCKER_USERNAME

if [ -z "$DOCKER_USERNAME" ]; then
    print_error "Username required है!"
    exit 1
fi

print_status "Username: $DOCKER_USERNAME"

# Login to Docker Hub
print_status "Docker Hub पर login कर रहे हैं..."
docker login

if [ $? -ne 0 ]; then
    print_error "Login failed! Username/Password check करें।"
    exit 1
fi

# Build the image
print_status "Docker image build कर रहे हैं..."
docker build -t $DOCKER_USERNAME/bgclean:latest .

if [ $? -ne 0 ]; then
    print_error "Build failed! Error check करें।"
    exit 1
fi

# Push to Docker Hub
print_status "Docker Hub पर push कर रहे हैं..."
docker push $DOCKER_USERNAME/bgclean:latest

if [ $? -eq 0 ]; then
    print_status "✅ Success! Image uploaded successfully!"
    print_status "🌐 आपका app अब यहाँ available है:"
    echo "   docker run -p 7860:7860 $DOCKER_USERNAME/bgclean:latest"
    echo ""
    print_status "📱 कहीं भी deploy करने के लिए:"
    echo "   docker run -d -p 7860:7860 --name bgclean-app $DOCKER_USERNAME/bgclean:latest"
else
    print_error "❌ Push failed! Error check करें।"
    exit 1
fi 