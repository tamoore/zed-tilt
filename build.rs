use std::env;
use std::fs;
use std::path::PathBuf;

fn main() {
    println!("cargo:rerun-if-changed=extension.toml");

    let extension_toml_path =
        PathBuf::from(env::var("CARGO_MANIFEST_DIR").unwrap()).join("extension.toml");

    let extension_toml_content =
        fs::read_to_string(&extension_toml_path).expect("Failed to read extension.toml");

    // Simple TOML parsing to update version
    let cargo_version = env::var("CARGO_PKG_VERSION").unwrap();

    // Check if version needs updating
    let mut lines: Vec<String> = extension_toml_content
        .lines()
        .map(|s| s.to_string())
        .collect();
    let mut updated = false;

    for line in &mut lines {
        if line.starts_with("version = ") {
            let new_line = format!("version = \"{}\"", cargo_version);
            if *line != new_line {
                *line = new_line;
                updated = true;
            }
            break;
        }
    }

    if updated {
        let updated_content = lines.join("\n");
        fs::write(extension_toml_path, updated_content).expect("Failed to write extension.toml");
    }
}
