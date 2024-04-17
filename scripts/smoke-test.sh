#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

target_url=${1:-https://continuous-delivery-playground.vercel.app/}

echo "Running smoke test against: [${target_url}]"
echo "Smoke test started"
curl ${target_url}
echo "Smoke test completed successfully!"