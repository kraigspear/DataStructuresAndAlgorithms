#!/bin/bash

# Scan for dead code in the DataStructuresAndAlgorithms Swift Package

echo "Scanning DataStructuresAndAlgorithms package for dead code..."

# Note: Periphery doesn't directly support Swift Packages yet
# We need to build the package first to generate a build log
# Then scan using the build artifacts

# Build the package
echo "Building package..."
swift build

# Check if periphery is installed
if ! command -v periphery &> /dev/null; then
    echo "⚠️  Periphery is not installed."
    echo "Install with: brew install periphery"
    exit 1
fi

# Note: As of now, periphery has limited Swift Package support
# This is a placeholder for when better support is available
echo ""
echo "⚠️  Note: Periphery has limited Swift Package support."
echo "Consider using manual code review or converting to Xcode project for dead code analysis."
echo ""
echo "Alternative: Run 'swift build' and manually review warnings."
