#!/bin/bash

# Define the directory where m1ddc will be cloned
M1DDC_DIR="$HOME/m1ddc"

# Check if m1ddc is already cloned
if [ ! -d "$M1DDC_DIR" ]; then
	echo "Cloning m1ddc repository..."
	git clone https://github.com/waydabber/m1ddc.git "$M1DDC_DIR"
else
	echo "m1ddc repository already exists. Pulling latest changes..."
	cd "$M1DDC_DIR" && git pull
fi

# Navigate to the m1ddc directory
cd "$M1DDC_DIR"

# Build the project using make
echo "Building m1ddc..."
make

echo "m1ddc installation and build complete."
