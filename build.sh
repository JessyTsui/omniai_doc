#!/bin/bash
set -euo pipefail

TAG=${1:-latest}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker is not running"
    exit 1
fi

# Verify Dockerfile exists
if [ ! -f "./docker/Dockerfile" ]; then
    echo "Error: Dockerfile not found at ./docker/Dockerfile"
    exit 1
fi

echo "Building OmniAI Documentation Docker image..."
echo "Tag: omniai-doc:$TAG"

docker build \
    --platform linux/amd64 \
    -t "omniai-doc:$TAG" \
    -f ./docker/Dockerfile \
    --progress=plain \
    .

if [ $? -eq 0 ]; then
    echo "Build successful!"
    echo "Image: omniai-doc:$TAG"
    echo "To run: ./dev.sh $TAG"
else
    echo "Build failed!"
    exit 1
fi
