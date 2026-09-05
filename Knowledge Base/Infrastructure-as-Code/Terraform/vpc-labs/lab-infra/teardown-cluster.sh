#!/usr/bin/env bash
set -euo pipefail

export PATH="$HOME/.docker/bin:/opt/homebrew/bin:$PATH"
CLUSTER_NAME="vpc-labs"

echo "🧹 Tearing down Kind cluster '${CLUSTER_NAME}'..."
if kind get clusters 2>&1 | grep -q "^${CLUSTER_NAME}$"; then
  kind delete cluster --name "${CLUSTER_NAME}"
  echo "✅ Kind cluster '${CLUSTER_NAME}' deleted."
else
  echo "ℹ️  Kind cluster '${CLUSTER_NAME}' does not exist."
fi
