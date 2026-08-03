#!/usr/bin/env zsh
# setup_k8s_offline_docs.sh
# Automated sparse shallow clone of official Kubernetes documentation and YAML examples
# Engineered for macOS DevOps workflow without vault git history pollution.

set -e

DEST_DIR="$HOME/.local/share/k8s-offline-docs"
REPO_URL="https://github.com/kubernetes/website.git"

echo "🚀 Starting automated sparse shallow checkout of Kubernetes Official Documentation..."

if [ -d "$DEST_DIR/.git" ]; then
    echo "⚡ Repository already exists at $DEST_DIR. Updating..."
    cd "$DEST_DIR"
    git pull --depth=1 origin main
    echo "✅ Update complete!"
    exit 0
fi

mkdir -p "$HOME/.local/share"
mkdir -p "$DEST_DIR"
cd "$DEST_DIR"

echo "📦 Initializing local Git repository at $DEST_DIR..."
git init -q
git remote add origin "$REPO_URL"

echo "🎯 Configuring Git Sparse Checkout for content/en/docs and content/en/examples..."
git config core.sparseCheckout true

cat <<EOF > .git/info/sparse-checkout
content/en/docs/*
content/en/examples/*
EOF

echo "⬇️  Pulling shallow documentation clone (--depth 1)... This takes just a few seconds..."
git pull -q --depth=1 origin main

echo "✅ Kubernetes Offline Documentation successfully installed!"
echo "📂 Disk footprint: $(du -sh "$DEST_DIR" | awk '{print $1}')"
echo "💡 You can now search offline using kdoc and kyaml commands!"
