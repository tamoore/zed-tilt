# Changelog

All notable changes to the Zed Tilt Extension will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2024-07-03

### Changed

- **BREAKING**: Complete rewrite of the extension architecture following the Starlark extension pattern
- Simplified language server integration - now uses system-installed `tilt` binary instead of downloading
- Improved error handling and LSP settings integration
- Updated language configuration with comprehensive bracket matching and indentation rules

### Added

- Support for additional Tiltfile patterns: `.tiltfile` and `.tilt`
- Comprehensive bracket matching for string literals (raw strings, byte strings, etc.)
- Python-style indentation rules with proper increase/decrease patterns
- LSP initialization options and workspace configuration support
- Improved build script with automatic WASM target installation

### Fixed

- Language server not starting due to complex binary download logic
- Missing LSP settings integration
- Inconsistent file pattern matching
- Build issues with incorrect WASM target (now uses `wasm32-wasip1`)

### Removed

- Complex binary download and caching logic
- Automatic Tilt binary installation (now requires system installation)
- Unnecessary debug logging and environment variable handling

## [0.1.0] - 2024-06-XX

### Added

- Initial release of Zed Tilt Extension
- Basic syntax highlighting for Tiltfiles
- Language server integration with automatic binary management
- Support for `Tiltfile` and `tiltfile` patterns
- Example Tiltfile for testing
