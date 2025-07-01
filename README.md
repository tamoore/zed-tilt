# Zed Tilt Extension

A Zed extension that provides language support for [Tilt](https://tilt.dev/) - the microservice development toolkit for teams that deploy to Kubernetes.

## Features

- **Syntax Highlighting**: Full syntax highlighting for Tiltfile and Starlark files
- **Language Server**: Integration with Tilt's LSP for:
  - Code completion
  - Hover information
  - Diagnostics and error checking
  - Symbol navigation
- **File Recognition**: Automatic detection of `Tiltfile`, `tiltfile`, and `*.star` files
- **Code Formatting**: Support for formatting Tiltfiles using Buildifier
- **Outline View**: Navigate through functions, resources, and configurations
- **Auto-completion**: Intelligent suggestions for Tilt-specific functions and Kubernetes resources

## Installation

### From Zed Extensions

1. Open Zed
2. Open the command palette (`Cmd+Shift+P` on macOS, `Ctrl+Shift+P` on Linux/Windows)
3. Type "zed: extensions" and select it
4. Search for "Tilt"
5. Click "Install"

### Development Installation

1. Clone this repository
2. Open Zed
3. Open the command palette and run "zed: install dev extension"
4. Select the `zed-tilt` directory

## Requirements

This extension automatically downloads and manages the Tilt binary for language server functionality. No manual installation of Tilt is required.

For code formatting support, you may optionally install [Buildifier](https://github.com/bazelbuild/buildtools/tree/master/buildifier):

```bash
# On macOS with Homebrew
brew install buildifier

# On Linux/other systems, download from releases:
# https://github.com/bazelbuild/buildtools/releases
```

## Supported File Types

- `Tiltfile` - Main Tilt configuration file
- `tiltfile` - Alternative naming
- `*.star` - Starlark files used by Tilt

## Language Server Features

The extension provides full language server support through Tilt's built-in LSP:

- **Completions**: Auto-complete for Tilt functions, Kubernetes resources, and configuration options
- **Hover**: Documentation and type information on hover
- **Diagnostics**: Real-time error checking and warnings
- **Go to Definition**: Navigate to function and variable definitions
- **Find References**: Find all references to symbols
- **Symbol Search**: Quickly find functions and resources in your workspace

## Configuration

The extension can be configured through Zed's settings. Add the following to your `settings.json`:

```json
{
  "lsp": {
    "tilt": {
      "initialization_options": {
        "completionEnabled": true,
        "hoverEnabled": true,
        "diagnosticsEnabled": true
      }
    }
  }
}
```

## Tilt-Specific Features

This extension recognizes and provides enhanced support for Tilt-specific functions:

### Resource Management
- `k8s_yaml()` - Deploy Kubernetes YAML
- `docker_build()` - Build Docker images
- `k8s_resource()` - Configure Kubernetes resources
- `local_resource()` - Run local commands
- `helm()` - Deploy Helm charts
- `kustomize()` - Apply Kustomize configurations

### Configuration
- `config.define_string()` - Define string configuration
- `config.define_bool()` - Define boolean configuration  
- `config.define_string_list()` - Define string list configuration
- `config.parse()` - Parse configuration values

### Development Workflow
- `port_forward()` - Set up port forwarding
- `local()` - Execute local commands
- `read_file()` - Read file contents
- `blob()` - Include binary data

## Contributing

This extension is a port of the official Tilt VSCode extension. Contributions are welcome!

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the extension locally
5. Submit a pull request

## Development

To work on this extension:

1. Install Rust via [rustup](https://rustup.rs/)
2. Clone this repository
3. Make changes to the extension
4. Install as a dev extension in Zed
5. Test your changes

### Building

```bash
cargo build --target wasm32-wasi
```

## License

This extension is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## Links

- [Tilt Documentation](https://docs.tilt.dev/)
- [Tilt GitHub Repository](https://github.com/tilt-dev/tilt)
- [Starlark Language](https://github.com/bazelbuild/starlark)
- [Zed Extensions Documentation](https://zed.dev/docs/extensions)