#!/bin/bash
# Build VoiceType.app for macOS
# Requires: Xcode Command Line Tools (xcode-select --install)

set -e

APP_NAME="VoiceType"
BUILD_DIR="build"
APP_BUNDLE="$BUILD_DIR/$APP_NAME.app"
CONTENTS="$APP_BUNDLE/Contents"
MACOS_DIR="$CONTENTS/MacOS"
RESOURCES="$CONTENTS/Resources"

echo "Building $APP_NAME..."

# Clean previous build
rm -rf "$BUILD_DIR"
mkdir -p "$MACOS_DIR" "$RESOURCES"

# Compile all Swift sources
swiftc \
    -o "$MACOS_DIR/$APP_NAME" \
    -framework Cocoa \
    -framework AVFoundation \
    -framework CoreGraphics \
    -target arm64-apple-macosx13.0 \
    -O \
    Sources/*.swift

# Copy resources into the bundle
cp Info.plist "$CONTENTS/"
cp config.json "$RESOURCES/"

echo ""
echo "Build complete: $APP_BUNDLE"
echo ""
echo "Before running:"
echo "  1. Edit ~/.voicetype/config.json and add your OpenAI API key"
echo "     (a default config is created on first launch)"
echo "  2. Grant Accessibility permission:"
echo "     System Settings > Privacy & Security > Accessibility > VoiceType"
echo "  3. Grant Microphone permission (prompted on first recording)"
echo ""
echo "To run:  open $APP_BUNDLE"
