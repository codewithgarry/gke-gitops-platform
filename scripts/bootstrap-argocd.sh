#!/usr/bin/env bash
# Installs Argo CD on the cluster and hands control to Git (app of apps).
# Usage: ./scripts/bootstrap-argocd.sh <project-id> [zone] [cluster]
set -euo pipefail

PROJECT_ID=${1:?usage: $0 <project-id> [zone] [cluster]}
ZONE=${2:-asia-south1-a}
CLUSTER=${3:-gitops-platform}
ARGOCD_CHART_VERSION=7.7.0
ROOT=$(cd "$(dirname "$0")/.." && pwd)

gcloud container clusters get-credentials "$CLUSTER" --zone "$ZONE" --project "$PROJECT_ID"

helm repo add argo https://argoproj.github.io/argo-helm >/dev/null
helm repo update argo >/dev/null

helm upgrade --install argocd argo/argo-cd \
  --namespace argocd --create-namespace \
  --version "$ARGOCD_CHART_VERSION" \
  --values "$ROOT/gitops/bootstrap/argocd-values.yaml" \
  --wait

kubectl apply -f "$ROOT/gitops/bootstrap/root-app.yaml"

echo
echo "Argo CD admin password:"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo
echo
echo "UI: kubectl -n argocd port-forward svc/argocd-server 8080:443  →  https://localhost:8080"
