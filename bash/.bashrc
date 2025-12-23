# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

#User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
export TERM=xterm-256color
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

PS1='\u@\h:\w\$ '

# Starship
# eval "$(starship init bash)"

alias n='nnn -deH'
alias bld='./build.sh'
alias ll='ls -alF --color=auto'
alias ytdlpp='yt-dlp -o "%(playlist_index)s - %(title)s.%(ext)s" -x '
alias ytdlpsv='yt-dlp -f 'bv*[height=1080]+ba' '
alias ytdlpsa='yt-dlp -x '
alias ff='fastfetch'
alias ghmd='gh markdown-preview'
alias rgf='rg --no-heading -n'
alias docs='fzf | xargs w3m'

set -o vi

export EDITOR=vim
export VISUAL=vim

# bind 1-9 to specific projects in Bookmarks for better navigation if needed
export NNN_BMS="d:~/.dotfiles;s:~/scripts;p:~/projects;b:~/books/coding;n:~/notes;e:~/notes/errors;l:~/learning"
export NNN_PLUG='f:fzopen;x:!chmod +x "$nnn";g:!git log;u:!unzip "$nnn";b:!nohup zathura "$nnn" & exit;m:!gh markdown-preview "$nnn"'

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export PATH="/usr/share/applications/:$PATH"

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib64/pkgconfig

# export MANPATH="/usr/share/man""

export ASAN_OPTIONS=abort_on_error=1:halt_on_error=1
export UBSAN_OPTIONS=abort_on_error=1:halt_on_error=1

bind -f /etc/inputrc
export XDG_RUNTIME_DIR=/run/user/1000

#. "$HOME/.cargo/env"

