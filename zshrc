export LC_ALL=en_US.UTF-8
export PKGCONFIG_PATH="/usr/local/lib/pkgconfig:/opt/local/lib/pkgconfig"
export PATH=$PATH:/opt/local/bin:/usr/local/mysql/bin/
export PATH=$PATH:~/.bin
export SVN_EDITOR="vim"
export MANPATH=/opt/local/man:$MANPATH
export GEM_PATH=/usr/lib/ruby/gems/1.8
# number of lines kept in history
export HISTSIZE=10000
# number of lines saved in the history after logout
export SAVEHIST=10000
# location of history
export HISTFILE=~/.zhistory
# history options
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_allow_clobber
setopt hist_reduce_blanks
setopt share_history

setopt list_types

# directory options
setopt auto_cd
setopt auto_pushd

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

# console colors
autoload -U colors && colors
# completion
autoload -U compinit && compinit
# colorize completion
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=$color[cyan]=$color[red]"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
# prevent CVS and SVN from being completed
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'
# ignore completion functions
zstyle ':completion:*:functions' ignored-patterns '_*'
# ignore what's already selected on line
zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes
# hosts completion for some commands
#local knownhosts
#knownhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} ) 
#zstyle ':completion:*:(ssh|scp|sftp):*' hosts $knownhosts
compctl -k hosts ftp lftp ncftp ssh w3m lynx links elinks nc telnet rlogin host
compctl -k hosts -P '@' finger

# manpage comletion
man_glob () {
  local a
  read -cA a
  if [[ $a[2] = -s ]] then
  reply=( ${^manpath}/man$a[3]/$1*$2(N:t:r) )
  else
  reply=( ${^manpath}/man*/$1*$2(N:t:r) )
  fi
}

compctl -K man_glob -x 'C[-1,-P]' -m - 'R[-*l*,;]' -g '*.(man|[0-9nlpo](|[a-z]))' + -g '*(-/)' -- man
# fuzzy matching
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
# completion cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# remove trailing slash in directory names, useful for ln
zstyle ':completion:*' squeeze-slashes true

# global aliases
alias -g H='| head'
alias -g T='| tail'
alias -g G='| ack'
alias -g L="| less"
alias -g M="| most"
alias -g B="&|"
alias -g HL="--help"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

# Begin Mercurial Hacks
# http://markmail.org/message/gyc6l3t7hxcvaft5

export LC_ALL=en_US.UTF-8 
export LANG=en_US.UTF-8
# End Mercurial hacks

export PATH=$PATH:/opt/local/bin:/usr/local/mysql-5.0.45-osx10.4-i686/bin/

# ensures that deleting word on /path/to/file deletes only 'file', this removes the '/' from $WORDCHARS
export WORDCHARS="${WORDCHARS:s#/#}"
export WORDCHARS="${WORDCHARS:s#.#}"
export CUCUMBER_COLORS=pending_param=magenta:failed_param=magenta:passed_param=magenta:skipped_param=magenta

parse_git_branch() {
 	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function title () {
  unset PROMPT_COMMAND # more on this later
  echo -ne "\e]0;$1\a"
}

function precmd {
	PS1="%{$fg[yellow]%}%~ %{$fg[green]%}$(parse_git_branch)%{$reset_color%}%{$fg[yellow]%}ϡ%{$reset_color%} "	
}

typeset -U fpath
autoload -U _git

alias ll="ls -l"
alias i="sudo port install"
alias up="sudo port upgrade"
alias gi="gem install"
alias ctags="/usr/local/Cellar/ctags/5.8/bin/ctags"
alias refreshctags="ctags -f tags --recurse=yes . && find . -name '*.rb' -o -name '*.java' -o -name '*.cs' -o -name '*.js' -o -name '*.haml' -o -name '*.erb' >| cscope.files && cscope -b -q"

export PATH="$PATH:$HOME/.nvm/v0.4.7/bin"

export ANT_HOME="~/Documents/tools/ant"
export PATH="$PATH:$ANT_HOME/bin"

alias mcom='rake compile MONO_LIB=/Library/Frameworks/Mono.framework/Versions/2.6/lib/'
alias mrun='mono $MERLIN_ROOT/bin/mono_debug/ir.exe'

function rails_command {
  local cmd=$1
  shift
  if [ -e script/rails ]; then
    script/rails $cmd "$@"
  else
    script/$cmd "$@"
  fi
}
function ss { rails_command "server" "$@" }                                                                                                                                                                                             
function ssp { rails_command "server" "-p" "$@"}
function sc { rails_command "console" "$@" }
function sg { rails_command "generate" "$@" }
alias sp=spork
alias r=rake

alias vi=vim
alias ep="vim ~/.zshrc && source ~/.zshrc"
if [ -f /Applications/MacVim.app/Contents/MacOS/Vim ]; then
  alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
  export GIT_EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim"
fi
export EDITOR="vim"
alias mig="script/generate migration"
alias srebase="ls > temp.file.for.stashing && git add temp.file.for.stashing && git sh save && git svn rebase && git sh pop && git rm -f temp.file.for.stashing"
alias sdcommit="ls > temp.file.for.stashing && git add temp.file.for.stashing && git sh save && git svn dcommit && git sh pop && git rm -f temp.file.for.stashing"
alias checkandinstall="bundle check || bundle install"

# folder aliases
[[ -e ~/.zshrc-aliases ]] && source ~/.zshrc-aliases

# stuff to print on new prompts
fortune -a
uptime

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

. ~/.nvm/nvm.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
