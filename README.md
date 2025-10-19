# dotfiles

this is my dotfiles repository

## Install chezmoi and dotfiles on a new machine

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply sethhorsley
```

## Script Execution Order

When running `chezmoi apply`, scripts execute in a specific order based on their naming convention and location.

### Cross-Platform Scripts (Run First)

**0. `run_once_before_000_setup_age_key.sh`** - Setup age encryption key (runs once)
   - Checks if age key file already exists at `~/.config/chezmoi/key.txt`
   - If not exists and key provided during `chezmoi init`, creates the key file
   - Sets proper permissions (600)
   - Required for decrypting encrypted files in the repository

### Linux Script Execution Order

**1. `linux/run_onchange_before_001_install_packages.sh`** - Install system packages
   - Updates apt package lists (`apt-get update`)
   - Installs packages via apt:
     - **Tools**: neovim, curl, fzf, git, bat, jq
     - **Build tools**: build-essential, autoconf, patch, rustc
     - **Libraries**: libssl-dev, libyaml-dev, libreadline6-dev, zlib1g-dev, libgmp-dev, libncurses5-dev, libffi-dev, libgdbm-dev, libdb-dev, uuid-dev
     - **Shell**: zsh
     - **Other**: fuse, libfuse2, dirmngr, gpg, gawk

**2. `linux/run_onchange_before_002_setup_dev_environment.sh`** - Setup development environment
   - Sets zsh as default shell
   - Adds zsh to `/etc/shells` if needed
   - Changes user's default shell with `chsh`
   - Generates default `.zshrc` with Oh My Zsh configuration if not exists
   - Installs Oh My Zsh (unattended mode)
   - Installs mise runtime version manager to `~/.local/bin/mise`
   - Sets up zsh completion for mise
   - Installs 1Password CLI:
     - Adds 1Password apt repository
     - Configures package signing verification
     - Installs `1password-cli` package

### macOS (Darwin) Script Execution Order

#### 1. Before Install Phase
**3. `darwin/1_before_install/run_onchange_before_002.sh`** - Pre-installation setup

#### 2. After Install Phase
**4. `darwin/2_after_install/run_onchange_after_001_install_packages.sh`** - Install packages via Homebrew
   - Installs taps, brews, and casks from `.chezmoidata` config
   - Sets Hammerspoon config location
   - Installs mise if not present at `~/.local/bin/mise`
   - Sets up zsh completion for mise at `~/.zsh/functions/Completion/_mise`

**5. `darwin/2_after_install/run_onchange_after_004_setup_1password_desktop.sh`** - 1Password desktop app integration
   - Checks if 1Password desktop app is installed at `/Applications/1Password.app`
   - Tests if CLI integration is enabled using `op whoami`
   - Provides setup instructions if CLI integration is not enabled

#### 3. Before Decrypt Phase
**6. `darwin/3_before_decrypt/run_once_before_decrypt-private-key.sh`** - Decrypt private key setup (runs once)

**7. `darwin/3_before_decrypt/run_onchange_before_001_setup_1password_ssh.sh`** - 1Password SSH agent setup
   - Validates 1Password SSH agent socket exists
   - Provides setup instructions if not configured
   - Checks common socket path: `~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock`

#### 4. After Decrypt Phase
**8. `darwin/4_after_decrypt/run_once_after_decrypt-private-key.sh`** - Post-decryption setup (runs once)

## Script Naming Convention

- `run_once_` - Runs only once (tracked by chezmoi)
- `run_onchange_` - Runs when the script content changes
- `before_` - Runs before main operations
- `after_` - Runs after main operations
- Numbers (e.g., `001`, `002`) - Control execution order within same phase
