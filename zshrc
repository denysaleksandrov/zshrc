################################## aliases ####################################
alias mc="mc -as"
alias vim="/usr/local/bin/vim"
alias ls='ls' #--color=auto -F'
alias grep='egrep' #--colour=auto'

alias la='ls -la'
alias 1s='ls -1'

alias nmapa='nmap -P0 -sT -O -A'
alias nmapf='nmap -F'

alias mv="nocorrect mv -v"
alias cp="nocorrect cp -v"
alias mkdir="nocorrect mkdir"

alias less='less -R'
alias pi="ping"
alias pg="ping 8.8.8.8"
alias apt="aptitude"

###Git aliases###
alias gis="git status | sed -e '/Untracked files/,\$d'"
alias gl='git log'
alias glol='git log --graph --oneline'
alias gad='git add'
alias gcm='git commit -m'
alias gac='git add . && git commit -m'
alias gsh='git show'

[ -x /usr/sbin/traceroute-nanog ] && alias traceroute="traceroute-nanog"
alias jordan='ssh aleksandrov@193.19.247.116'
##### Juniper #####
alias up='cd ..'
alias cdc='cd ~/Documents/cases/sub-mgt/'
alias con-att-re0='telnet ipg-ts3-port27.jtac-emea.jnpr.net'
alias con-att-re1='telnet ipg-ts3-port26.jtac-emea.jnpr.net'
alias con-opti-re0='telnet ipg-ts3-port18.jtac-emea.jnpr.net'
alias con-opti-re1='telnet ipg-ts3-port16.jtac-emea.jnpr.net'
alias con-prim-re0='telnet ipg-ts3-port21.jtac-emea.jnpr.net'
alias con-prim-re1='telnet ipg-ts3-port29.jtac-emea.jnpr.net'

alias -g L='|less'
alias -g G='|grep'
alias -g Gi='|grep -i'
alias -g T='|tail'
alias -g H='|head'
alias -g N='&>/dev/null&'
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'
alias -g S='|sort'
alias -g U='|uniq -u'

alias -s exe=wine
alias -s {jpg,png,bmp,svg,gif}=gwenview
alias -s {avi,mpeg,mpg,mov,m2v}=mplayer
alias -s {odt,doc,sxw,rtf}=ooffice2
alias -s {ogg,mp3,wav,wma}=mpg123
alias -s pdf=preview
#alias -s {html,htm}=pick-web-browser
stty -ixon  
# Colorization
if [ "$TERM" != dumb ] && [ -x /usr/bin/grc ] ; then
	alias cl='/usr/bin/grc -es --colour=auto'
	alias configure='cl ./configure'
	alias diff='cl diff'
	alias make='cl make'
	alias gcc='cl gcc'
	alias g++='cl g++'
	alias as='cl as'
	alias gas='cl gas'
	alias ld='cl ld'
	alias netstat='cl netstat'
	alias ping='cl ping'
	alias tracepath='cl tracepath'
fi
		
# Midnight Commander chdir enhancement
if [ -f /usr/share/mc/mc.gentoo ]; then
	. /usr/share/mc/mc.gentoo
fi

historytop() {
	history 1 | awk '{s[$2]++}END{for(i in s){ print s[i], i}}' | sort -nr | head -n ${1:-10}
}

XXX() {
	real=`free | tail -n 2 | awk '{s+=$3}END{print s}'`
	psal=`ps -elf | awk '{s+=$10}END{print s}'`
	echo "( $real - $psal )/1000" | bc 
}

chroot() {
	if [ -x "$(which chname)" ]; then
		chname `hostname`/`basename $1` chroot $* 
	else 
		env PS1="`basename $1` $PS1" chroot $* 
	fi
}

konsole-rename-path() {
	if [ "$KONSOLE_DCOP_SESSION" ]
	then
		dcop `echo ${KONSOLE_DCOP_SESSION}` renameSession "`echo $PWD | sed s,^$HOME,~,`"
	fi
}

konsole-rename-cmd() { 
	if [ "$KONSOLE_DCOP_SESSION" ]
	then
		dcop `echo ${KONSOLE_DCOP_SESSION}` renameSession "$1"
	fi
}

konsolewrap() {
	dcop $KONSOLE_DCOP_SESSION renameSession "$*"
	exec $cmd "$@"
}

