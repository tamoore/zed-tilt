# Development Guide

This guide covers how to develop and contribute to the Zed Tilt Extension.

## Prerequisites

### Required Tools

1. **Rust** - Install via [rustup](https://rustup.rs/):
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   source ~/.cargo/env
   ```

2. **WASM Target** - Required for building Zed extensions:
   ```bash
   rustup target add wasm32-wasi
   ```

3. **Zed Editor** - Download from [zed.dev](https://zed.dev/)

### Optional Tools

- **Buildifier** - For formatting Tiltfiles:
  ```bash
  # macOS
  brew install buildifier

  # Linux - download from GitHub releases
  # https://github.com/bazelbuild/buildtools/releases
  ```

- **Tree-sitter CLI** - For testing syntax highlighting:
  ```bash
  npm install -g tree-sitter-cli
  ```

## Project Structure

```
zed-tilt/
├── extension.toml          # Extension metadata and configuration
├── Cargo.toml             # Rust project configuration
├── src/
│   └── lib.rs            # Main extension logic (WebAssembly)
├── languages/
│   └── tiltfile/
│       ├── config.toml   # Language server configuration
│       ├── highlights.scm # Syntax highlighting rules
│       ├── indents.scm   # Indentation rules
│       └── outline.scm   # Symbol outline configuration
├── examples/
│   └── Tiltfile         # Example file for testing
├── build.sh             # Build script
├── test.sh              # Test script
└── README.md            # User documentation
```

## Development Workflow

### 1. Initial Setup

Clone and set up the development environment:

```bash
git clone <your-fork-url>
cd zed-tilt
./test.sh  # Validate structure
```

### 2. Making Changes

#### Language Server Changes (`src/lib.rs`)

The main extension logic is in Rust and compiled to WebAssembly. Key areas:

- **Binary Management**: Downloads and manages Tilt binary
- **Language Server Integration**: Configures Tilt's LSP
- **Initialization Options**: Sets up completion, hover, diagnostics

#### Syntax Highlighting (`languages/tiltfile/highlights.scm`)

Tree-sitter queries for syntax highlighting. Key patterns:

- Keywords: `def`, `load`, `if`, etc.
- Tilt functions: `docker_build`, `k8s_yaml`, etc.
- Comments, strings, operators
- Starlark-specific syntax

#### Language Configuration (`languages/tiltfile/config.toml`)

Language server and editor behavior:

- File associations
- Language server settings
- Formatting configuration
- Debugging setup

### 3. Building and Testing

```bash
# Run tests
./test.sh

# Build extension
./build.sh

# Install in Zed for testing
# 1. Open Zed
# 2. Cmd+Shift+P → "zed: install dev extension"
# 3. Select zed-tilt directory
```

### 4. Testing Changes

1. **Syntax Highlighting**: Open `examples/Tiltfile` in Zed
2. **Language Server**: Check completions, hover, diagnostics
3. **File Association**: Test with different file types
4. **Error Handling**: Test with malformed Tiltfiles

## Common Development Tasks

### Adding New Tilt Functions

1. **Update syntax highlighting** (`highlights.scm`):
   ```scheme
   [
     "new_tilt_function"
     "another_function"
   ] @function.builtin
   ```

2. **Test with example usage** in `examples/Tiltfile`

3. **Rebuild and test** in Zed

### Improving Language Server Integration

1. **Modify initialization options** in `src/lib.rs`:
   ```rust
   Ok(Some(zed::serde_json::json!({
       "completionEnabled": true,
       "newFeatureEnabled": true,
   })))
   ```

2. **Update language configuration** in `languages/tiltfile/config.toml`

3. **Test language server features** in Zed

### Adding File Type Support

1. **Update extension.toml**:
   ```toml
   [[languages]]
   file_types = ["Tiltfile", "tiltfile", "*.star", "*.new_extension"]
   ```

2. **Update language config** in `languages/tiltfile/config.toml`

3. **Test file recognition** with new file types

## Code Style and Standards

### Rust Code

- Use `rustfmt` for formatting
- Follow Rust naming conventions
- Add comments for complex logic
- Handle errors appropriately with `zed::Result`

### Tree-sitter Queries

- Group related patterns logically
- Use descriptive capture names
- Add comments explaining complex patterns
- Test with various code samples

### TOML Configuration

- Use consistent indentation (2 spaces)
- Group related settings
- Add comments for non-obvious settings

## Debugging

### Extension Loading Issues

1. Check Zed's log output:
   ```bash
   # Start Zed with logging
   zed --foreground
   ```

2. Look for extension-related errors in console

### Language Server Issues

1. **Check binary download**: Verify Tilt binary is downloaded correctly
2. **Test LSP manually**: Run `tilt lsp start` to test language server
3. **Check initialization**: Verify LSP initialization options

### Syntax Highlighting Issues

1. **Test Tree-sitter queries**: Use Tree-sitter CLI to test syntax files
2. **Check file association**: Ensure files are recognized as Tiltfile
3. **Validate query syntax**: Ensure Tree-sitter queries are valid

## Testing

### Automated Tests

```bash
./test.sh  # Runs all validation checks
```

### Manual Testing Checklist

- [ ] Extension loads without errors
- [ ] Tiltfile syntax highlighting works
- [ ] Language server provides completions
- [ ] Hover information displays correctly
- [ ] Diagnostics show for syntax errors
- [ ] File outline/symbols work
- [ ] Formatting works (if Buildifier installed)
- [ ] Different file types recognized correctly

### Test Cases

Create test Tiltfiles covering:

- Basic Tilt functions (`docker_build`, `k8s_yaml`)
- Configuration (`config.define_*`)
- Control flow (loops, conditionals)
- Error conditions (syntax errors, missing files)
- Edge cases (empty files, very large files)

## Release Process

### Version Updates

1. Update version in `extension.toml`
2. Update version in `Cargo.toml`
3. Update `README.md` with new features
4. Test thoroughly with `./test.sh` and manual testing

### Publishing

Follow the official Zed extension publishing process:

1. Fork `zed-industries/extensions` repository
2. Add extension as submodule
3. Update `extensions.toml`
4. Submit pull request

## Troubleshooting

### Common Issues

**Build Failures**:
- Ensure Rust is installed via rustup (not package manager)
- Check that `wasm32-wasi` target is installed
- Verify all required files are present

**Language Server Not Working**:
- Check that Tilt binary downloads correctly
- Verify network connectivity for GitHub API
- Check Zed's LSP configuration

**Syntax Highlighting Missing**:
- Verify Tree-sitter grammar is configured correctly
- Check file type associations
- Ensure highlight queries are valid

### Getting Help

- Check existing GitHub issues
- Review Zed extension documentation
- Look at other language extensions for examples
- Join the Zed community for support

## Contributing

### Pull Request Guidelines

1. **Test thoroughly**: Run `./test.sh` and manual tests
2. **Update documentation**: Modify README.md if needed
3. **Follow conventions**: Maintain consistent code style
4. **Small, focused changes**: Keep PRs manageable
5. **Descriptive commits**: Clear commit messages

### Code Review

- Be open to feedback
- Test suggested changes
- Update based on reviewer comments
- Ensure CI passes

Thank you for contributing to the Zed Tilt Extension! 🚀
