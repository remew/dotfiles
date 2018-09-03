# 少し凝った zshrc
# License : MIT
# http://mollifier.mit-license.org/

########################################
# 環境変数
export LANG=ja_JP.UTF-8
export EDITOR=vim
export PATH=$PATH:$HOME/workspace/tools/bin


# 色を使用出来るようにする
autoload -Uz colors
colors

# emacs 風キーバインドにする
bindkey -e

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプト
# 1行表示
# PROMPT="%~ %# "
# 2行表示
# PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
# %# "

autoload -Uz vcs_info
setopt prompt_subst
# zstyle ':vcs_info:*' formats '%s][* %F{green}%b%f'
# zstyle ':vcs_info:*' actionformats '%s][* %F{green}%b%f(%F{red}%a%f)'
zstyle ':vcs_info:*' formats '%F{blue}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

precmd() {
    vcs_info
PROMPT="%{${fg[blue]}%}[%n@%m %T]%{${reset_color}%}%~%f
${vcs_info_msg_0_}%# "
}

# コマンド修正
setopt correct
SPROMPT="%R -> %r? [y,n]: "

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
# rootの際はセキュリティ上無効化
if [ "$USER" != "root" ]; then
    autoload -Uz compinit
    compinit
fi

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
    /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

########################################
# エイリアス

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'

alias cdg='cd $(ghq root)/$(ghq list | peco)'
alias cdroot='cd $(git rev-parse --show-toplevel)'
alias npmrun='npm run $(show-npm-scripts | peco | cut -f 1 -d " ")'

function show-npm-scripts() {
    cat package.json|jq -r ".scripts | to_entries[] | \"\(.key),\(.value)\"" | column -t -s,
}

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

# ドットを打つたびに上のディレクトリへ
# http://qiita.com/momo-lab/items/523fc83fbfa39fa5fd60
function replace_multiple_dots() {
    local dots=$LBUFFER[-2,-1]
    if [[ $dots == ".." ]]; then
        LBUFFER=$LBUFFER[1,-3]'../.'
    fi
    zle self-insert
}

zle -N replace_multiple_dots
bindkey "." replace_multiple_dots


########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac

function peco-history-selection() {
    # BUFFER=`history -n 1 | tail -r | awk '!a[$0]++' | peco`
    # BUFFER=`history -n 1 | awk '!a[$0]++' | peco`
    BUFFER=`history -n 1 | tac | peco --query "$LBUFFER"`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# vim:set ft=zsh:


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
