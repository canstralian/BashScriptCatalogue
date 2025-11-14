# Environment Configuration

This directory contains environment setup and configuration files for development platforms and build systems.

## Files

### ⚙️ .replit

**Description:** Configuration file for Repl.it (Replit) cloud development environment.

**Purpose:**
- Defines the entry point for the application
- Specifies the build environment module
- Configures deployment settings

**Configuration:**
```ini
entrypoint = "main.sh"
modules = ["bash:v1-20231215-e6d471c"]

[nix]
channel = "stable-23_05"

[deployment]
run = ["bash", "main.sh"]
deploymentTarget = "cloudrun"
```

**Key Settings:**

- **entrypoint**: Script to run when "Run" button is clicked (`main.sh`)
- **modules**: Bash environment version specification
- **nix.channel**: Nix package manager channel (stable-23_05)
- **deployment.run**: Command executed during deployment
- **deploymentTarget**: Deployment platform (Google Cloud Run)

**Customization:**

Change entry point:
```ini
entrypoint = "your_script.sh"
```

Change deployment command:
```ini
[deployment]
run = ["bash", "custom_script.sh"]
```

---

### 📦 replit.nix

**Description:** Nix configuration file specifying dependencies and packages for the Replit environment.

**Purpose:**
- Declares system-level dependencies
- Ensures reproducible development environment
- Manages package versions

**Configuration:**
```nix
{ pkgs }: {
  deps = [
    pkgs.bashInteractive
    pkgs.nodePackages.bash-language-server
    pkgs.man
  ];
}
```

**Included Packages:**

1. **bashInteractive**: Interactive Bash shell with full features
2. **bash-language-server**: Language server for Bash script editing (autocomplete, linting)
3. **man**: Manual pages for documentation

**Adding Dependencies:**

Add new packages to the `deps` array:
```nix
{ pkgs }: {
  deps = [
    pkgs.bashInteractive
    pkgs.nodePackages.bash-language-server
    pkgs.man
    pkgs.git            # Add Git
    pkgs.curl           # Add curl
    pkgs.jq             # Add JSON processor
    pkgs.shellcheck     # Add Bash linter
  ];
}
```

**Common Packages for Bash Development:**
```nix
pkgs.shellcheck      # Static analysis for shell scripts
pkgs.shfmt           # Shell script formatter
pkgs.bats            # Bash Automated Testing System
pkgs.git             # Version control
pkgs.vim             # Text editor
pkgs.htop            # Process monitor
```

## Replit Environment Setup

### First Time Setup

1. **Fork/Import Repository:**
   - Go to Replit.com
   - Click "Create" → "Import from GitHub"
   - Enter repository URL

2. **Environment Initialization:**
   - Replit automatically reads `.replit` and `replit.nix`
   - Dependencies are installed via Nix
   - Environment is ready when Shell prompt appears

3. **Run Application:**
   - Click the "Run" button
   - Or manually run: `bash main.sh`

### Development Workflow

**File Editing:**
- Use built-in editor with Bash language server support
- Autocomplete available for Bash commands
- Syntax highlighting enabled

**Running Scripts:**
```bash
# Run specific script
bash networking/copy_to_remote_server.sh

# Make executable and run
chmod +x utilities/grep_display.sh
./utilities/grep_display.sh input.txt output.txt
```

**Shell Access:**
- Use the Shell tab for command-line operations
- Full Bash environment available
- Access to all installed packages

### Debugging

**Enable verbose mode:**
```bash
bash -x script.sh
```

**Add debug output:**
```bash
set -x  # Enable debug mode
# Your script code
set +x  # Disable debug mode
```

**Check environment:**
```bash
# View installed packages
echo $PATH
which bash
bash --version
```

## Local Development Setup

For developers not using Replit, replicate the environment locally:

### Linux/macOS

**Install dependencies:**
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install bash bash-completion man-db

