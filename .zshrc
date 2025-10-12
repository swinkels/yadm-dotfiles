# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(direnv git tmux virtualenv z)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Redefine the prompt from the Robby Russel theme to
# 1. show the active virtualenv, if any,
# 2. show the complete path instead of just the last directory,
# 3. show the Git info on the right-hand side and
# 4. remove the parenthesis around the Git branch name.
#
# These are the modifications to the default Robby Russel prompt:
#
# - to address 1) $(virtualenv_prompt_info) was added to PROMPT,
# - to address 2) %c was changed to %~,
# - to address 3) $(git_prompt_info) was moved to RPROMPT and
# - to address 4) the parenthesis were removed from the ZSH_THEME_GIT_PROMPT...
#   variables.

PROMPT='$(virtualenv_prompt_info)'
PROMPT+="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=" %{$fg[cyan]%}%~%{$reset_color%} "
RPROMPT='$(git_prompt_info)'

ZSH_THEME_VIRTUALENV_PREFIX="("
ZSH_THEME_VIRTUALENV_SUFFIX=") "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"

# Integrate fzf with Zsh. This enables the well-known fzf keyboard shortcuts such as
# CTRL+R to browse your command history.

if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
fi

# Integrate fzf with z, so if you execute z without parameters, you can use fzf
# to select a directory known to z
#
# This snippet is from https://github.com/junegunn/fzf/wiki/Examples#integration-with-z
unalias z 2> /dev/null
z() {
    [ $# -gt 0 ] && _z "$*" && return
    cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

# Emacs Tramp doesn't play nice with Zsh (although I don't know anymore what the
# actual issue was that I encountered).
#
# This snippet is from https://www.emacswiki.org/emacs/TrampMode#h5o-9 I've
# slightly adjusted it as originally, the "||" (or) was also an "&&" (and). The
# change lets the statement succeed even if the terminal is "dumb". As it's the
# last line of this file, the first prompt of zsh won't indicate that the
# previous command failed.

[[ $TERM != "dumb" ]] || (unsetopt zle && PS1='$ ')

# let uv only use the Python versions it manages itself
#
# When you use the Python version that comes with your OS, that might be
# upgraded to a newer, major version without you realizing. As in "pulled from
# underneath you".
export UV_MANAGED_PYTHON=True

# when uv runs in Emacs [^1], use of progress output slows down uv execution
#
# [^1]: observed in Emacs 29.4 and uv 0.7.9
if [[ -n $INSIDE_EMACS ]]; then
    export UV_NO_PROGRESS=True
fi

# keep as last statement so a local config can override standard settings
source ~/.zshrc.local
