ANTIGEN_PATH=~/dotfiles/zsh

source $ANTIGEN_PATH/.antigen/antigen.zsh

antigen init ~/.antigenrc

ZSH_PIP_INDEXES=(https://mirrors.ustc.edu.cn/pypi/web/simple/)


alias h="tldr"
alias ec="emacsclient -n -c -a ''"
alias p="proxychains -q -f ~/.config/proxychains/8877.conf"
alias p8080="proxychains -q -f ~/.config/proxychains/8080.conf"
# alias cat="ccat"
alias cat="bat"
# alias pwsh="TERM=xterm pwsh"
alias checksec="checksec --file"
alias amd="env DRI_PRIME=1"
# alias bro="2>/dev/null bro"
alias trid="LC_ALL=C trid"
alias c='tput reset'
alias del='trash'

EDITOR="emacsclient -n -c -a ''"

# [[ $- != *i* ]] && return 0
# [[ -z "$TMUX" ]] && exec tmux