battery() {
        CBS=`acpi | awk '{print $4}' | awk -F % '{print $1}'`
        if [[ ${CBS} -lt 35 ]] && [[ ${CBS} -gt 10 ]]; then
                echo "%{ [33m%}${CBS}%%%{ [37m%}"
        elif [[ ${CBS} -lt 10 ]] || [[ ${CBS} -eq 10 ]]; then
                echo "%{ [31m%}${CBS}%%%{ [37m%}"
        else
                echo "%{ [32m%}${CBS}%%%{ [37m%}"
        fi
}

lsvm() {
	source /etc/rlab.conf
	reply=($(ls ${CONFIGDIR}))
}

#################################### load modules ####################################
autoload -U compinit
autoload -U promptinit
autoload -U zfinit
autoload -U incremental-complete-word
autoload -U predict-on
autoload -U zcalc
autoload -U colors
autoload -U pick-web-browser
autoload -U insert-files
compinit
promptinit
#prompt gentoo
zfinit
colors

zle -N incremental-complete-word
zle -N predict-on
zle -N predict-off
zle -N insert-files

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

compctl -o wget make man rpm
compctl -k hostsmy ssh telnet ping mtr traceroute
compctl -j -P "%" kill
compctl -g '*.gz' + -g '*(-/)' gunzip gzcat
compctl -g '*.rar' + -g '*(-/)' rar unrar
compctl -g '*(-/) .*(-/)' cd
compctl -g '(^(*.o|*.class|*.jar|*.gz|*.gif|*.a|*.Z|*.bz2))' + -g '.*' less vim
compctl -g '*' + -g '.*' vim
compctl -g '*.html' + -g '*(-/)' www-browser
compctl -k "(start stop create delete monitor edit)" -K lsvm rlab


#################################### history ####################################
setopt	APPEND_HISTORY
setopt	INC_APPEND_HISTORY
setopt	SHARE_HISTORY
setopt	HIST_IGNORE_ALL_DUPS
setopt	HIST_IGNORE_SPACE
setopt	HIST_REDUCE_BLANKS
setopt	HIST_VERIFY
setopt	HIST_EXPIRE_DUPS_FIRST

HISTFILE=~/.zhistory
HISTSIZE=90000
SAVEHIST=90000

#################################### colors ####################################
# 0-black, 1-red, 2-green, 3-yellow, 4-blue, 5-magenta 6-cyan, 7-white
C() { echo '%{\033[3'$1'm%}'; }
black=`C 0`; red=`C 1`; green=`C 2`; yellow=`C 3`; blue=`C 4`; magenta=`C 5`; cyan=`C 6`; white=`C 7`;default=`C 9`;
#export LS_COLORS="no=00:fi=00:di=01;32:ln=01;31:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jpg=01;35:*.png=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.png=01;35:*.mpg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:"

#################################### prompt ####################################

function _update_ps1() {
    #export PROMPT="$(~/powerline-zsh.py $?)"
    export PROMPT="$(~/powerline-zsh.py $? R)"
    export RPROMPT="$green%h$(~/powerline-zsh.py)"
}
precmd() {
    _update_ps1
}

source ~/.zsh/zshrc.zsh
source .zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
PROMPT="%B%(!.$red.$green)den@mac $blue%~ $green%(?..[%?])$red%(!.#.$)%b\$(git_super_status) "
#RPROMPT="$red<$green%h$red]$cyan%B%*%b" # "$yellow%y%b$white"

#################################### watch for login/logout events ################
watch=(all)
LOGCHECK=180
WATCHFMT='%n %a %l from %M at %T.'


#################################### env ####################################
# Some environment variables
#export MAIL=/var/spool/mail/$USERNAME
#export LESS=-cex3M
#export manpath=($X11HOME/man /usr/man /usr/lang/man /usr/local/man /usr/share/man)
export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs
#because .zshenv is loaded very first, many fucken systems overload that settings
#thatwhy i put ENV here
#export PATH=/usr/local/bin:/usr/sbin:/sbin:/usr/local/sbin:~/bin:/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/sbin:/sbin:/usr/local/sbin:~/bin:/usr/bin:/bin:/opt/X11/bin:$PATH
export STARDICT_DATA_DIR=/Users/daleksandrov/.stardict
export CLASSPATH=$CLASSPATH:~/ownCloud/dev/java/Princeton/AlghoritmsPart1/algs4/stdlib.jar:~/ownCloud/dev/java/Princeton/AlghoritmsPart1/algs4/algs4.jar
export EDITOR="vim"
export PAGER="less"

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# Hosts to use for completion (see later zstyle)
hosts=(`hostname` `getent hosts | awk '{print $2}'` toshiba ubiquity storage coffee fly viii hosting5 noc f ya.ru google.com ftp.ntu-kpi.kiev.ua acts rada.khmelnytsky.com storage.ntu-kpi.kiev.ua)

