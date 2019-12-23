bindkey -e  # Emacs 键绑定

bindkey '^[[1;5C' forward-word   # C-Right
bindkey '^[[1;3C' forward-word   # M-Right
bindkey '^[[1;5D' backward-word  # C-Left
bindkey '^[[1;3D' backward-word  # M-Left
bindkey ' ' magic-space  # 按空格展开历史
bindkey "^w" kill-region

export FZF_DEFAULT_OPTS='--color=bg+:23'

# 快速目录跳转, M-c 触发
function fz-zjump-widget() {
    local selected=$(z | fzf -n "2.." --tiebreak=end,index --tac --prompt="jump> ")
    if [[ "$selected" != "" ]] {
        builtin cd "${selected[(w)2]}"
    }
    zle reset-prompt
}
zle     -N    fz-zjump-widget
bindkey '\ec' fz-zjump-widget

# 搜索历史, C-r 触发
function fz-history-widget() {
    local selected=$(fc -rl 1 | fzf -n "2.." --tiebreak=index --prompt="cmd> ")
    if [[ "$selected" != "" ]] {
        zle vi-fetch-history -n $selected
    }
}
zle     -N   fz-history-widget
bindkey '^R' fz-history-widget

# 搜索文件, M-s 触发
# 会将 * 或 ** 替换为搜索结果
# 前者表示搜索单层, 后者表示搜索子目录
function fz-find() {
    local selected dir cut
    cut=$(grep -oP '[^* ]+(?=\*{1,2}$)' <<< $BUFFER)
    eval "dir=${cut:-.}"
    if [[ $BUFFER == *"**"* ]] {
        selected=$(fd -H . $dir | fzf --tiebreak=end,length --prompt="cd> ")
    } elif [[ $BUFFER == *"*"* ]] {
        selected=$(fd -d 1 . $dir | fzf --tiebreak=end --prompt="cd> ")
    }
    BUFFER=${BUFFER/%'*'*/}
    BUFFER=${BUFFER/%$cut/$selected}
    zle end-of-line
}
zle     -N    fz-find
bindkey '\es' fz-find

# zce 自动使用上一条历史记录
function zce() {
    [[ -z $BUFFER ]] && zle up-history
    with-zce zce-raw zce-searchin-read
}
zle -A zce zce
bindkey "\ej" zce

# 快速添加括号
function add-bracket() {
    BUFFER[$CURSOR+1]="($BUFFER[$CURSOR+1]"
    BUFFER+=')'
}
zle -N add-bracket
bindkey "\e(" add-bracket

# 快速跳转到上级目录: ... => ../..
# https://grml.org/zsh/zsh-lovers.html
function rationalise-dot() {
    if [[ $LBUFFER = *.. ]] {
        LBUFFER+=/..
    } else {
        LBUFFER+=.
    }
}
zle -N rationalise-dot
bindkey . rationalise-dot