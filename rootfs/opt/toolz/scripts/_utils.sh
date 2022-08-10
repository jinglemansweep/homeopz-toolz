#!/bin/bash

declare -r script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)"
declare -r base_dir="$(dirname ${script_dir}/..)"

export base_dir