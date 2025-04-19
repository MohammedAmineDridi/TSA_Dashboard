#!/bin/bash

IMAGE_NAME="dashboard_web_app"
CONTAINER_NAME="tsa_dashboard"

# Use first argument as PORT, fallback to 3333 if not provided
PORT=${1:-3333}

echo "🛑 Stopping all running containers..."
docker ps -q | xargs -r docker stop

echo "🧹 Removing all containers..."
docker ps -aq | xargs -r docker rm

echo "🚀 Building Docker image: $IMAGE_NAME"
docker build -t $IMAGE_NAME .

echo "🧹 Removing any existing container named $CONTAINER_NAME"
docker rm -f $CONTAINER_NAME 2>/dev/null || true

echo "🏃 Running Docker container on port $PORT"
docker run -d -p "$PORT":80 --name $CONTAINER_NAME $IMAGE_NAME

echo "✅ App is now running at: http://localhost:$PORT"
echo "📜 Showing container logs (Ctrl+C to stop logs, app keeps running):"
echo ""

docker logs -f $CONTAINER_NAME
