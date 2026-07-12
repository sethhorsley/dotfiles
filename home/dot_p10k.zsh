# Config file for Powerlevel10k with the style of robbyrussell theme from Oh My Zsh.
#
# Original: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes#robbyrussell.
#
# Replication of robbyrussell theme is exact. The only observable difference is in
# performance. Powerlevel10k prompt is very fast everywhere, even in large Git repositories.
#
# Usage: Source this file either before or after loading Powerlevel10k.
#
#   source ~/powerlevel10k/config/p10k-robbyrussell.zsh
#   source ~/powerlevel10k/powerlevel10k.zsh-theme

# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob

  # Unset all configuration options.
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'

  # Zsh >= 5.1 is required.
  [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return

  # Left prompt segments.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(prompt_char dir my_vcs)
  # Right prompt segments.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

  # Basic style options that define the overall prompt look.
  typeset -g POWERLEVEL9K_BACKGROUND=                            # transparent background
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '  # separate segments with a space
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=        # no end-of-line symbol
  typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION=           # no segment icons

  # Green prompt symbol if the last command succeeded.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS}_FOREGROUND=green
  # Red prompt symbol if the last command failed.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS}_FOREGROUND=red
  # Prompt symbol: bold arrow.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_CONTENT_EXPANSION='%B➜ '

  # Cyan current directory.
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=cyan
  # Show only the last segment of the current directory.
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
  # Bold directory.
  typeset -g POWERLEVEL9K_DIR_CONTENT_EXPANSION='%B$P9K_CONTENT'

  # VCS segment: jj when in a jj repo, git otherwise.
  function prompt_my_vcs() {
    if jj root --quiet &>/dev/null; then
      local jj_status
      jj_status=$(jj log -n1 --no-graph -T \
        'coalesce(bookmarks.join(", "), change_id.shortest(8)) ++ "|" ++ if(!empty, "dirty", "clean")' \
        2>/dev/null) || return
      local label=${jj_status%|*}
      [[ -z $label ]] && return
      local dirty=""
      [[ ${jj_status##*|} == dirty ]] && dirty=" %3F✗"
      p10k segment -f 4 -t "%Bjj:(%1F${label//\%/%%}%4F)${dirty}"
    else
      local branch
      branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null) || return
      local dirty=""
      [[ -n $(git status --porcelain 2>/dev/null) ]] && dirty=" %3F✗"
      p10k segment -f 4 -t "%Bgit:(%1F${branch//\%/%%}%4F)${dirty}"
    fi
  }

  # Instant prompt mode.
  #
  #   - off:     Disable instant prompt. Choose this if you've tried instant prompt and found
  #              it incompatible with your zsh configuration files.
  #   - quiet:   Enable instant prompt and don't print warnings when detecting console output
  #              during zsh initialization. Choose this if you've read and understood
  #              https://github.com/romkatv/powerlevel10k/blob/master/README.md#instant-prompt.
  #   - verbose: Enable instant prompt and print a warning when detecting console output during
  #              zsh initialization. Choose this if you've never tried instant prompt, haven't
  #              seen the warning, or if you are unsure what this all means.
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

  # Hot reload allows you to change POWERLEVEL9K options after Powerlevel10k has been initialized.
  # For example, you can type POWERLEVEL9K_BACKGROUND=red and see your prompt turn red. Hot reload
  # can slow down prompt by 1-2 milliseconds, so it's better to keep it turned off unless you
  # really need it.
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  # If p10k is already loaded, reload configuration.
  # This works even with POWERLEVEL9K_DISABLE_HOT_RELOAD=true.
  (( ! $+functions[p10k] )) || p10k reload
}

# Tell `p10k configure` which file it should overwrite.
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
