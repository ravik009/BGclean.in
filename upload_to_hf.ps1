# Hugging Face Spaces Upload Script

Write-Host "🚀 Hugging Face Spaces पर BGclean Upload कर रहे हैं..." -ForegroundColor Green

# Function to print status
function Write-Status {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Green
}

function Write-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

# Get Hugging Face username
$HF_USERNAME = Read-Host "Hugging Face username enter करें"

if ([string]::IsNullOrEmpty($HF_USERNAME)) {
    Write-Error "Username required है!"
    exit 1
}

Write-Status "Username: $HF_USERNAME"

# Check if huggingface_hub is installed
try {
    python -c "import huggingface_hub" 2>$null
} catch {
    Write-Status "Hugging Face CLI install कर रहे हैं..."
    pip install huggingface_hub
}

# Login to Hugging Face
Write-Status "Hugging Face पर login कर रहे हैं..."
huggingface-cli login

if ($LASTEXITCODE -ne 0) {
    Write-Error "Login failed! Token check करें।"
    exit 1
}

# Create Space
Write-Status "Space create कर रहे हैं..."
huggingface-cli repo create bgclean --type space --space-sdk flask

if ($LASTEXITCODE -ne 0) {
    Write-Error "Space creation failed! Username check करें।"
    exit 1
}

# Upload files
Write-Status "Files upload कर रहे हैं..."

$files = @("app.py", "requirements.txt", "README.md")
$folders = @("templates", "Static")

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Status "Uploading $file..."
        huggingface-cli upload $HF_USERNAME/bgclean $file
    }
}

foreach ($folder in $folders) {
    if (Test-Path $folder) {
        Write-Status "Uploading $folder..."
        huggingface-cli upload $HF_USERNAME/bgclean $folder
    }
}

Write-Status "✅ Success! Space created successfully!"
Write-Status "🌐 आपका app यहाँ available है:"
Write-Host "   https://huggingface.co/spaces/$HF_USERNAME/bgclean" -ForegroundColor Cyan 