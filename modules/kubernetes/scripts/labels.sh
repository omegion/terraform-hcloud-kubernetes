#!/bin/bash
set -euo pipefail

# Label all workers
for i in $(echo $worker_node_names | sed "s/,/ /g"); do
  kubectl label node "$i" node-role.kubernetes.io/worker=true --overwrite
done
