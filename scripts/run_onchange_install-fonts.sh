#!/bin/bash

# URL to the GitHub release zip file
CODE_FONT_URL="https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip"
NERD_FONT_SYMBOLS_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/NerdFontsSymbolsOnly.zip"

# Temporary directory for downloading and extracting the zip file
TEMP_DIR=$(mktemp -d)

# Download the zip file
curl -L $CODE_FONT_URL -o $TEMP_DIR/code-fonts.zip
curl -L $NERD_FONT_SYMBOLS_URL -o $TEMP_DIR/symbol-fonts.zip

# Unzip the file
unzip $TEMP_DIR/code-fonts.zip -d $TEMP_DIR
unzip $TEMP_DIR/symbol-fonts.zip -d $TEMP_DIR

# Create the fonts directory if it doesn't exist
mkdir -p ~/Library/Fonts

# Copy the fonts to the system fonts directory
cp $TEMP_DIR/ttf/*.ttf ~/Library/Fonts/
cp $TEMP_DIR/*.ttf ~/Library/Fonts/

# Clean up
rm -rf $TEMP_DIR

echo "Fonts installed successfully!"
