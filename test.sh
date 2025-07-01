#!/bin/bash
set -e

# Test script for Zed Tilt Extension

echo "🧪 Testing Zed Tilt Extension..."

# Check if extension files exist
echo "📁 Checking extension structure..."

required_files=(
    "extension.toml"
    "Cargo.toml"
    "src/lib.rs"
    "languages/tiltfile/config.toml"
    "languages/tiltfile/highlights.scm"
    "languages/tiltfile/indents.scm"
    "languages/tiltfile/outline.scm"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
    else
        echo "❌ $file is missing"
        exit 1
    fi
done

# Validate extension.toml syntax
echo "🔍 Validating extension.toml..."
if command -v toml-fmt &> /dev/null; then
    toml-fmt --check extension.toml
    echo "✅ extension.toml is valid TOML"
else
    echo "⚠️  toml-fmt not available, skipping TOML validation"
fi

# Check Cargo.toml syntax
echo "🔍 Validating Cargo.toml..."
cargo check --quiet
echo "✅ Cargo.toml is valid"

# Test syntax files
echo "🔍 Checking syntax files..."
for scm_file in languages/tiltfile/*.scm; do
    if [ -f "$scm_file" ]; then
        # Basic check for common Tree-sitter syntax errors
        if grep -q "^[[:space:]]*;" "$scm_file" && grep -q "@" "$scm_file"; then
            echo "✅ $(basename "$scm_file") appears to have valid Tree-sitter syntax"
        else
            echo "⚠️  $(basename "$scm_file") may have syntax issues"
        fi
    fi
done

# Test example Tiltfile
echo "🔍 Validating example Tiltfile..."
if [ -f "examples/Tiltfile" ]; then
    # Check for common Python/Starlark syntax patterns
    if grep -q "def\|load\|docker_build\|k8s_yaml" examples/Tiltfile; then
        echo "✅ Example Tiltfile contains expected patterns"
    else
        echo "❌ Example Tiltfile seems incomplete"
        exit 1
    fi
else
    echo "❌ Example Tiltfile is missing"
    exit 1
fi

# Test build process
echo "🔨 Testing build process..."
if [ -f "build.sh" ]; then
    echo "✅ Build script exists"
    # Don't actually run the build in test, just check it's executable
    if [ -x "build.sh" ]; then
        echo "✅ Build script is executable"
    else
        echo "❌ Build script is not executable"
        exit 1
    fi
else
    echo "❌ Build script is missing"
    exit 1
fi

# Check for required dependencies in Cargo.toml
echo "🔍 Checking Rust dependencies..."
if grep -q "zed_extension_api" Cargo.toml; then
    echo "✅ zed_extension_api dependency found"
else
    echo "❌ zed_extension_api dependency missing"
    exit 1
fi

# Validate crate type
if grep -q 'crate-type = \["cdylib"\]' Cargo.toml; then
    echo "✅ Correct crate type (cdylib) configured"
else
    echo "❌ Incorrect or missing crate type"
    exit 1
fi

# Check language configuration
echo "🔍 Validating language configuration..."
if grep -q "Tiltfile" languages/tiltfile/config.toml; then
    echo "✅ Language name configured"
else
    echo "❌ Language name not found in config"
    exit 1
fi

if grep -q "source.tiltfile" languages/tiltfile/config.toml; then
    echo "✅ Language scope configured"
else
    echo "❌ Language scope not found in config"
    exit 1
fi

# Test file type associations
echo "🔍 Checking file type associations..."
if grep -q "Tiltfile\|tiltfile\|*.star" extension.toml; then
    echo "✅ File type associations configured"
else
    echo "❌ File type associations missing"
    exit 1
fi

# Check for README and LICENSE
echo "📖 Checking documentation..."
if [ -f "README.md" ]; then
    echo "✅ README.md exists"
    if grep -q "Tilt" README.md; then
        echo "✅ README mentions Tilt"
    else
        echo "❌ README doesn't mention Tilt"
        exit 1
    fi
else
    echo "❌ README.md is missing"
    exit 1
fi

if [ -f "LICENSE" ]; then
    echo "✅ LICENSE exists"
else
    echo "❌ LICENSE is missing"
    exit 1
fi

# Final summary
echo ""
echo "🎉 All tests passed!"
echo ""
echo "Extension structure is valid and ready for development."
echo ""
echo "Next steps:"
echo "1. Run ./build.sh to build the extension"
echo "2. Install as dev extension in Zed"
echo "3. Test with the example Tiltfile"
echo "4. Verify syntax highlighting and language server features"
