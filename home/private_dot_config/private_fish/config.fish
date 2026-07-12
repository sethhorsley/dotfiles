if status is-interactive
end

# pnpm
set -gx PNPM_HOME "/Users/send-16/Library/pnpm"
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end

# Aliases migrated from ~/.zshrc and ~/.zsh-setup.
alias n nvim
alias cat bat

alias ls 'eza --grid --color auto --icons --sort=type'
alias ll 'eza --long --color always --icons --sort=type'
alias la 'eza --grid --all --color auto --icons --sort=type'
alias lla 'eza --long --all --color auto --icons --sort=type'
alias l 'eza -l --icons --git -a'
alias lt 'eza --tree --level=2 --long --icons --git'
alias ltree 'eza --tree --level=2 --icons --git'

alias server 'python -m http.server 4445'
alias ff 'aerospace list-windows --all | fzf --bind "enter:execute(aerospace focus --window-id {1})+abort"'
alias tn 'tmux new -s (basename $PWD)'
alias notes 'nvim ~/files/hub/iseth/notes'
alias oc opencode
alias jdm 'jj describe -m'
alias jcm 'jj commit -m'
alias jp 'jj git push'

alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'

alias cl clear
alias http xh

alias nvim-astro 'NVIM_APPNAME=AstroNvim nvim'
alias nvim-lazy 'NVIM_APPNAME=LazyVim nvim'
alias nvim-kick 'NVIM_APPNAME=kickstart nvim'
alias nvim-chad 'NVIM_APPNAME=NvChad nvim'
alias nvim-seth 'NVIM_APPNAME=nvim-seth nvim'
alias nvim-folke 'NVIM_APPNAME=FolkeNvim nvim'

alias rmdocker 'docker rm -f (docker ps -aq)'
alias r 'bin/rails'

if command -q zoxide
  set -gx _ZO_DATA_DIR "$HOME/.local/share"
  set -gx _ZO_ECHO 1
  zoxide init fish | source
  alias cd z
end
