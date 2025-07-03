# Zed Tilt Extension

A Zed extension that provides language support for [Tilt](https://tilt.dev/) - the microservice development toolkit for teams that deploy to Kubernetes.

## Features

- **Syntax Highlighting**: Full Starlark syntax highlighting for Tiltfiles
- **Language Server Protocol**: Integrated Tilt LSP for intelligent code completion, hover information, and go-to-definition
- **File Recognition**: Automatically recognizes `Tiltfile`, `tiltfile`, `.tiltfile`, and `.tilt` files
- **Smart Indentation**: Proper Python-style indentation support
- **Bracket Matching**: Intelligent bracket completion and matching
- **Runtime Error Detection**: Errors are detected when Tilt is running and evaluating your Tiltfile

## Prerequisites

- [Tilt CLI](https://docs.tilt.dev/install.html) must be installed on your system
- The Tilt LSP server is bundled with the Tilt CLI

## Installation

## Usage

Once installed, the extension will automatically activate when you open any Tiltfile. The extension provides:

- **Syntax highlighting** for Starlark/Python syntax
- **LSP features** including:
  - Code completion for Tilt functions
  - Hover information with documentation
  - Go to definition
  - Symbol search
  - Parameter hints and signature help

## Error Detection

**Important**: Unlike traditional language servers, the Tilt LSP does not provide real-time syntax error diagnostics in the editor. This is because Tilt errors are primarily **runtime errors** that occur when Tilt evaluates your Tiltfile.

To see errors in your Tiltfile:

1. **Run Tilt**: Execute `tilt up` in your terminal
2. **Check Tilt UI**: Open the Tilt web UI (usually http://localhost:10350) to see detailed error information
3. **Terminal Output**: Tilt will display syntax and runtime errors in the terminal

This behavior is consistent with how Tilt works - it's designed to catch configuration and deployment issues when actually running, not through static analysis.

## Supported File Types

The extension recognizes the following file patterns:

- `Tiltfile`
- `tiltfile`
- `.tiltfile`
- `.tilt`

## Architecture

This extension is built using the Zed Extension API and follows the same architectural patterns as the [Starlark extension](https://github.com/zaucy/zed-starlark). Key components:

- **Language Server Integration**: Uses the Tilt CLI's built-in LSP server
- **Starlark Grammar**: Leverages the Tree-sitter Starlark grammar for syntax highlighting
- **Binary Discovery**: Automatically finds the `tilt` binary in your PATH

## Development

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built on the [Zed Extension API](https://github.com/zed-industries/zed)
- Inspired by the [Starlark Zed Extension](https://github.com/zaucy/zed-starlark)
- Uses the [Tree-sitter Starlark grammar](https://github.com/tree-sitter-grammars/tree-sitter-starlark)
- Integrates with the [Tilt LSP server](https://docs.tilt.dev/lsp.html)
