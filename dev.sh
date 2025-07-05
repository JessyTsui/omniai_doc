#!/bin/bash
set -euo pipefail

TAG=${1:-latest}
PORT=${PORT:-5000}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker is not running"
    exit 1
fi

# Check if image exists
if ! docker image inspect "omniai-doc:$TAG" > /dev/null 2>&1; then
    echo "Error: Docker image 'omniai-doc:$TAG' not found"
    echo "Please run build.sh first"
    exit 1
fi

echo "Starting OmniAI Documentation server..."
echo "Please visit http://localhost:$PORT"

docker run --rm -it \
    -p "$PORT:8080" \
    --name omniai-doc-dev \
    "omniai-doc:$TAG"
