# Docker Hub Upload Script for Windows PowerShell

Write-Host "🐳 Docker Hub पर BGclean Project Upload कर रहे हैं..." -ForegroundColor Green

# Function to print status
function Write-Status {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Green
}

function Write-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

# Check if Docker is running
try {
    docker info | Out-Null
} catch {
    Write-Error "Docker नहीं चल रहा है। Docker Desktop start करें।"
    exit 1
}

# Get Docker username
$DOCKER_USERNAME = Read-Host "Docker Hub username enter करें"

if ([string]::IsNullOrEmpty($DOCKER_USERNAME)) {
    Write-Error "Username required है!"
    exit 1
}

Write-Status "Username: $DOCKER_USERNAME"

# Login to Docker Hub
Write-Status "Docker Hub पर login कर रहे हैं..."
docker login

if ($LASTEXITCODE -ne 0) {
    Write-Error "Login failed! Username/Password check करें।"
    exit 1
}

# Build the image
Write-Status "Docker image build कर रहे हैं..."
docker build -t $DOCKER_USERNAME/bgclean:latest .

if ($LASTEXITCODE -ne 0) {
    Write-Error "Build failed! Error check करें।"
    exit 1
}

# Push to Docker Hub
Write-Status "Docker Hub पर push कर रहे हैं..."
docker push $DOCKER_USERNAME/bgclean:latest

if ($LASTEXITCODE -eq 0) {
    Write-Status "✅ Success! Image uploaded successfully!"
    Write-Status "🌐 आपका app अब यहाँ available है:"
    Write-Host "   docker run -p 7860:7860 $DOCKER_USERNAME/bgclean:latest" -ForegroundColor Cyan
    Write-Host ""
    Write-Status "📱 कहीं भी deploy करने के लिए:"
    Write-Host "   docker run -d -p 7860:7860 --name bgclean-app $DOCKER_USERNAME/bgclean:latest" -ForegroundColor Cyan
} else {
    Write-Error "❌ Push failed! Error check करें।"
    exit 1
} 