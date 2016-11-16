
source ~/.antigen/antigen.zsh

antigen use oh-my-zsh

# Git
antigen bundle git
antigen bundle gitfast

# Common
antigen bundle common-aliases
antigen bundle extract

# Vim
antigen bundle vim-interaction

# Antigen
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

# Theme
antigen theme robbyrussell

antigen apply

export EDITOR=vim

export PATH=~/bin:${PATH};

