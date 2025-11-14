# BashScriptCatalogue

A well-organized collection of Bash scripts for various system administration, file management, networking, and utility tasks.

## Repository Structure

The repository is organized into the following categories:

### 📁 Categories

- **[networking/](networking/)** - Network-related scripts (WiFi, remote operations)
- **[security/](security/)** - Security-focused scripts (key extraction, encryption)
- **[file-management/](file-management/)** - File operations and management utilities
- **[utilities/](utilities/)** - General-purpose utility scripts (grep, string processing, loops)
- **[system/](system/)** - System and process management scripts
- **[backup/](backup/)** - Backup and recovery scripts
- **[environment/](environment/)** - Development environment configuration files

### 🚀 Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/canstralian/BashScriptCatalogue.git
   cd BashScriptCatalogue
   ```

2. Make scripts executable:
   ```bash
   chmod +x <category>/<script-name>.sh
   ```

3. Run the main menu interface:
   ```bash
   ./main.sh
   ```

### 📖 Script Migration Guide

If you were using scripts from the old flat structure, here's where they've moved:

| Old Location | New Location | Category |
|-------------|--------------|----------|
| `brute_force_wifi.sh` | `networking/brute_force_wifi.sh` | Networking |
| `copy_to_remote_server.sh` | `networking/copy_to_remote_server.sh` | Networking |
| `extract_prv_key.sh` | `security/extract_prv_key.sh` | Security |
| `remove_pgp.sh` | `security/remove_pgp.sh` | Security |
| `copy_file_func.sh` | `file-management/copy_file_func.sh` | File Management |
| `filter_files.sh` | `file-management/filter_files.sh` | File Management |
| `find_newest_files.sh` | `file-management/find_newest_files.sh` | File Management |
| `grep_display.sh` | `utilities/grep_display.sh` | Utilities |
| `if_string_contains.sh` | `utilities/if_string_contains.sh` | Utilities |
| `pattern_grep.sh` | `utilities/pattern_grep.sh` | Utilities |
| `Pegasus.sh` | `utilities/Pegasus.sh` | Utilities |
| `loops.sh` | `utilities/loops.sh` | Utilities |
| `generate_crossref.sh` | `utilities/generate_crossref.sh` | Utilities |
| `pid_to_process.sh` | `system/pid_to_process.sh` | System |
| `restart_every_6hr.sh` | `system/restart_every_6hr.sh` | System |
| `start_screens_run_commands.sh` | `system/start_screens_run_commands.sh` | System |
| `maintenance_and_loggjng.sh` | `system/maintenance_and_loggjng.sh` | System |
| `rolling_backup_etc.sh` | `backup/rolling_backup_etc.sh` | Backup |
| `.replit` | `environment/.replit` | Environment |
| `replit.nix` | `environment/replit.nix` | Environment |

### 🔧 Backward Compatibility

To maintain backward compatibility, you can:

1. Update your scripts to use the new paths
2. Create symbolic links to the old locations (if needed):
   ```bash
   ln -s networking/copy_to_remote_server.sh copy_to_remote_server.sh
   ```

### 📚 Documentation

Each category directory contains its own README.md with detailed information about the scripts in that category, including:
- Script descriptions
- Usage examples
- Parameters and options
- Prerequisites

### 🤝 Contributing

Contributions are welcome! When adding new scripts:
1. Place them in the appropriate category directory
2. Add documentation to the category's README.md
3. Follow the existing script structure and commenting style
4. Update this main README if adding new categories

### 📝 License

Please refer to the LICENSE file in the repository for licensing information.

### 👥 Authors

See the git history for a list of contributors to this project.
