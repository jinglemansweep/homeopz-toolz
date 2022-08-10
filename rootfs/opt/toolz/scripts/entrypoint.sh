#!/bin/bash

set -e

pwd="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
source "${pwd}/_utils.sh"

echo "HOMEOPZ TOOLZ"
echo "============="
echo "Base: ${base_dir}"
echo