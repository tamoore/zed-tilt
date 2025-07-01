# Troubleshooting Tiltfile Syntax Highlighting in Zed

This guide helps you troubleshoot syntax highlighting issues with the Tilt extension for Zed.

## Quick Fix Checklist

1. **Reinstall the extension:**
   - Open Zed
   - Command Palette (Cmd+Shift+P / Ctrl+Shift+P)
   - Run `zed: install dev extension`
   - Select the `zed-tilt` directory

2. **Restart Zed completely** after reinstalling

3. **Open a Tiltfile** and check if syntax highlighting appears

## Common Issues and Solutions

### Issue 1: No Syntax Highlighting at All

**Symptoms:** Tiltfile opens as plain text with no colors

**Causes:**
- Extension not properly installed
- Tree-sitter grammar not loaded
- File not recognized as Tiltfile

**Solutions:**
1. Check file extension is recognized:
   - File should be named `Tiltfile`, `tiltfile`, or have `.star` extension
   - Check bottom-right corner of Zed - should show "Tiltfile" as language

2. Force language selection:
   - Command Palette → `editor: select language`
   - Choose "Tiltfile"

3. Check extension installation:
   - Command Palette → `zed: extensions`
   - Verify "Tilt" extension is listed and enabled

### Issue 2: Partial Syntax Highlighting

**Symptoms:** Some keywords highlighted, others not

**Cause:** Tree-sitter grammar compatibility issues

**Solution:** Switch to simplified highlighting mode:
1. Edit `languages/tiltfile/config.toml`
2. Change `scope = "source.tiltfile"` to `scope = "source.python"`
3. Rebuild extension: `./build.sh`
4. Reinstall in Zed

### Issue 3: Extension Won't Load

**Symptoms:** Extension not appearing in extensions list

**Troubleshooting:**
1. Check build status:
   ```bash
   cd zed-tilt
   ./build.sh
   ```

2. Verify files exist:
   - `extension.wasm` should be present
   - `extension.toml` should be valid

3. Check Zed logs:
   - macOS: `~/Library/Logs/Zed/Zed.log`
   - Linux: `~/.local/share/zed/logs/Zed.log`
   - Windows: `%APPDATA%\Zed\logs\Zed.log`

## Configuration Options

### Option 1: Python-compatible Mode (Recommended)

Best compatibility with existing Tree-sitter infrastructure:

```toml
# languages/tiltfile/config.toml
scope = "source.python"
injection_regex = "^(tiltfile|starlark|python)$"
```

### Option 2: Custom Tiltfile Mode

More specific but requires proper grammar setup:

```toml
# languages/tiltfile/config.toml
scope = "source.tiltfile"
injection_regex = "^(tiltfile|starlark)$"
grammar = "python"
```

## Testing Syntax Highlighting

Use the example file to test highlighting:

```bash
# Open the test file
zed examples/Tiltfile
```

Expected highlighting:
- ✅ Keywords: `def`, `if`, `for`, `load`
- ✅ Strings: `"docker_build"`, `'./api'`
- ✅ Comments: `# This is a comment`
- ✅ Functions: `k8s_yaml()`, `docker_build()`
- ✅ Numbers: `8080`, `3000`

## Debugging Steps

### 1. Verify Extension Structure
```bash
ls -la zed-tilt/
# Should see: extension.toml, extension.wasm, languages/
```

### 2. Check Language Configuration
```bash
cat languages/tiltfile/config.toml
# Verify scope and file_types are correct
```

### 3. Test Tree-sitter Queries
Open any Python file in Zed - if Python syntax highlighting works, the grammar is available.

### 4. Check File Association
In Zed, open a Tiltfile and check:
- Bottom-right corner shows "Tiltfile" (not "Plain Text")
- File icon in sidebar shows Python/code icon

## Advanced Troubleshooting

### Reset Extension
```bash
# Remove and reinstall
rm -rf ~/.config/zed/extensions/tilt
# Then reinstall via Zed command palette
```

### Manual Grammar Check
```bash
# Check if Python grammar is available
find ~/.config/zed -name "*python*" -type f
```

### Create Minimal Test Case
Create a simple test file:
```python
# test.tiltfile
def hello():
    print("Hello, Tilt!")

k8s_yaml("deployment.yaml")
docker_build("myapp", ".")
```

## Getting Help

If syntax highlighting still doesn't work:

1. **Check Zed version**: Ensure you're using Zed 0.100.0+
2. **Check extension logs**: Look for errors in Zed logs
3. **Try Python mode**: Use `scope = "source.python"` as fallback
4. **Report issue**: Include:
   - Zed version
   - Operating system
   - Extension build output
   - Sample Tiltfile that isn't highlighting

## Known Limitations

- Tilt-specific syntax like `load()` statements may not highlight perfectly
- Some advanced Starlark features might not be recognized
- Language server features require Tilt CLI to be installed

## Success Indicators

When working correctly, you should see:
- Keywords in blue/purple (`def`, `if`, `load`)
- Strings in green (`"api"`, `'./docker'`)
- Comments in gray (`# comment`)
- Function calls highlighted (`k8s_yaml`, `docker_build`)
- Numbers in orange (`8080`, `3000`)
- Proper bracket matching and indentation guides
