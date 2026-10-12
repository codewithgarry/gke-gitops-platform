#!/usr/bin/env bash
# Generates CPU load on demo-app so you can watch the HPA scale out.
# In a second terminal: kubectl -n demo get hpa,pods -w
set -euo pipefail
kubectl -n demo run load-generator --rm -it --restart=Never \
  --image=busybox:1.36 -- \
  /bin/sh -c 'while true; do wget -q -O- http://demo-app.demo.svc.cluster.local >/dev/null; done'
