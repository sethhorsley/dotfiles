# dotfiles

this is my dotfiles repository

## Install chezmoi and dotfiles on a new machine

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply sethhorsley
```

## Script Execution Order

When running `chezmoi apply`, scripts execute in a specific order based on their naming convention and location.

### Linux Script Execution Order

1. **`run_onchange_before_001_install_packages.sh`** - Install system packages
   - Updates apt package lists (`apt-get update`)
   - Installs: neovim, build tools, zsh, fzf, git, development libraries, bat, jq, 1Password CLI
   - Sets zsh as default shell
   - Generates default `.zshrc` if missing
   - Installs Oh My Zsh
   - Installs mise
   - Installs 1Password CLI (for manual use)

### macOS (Darwin) Script Execution Order

#### 1. Before Install Phase
1. **`darwin/1_before_install/run_onchange_before_002.sh`** - Pre-installation setup

#### 2. After Install Phase
2. **`darwin/2_after_install/run_onchange_after_001_install_packages.sh`** - Install packages via Homebrew
   - Installs taps, brews, and casks from `.chezmoidata` config
   - Sets Hammerspoon config location
   - Installs mise if not present
   - Sets up zsh completion for mise

3. **`darwin/2_after_install/run_onchange_after_004_setup_1password_desktop.sh`** - 1Password desktop app integration
   - Checks if 1Password desktop app is installed
   - Verifies CLI integration is enabled
   - Provides setup instructions if needed

#### 3. Before Decrypt Phase
4. **`darwin/3_before_decrypt/run_once_before_decrypt-private-key.sh`** - Decrypt private key setup (runs once)

5. **`darwin/3_before_decrypt/run_onchange_before_001_setup_1password_ssh.sh`** - 1Password SSH agent setup
   - Validates 1Password SSH agent socket exists
   - Provides setup instructions if not configured

#### 4. After Decrypt Phase
6. **`darwin/4_after_decrypt/run_once_after_decrypt-private-key.sh`** - Post-decryption setup (runs once)

### Cross-Platform Scripts

7. **`run_onchange_after_003_install_ssh_keys.sh`** - Install SSH keys from 1Password
   - Uses 1Password CLI to fetch SSH keys
   - Detects key type (RSA/Ed25519) automatically
   - Installs to correct location (`~/.ssh/id_rsa` or `~/.ssh/id_ed25519`)
   - Sets proper file permissions

## Script Naming Convention

- `run_once_` - Runs only once (tracked by chezmoi)
- `run_onchange_` - Runs when the script content changes
- `before_` - Runs before main operations
- `after_` - Runs after main operations
- Numbers (e.g., `001`, `002`) - Control execution order within same phase
