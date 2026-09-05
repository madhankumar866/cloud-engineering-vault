#!/usr/bin/env bash
set -euo pipefail

# Ensure docker and kind are in PATH
export PATH="$HOME/.docker/bin:/opt/homebrew/bin:$PATH"

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLUSTER_NAME="vpc-labs"

echo "============================================================"
echo "🚀 Spinning up Kind Cluster & MiniStack for Terraform VPC Labs"
echo "============================================================"

# 1. Check Docker Daemon
if ! docker ps > /dev/null 2>&1; then
  echo "❌ Error: Docker daemon is not running or accessible."
  echo "Please start Docker Desktop and ensure ~/.docker/bin is in your PATH."
  exit 1
fi
echo "✅ Docker daemon is active."

# 2. Check or Create Kind Cluster
if kind get clusters 2>&1 | grep -q "^${CLUSTER_NAME}$"; then
  echo "ℹ️  Kind cluster '${CLUSTER_NAME}' already exists."
else
  echo "📦 Creating Kind cluster '${CLUSTER_NAME}' from kind-config.yaml..."
  kind create cluster --config "${DIR}/kind-config.yaml"
  echo "✅ Kind cluster '${CLUSTER_NAME}' created."
fi

# 3. Pull MiniStack image directly inside Kind nodes (faster & avoids Docker Desktop containerd export bugs)
echo "🔄 Ensuring ministackorg/ministack:latest is present on Kind nodes..."
docker exec "${CLUSTER_NAME}-control-plane" crictl pull ministackorg/ministack:latest
docker exec "${CLUSTER_NAME}-worker" crictl pull ministackorg/ministack:latest || true
echo "✅ Image ready on Kind nodes."

# 4. Apply Kubernetes Manifests
echo "📄 Deploying MiniStack into Kubernetes namespace 'lab-infra'..."
kubectl apply -f "${DIR}/ministack-k8s.yaml"

# 5. Wait for MiniStack to be ready
echo "⏳ Waiting for MiniStack deployment to be ready..."
kubectl rollout status deployment/ministack -n lab-infra --timeout=90s

# 6. Verify Health Endpoint
echo "🔍 Testing MiniStack health check on http://localhost:4566/_ministack/health..."
for i in {1..15}; do
  if curl -s http://localhost:4566/_ministack/health > /dev/null 2>&1; then
    echo "✅ MiniStack is healthy and responding on http://localhost:4566!"
    break
  fi
  sleep 2
done

echo ""
echo "============================================================"
echo "🎉 Lab Infrastructure is Ready!"
echo "============================================================"
echo "• Kind Cluster:    ${CLUSTER_NAME}"
echo "• K8s Namespace:   lab-infra"
echo "• AWS Endpoint:    http://localhost:4566"
echo "• Region:          ap-south-1"
echo ""
echo "You can now cd into any lab folder (e.g. lab-1) and run:"
echo "  terraform init"
echo "  terraform plan"
echo "  terraform apply -auto-approve"
echo "============================================================"
