#!/bin/bash
set -e

# Build script for Zed Tilt Extension

echo "🔧 Building Zed Tilt Extension..."

# Check if Rust is installed
if ! command -v rustc &> /dev/null; then
    echo "❌ Rust is not installed. Please install Rust via rustup:"
    echo "   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    exit 1
fi

# Check if wasm32-wasi target is installed
if ! rustup target list --installed | grep -q wasm32-wasi; then
    echo "📦 Installing wasm32-wasip1 target..."
    rustup target add wasm32-wasip1
fi

# Clean previous builds
echo "🧹 Cleaning previous builds..."
cargo clean

# Build the extension
echo "🚀 Building WebAssembly extension..."
cargo build --target wasm32-wasip1 --release

# Check if build was successful
if [ -f "target/wasm32-wasip1/release/tilt_extension.wasm" ]; then
    echo "✅ Build successful!"
    echo "📄 WebAssembly binary: target/wasm32-wasip1/release/tilt_extension.wasm"

    # Show file size
    size=$(ls -lh target/wasm32-wasip1/release/tilt_extension.wasm | awk '{print $5}')
    echo "📊 Binary size: $size"

    echo ""
    echo "🎉 Extension is ready for testing!"
    echo ""
    echo "To install as dev extension in Zed:"
    echo "1. Open Zed"
    echo "2. Run 'zed: install dev extension' from command palette"
    echo "3. Select this directory"
    echo ""
    echo "To test with example Tiltfile:"
    echo "1. Open examples/Tiltfile in Zed"
    echo "2. Verify syntax highlighting works"
    echo "3. Check that language server features are active"
else
    echo "❌ Build failed!"
    exit 1
fi
