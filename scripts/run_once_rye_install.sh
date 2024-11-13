#!/bin/bash

if ! command -v rye &> /dev/null; then
  echo "Rye is not installed. Please install it manually before running this script."
  exit 1
fi

rye self install --yes --no-modify-path