# macOS (Homebrew)
brew install bash bash-completion man-db
```

**Optional tools:**
```bash
# Install shellcheck for linting
sudo apt-get install shellcheck  # Linux
brew install shellcheck          # macOS
```

### Windows

**Option 1: WSL (Windows Subsystem for Linux)**
```bash
# Install WSL
wsl --install

# In WSL, install Bash tools
sudo apt-get update
sudo apt-get install bash bash-completion man-db
```

**Option 2: Git Bash**
- Download Git for Windows (includes Git Bash)
- Git Bash provides Bash environment on Windows

**Option 3: Cygwin**
- Download Cygwin installer
- Select Bash and related packages during installation

## CI/CD Integration

### GitHub Actions

Create `.github/workflows/bash-lint.yml`:
```yaml
name: Bash Linting

on: [push, pull_request]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run shellcheck
        run: |
          sudo apt-get install shellcheck
          find . -name "*.sh" -exec shellcheck {} \;
```

### GitLab CI

Create `.gitlab-ci.yml`:
```yaml
stages:
  - lint

bash-lint:
  stage: lint
  image: koalaman/shellcheck-alpine
  script:
    - find . -name "*.sh" -exec shellcheck {} \;
```

## Environment Variables

### Common Variables for Bash Scripts

```bash
# Set in .replit [env] section or shell
[env]
LOG_LEVEL = "INFO"
BACKUP_DIR = "/tmp/backups"
```

### Usage in Scripts

```bash
#!/bin/bash
# Access environment variables
LOG_LEVEL=${LOG_LEVEL:-"INFO"}
BACKUP_DIR=${BACKUP_DIR:-"/tmp/backups"}

echo "Log level: $LOG_LEVEL"
echo "Backup directory: $BACKUP_DIR"
```

## Troubleshooting

### Replit Issues

**Environment not loading:**
- Check `.replit` syntax
- Verify `replit.nix` package names
- Clear cache: Shell → Clear → Restart

**Dependencies not found:**
```bash
# Verify package installation
which bash
bash --version

# Manually install if needed (temporary)
nix-env -iA nixpkgs.packagename
```

**Permission issues:**
```bash
# Make scripts executable
chmod +x *.sh
chmod +x */*.sh
```

### Local Development Issues

**Bash version mismatch:**
```bash
# Check version
bash --version

# Use specific Bash version
/bin/bash script.sh  # System Bash
/usr/local/bin/bash script.sh  # Homebrew Bash (macOS)
```

**Missing packages:**
```bash
# Install missing tools
sudo apt-get install package-name  # Debian/Ubuntu
brew install package-name           # macOS
```

## Nix Package Manager

### Useful Nix Commands

```bash
# Search for packages
nix search nixpkgs packagename

# Install package temporarily
nix-shell -p packagename

# Update channel
nix-channel --update

# List installed packages
nix-env -q
```

### Creating Custom Nix Shell

Create `shell.nix` for project-specific environment:
```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    bashInteractive
    shellcheck
    shfmt
    git
  ];

  shellHook = ''
    echo "Bash development environment loaded"
    echo "Bash version: $(bash --version | head -1)"
  '';
}
```

## Best Practices

### Environment Configuration
- Keep `.replit` minimal and focused
- Specify exact package versions when possible
- Document any custom configurations
- Test environment setup on fresh install

### Dependency Management
- Only include necessary packages
- Regularly update dependencies
- Use lock files for reproducibility
- Document package purposes

### Security
- Don't commit secrets to `.replit` or `replit.nix`
- Use Replit Secrets for sensitive data
- Review package sources before adding
- Keep environment packages updated

## Resources

- [Replit Documentation](https://docs.replit.com/)
- [Nix Package Manager](https://nixos.org/manual/nix/stable/)
- [Bash Manual](https://www.gnu.org/software/bash/manual/)
- [ShellCheck Wiki](https://www.shellcheck.net/wiki/)

## Related Documentation

- See main `README.md` for repository overview
- See individual category READMEs for script documentation
- Check `main.sh` for entry point documentation