# Autoload all shell functions from all directories in $fpath (following symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

#export LC_ALL=ru_RU.UTF-8

export SSH_ASKPASS=$(which ssh-askpass)

#################################### options ####################################
setopt	EXTENDEDGLOB     # file globbing is awesome
setopt	AUTOCD           # jump to the directory.
setopt	NO_BEEP          # self explanatory
setopt	COMPLETE_IN_WORD #allow tab completion in the middle of a word
setopt	ALWAYS_TO_END    # Push that cursor on completions.
setopt	AUTOMENU         # Tab-completion should cycle.
setopt	AUTOLIST         # ... and list the possibilities.
setopt	AUTO_PARAM_SLASH # Make directories pretty.
setopt	AUTO_NAME_DIRS   # change directories  to variable names
setopt	GLOB_DOTS        # . not required for correction/completion
setopt	CLOBBER	        # Allows  `>'  redirection to truncate existing files, and `>>' to create files

setopt   LONG_LIST_JOBS AUTO_RESUME AUTO_CONTINUE NOTIFY #jobs

#setopt	nocorrect nocorrectall correct correctall
setopt   REC_EXACT RC_QUOTES CDABLE_VARS
setopt   AUTO_PUSHD PUSHD_MINUS PUSHD_TO_HOME

#################################### limits ####################################
unlimit
limit stack 8192
limit core 0
limit -s
umask 022


#################################### kbd ####################################
#x-xterm, s-screen, l-linux

#^A, ^E  +xsl
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

#Home, End +x
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
#Home, End, +s
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
#Home, End -
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line

#^B, Delete +xsl
bindkey "^B" delete-char
bindkey "^[[3~" delete-char

#ctrl+<- +x
bindkey "^[[1;5D" backward-word
#bindkey "^[[C" forward-word

bindkey "^o" beep
# Some nice key bindings
#bindkey '^X^Z' universal-argument ' ' magic-space
#bindkey '^X^A' vi-find-prev-char-skip
#bindkey '^Xa' _expand_alias
#bindkey '^Z' accept-and-hold
#bindkey -s '\M-/' \\\\
#bindkey -s '\M-=' \|
#bindkey -v               # vi key bindings
#bindkey -e                 # emacs key bindings
#bindkey ' ' magic-space    # also do history expansion on space
#bindkey '^I' complete-word # complete on tab, leave expansion to _expand

## Shell functions
#setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
#freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

bindkey "^X^X" predict-on
bindkey "^X^Z" predict-off

# history search
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

#bindkey    "^[[A" history-search-backward
#bindkey -a "^[p" history-search-backward
#bindkey    "^[[B" history-search-forward
#bindkey -a "^[n" history-search-forward

#bindkey "^R" history-search-backward
#bindkey "^S" history-search-forward

#################################### Completion Styles ####################################

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/5 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle '*' hosts $hosts
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' '*?.old' '*?.pro'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' max-errors 2
zstyle :compinstall filename '.zshrc'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' completer _expand _complete _correct _approximate
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#zstyle ':completion:*' menu yes select

zstyle ':completion:*' completer _complete _list _oldlist _expand _ignored _match _correct _approximate _prefix
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' add-space true

#zstyle ':completion:*:processes' command 'ps -au$USER'
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
zstyle ':completion:*:processes' command 'ps -xuf'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command 'ps xho command'

zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' old-menu false
zstyle ':completion:*' original true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle ':completion:*' word true


#pwd() {
#	echo "Know you not where you are. Show you I shall."
#}
#uptime() {
#	echo "When 900 years you be, look this good you will not."
#}
#cd /win95="Once you start down the Dark Path, forever will it dominate your destiny!"
#winnuke 192.168.1.0="That, my friend, will lead you to the dark side. Help you I will not."
#rm -rf /="Idiot you are. Yeeesss."
#shutdown -h now="Luke... there is... another... Sky... walker..."
export TERM='xterm-256color'
