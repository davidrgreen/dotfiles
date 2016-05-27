export PATH="/Users/davidgreen/pear/bin:$PATH"
. /Users/davidgreen/cmds/z/z.sh # Add the Z command
alias myip='curl ip.appspot.com'
alias mylocalip='ipconfig getifaddr en1'
alias proj='cd /Users/davidgreen/Files/projects/current'
alias sitesetup='cd /Users/davidgreen/Dropbox/Web-Dev-Backup/_CustomWPSetup/wpdev-jumpstart-script/'
alias websites='cd /Users/davidgreen/vagrant-local/www'
alias edit='subl'                           # edit:         Opens any file in sublime editor
alias f='open -a Finder ./'                 # f:     Opens current directory in MacOS Finder
alias edithosts='sudo subl /etc/hosts'
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias ls='ls -AFhp'
alias reloadbash='source ~/.bash_profile'
alias editbash='edit ~/.bash_profile'
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias numfiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias flushdns='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias v='cd ~/vagrant-local'
alias vup='( cd ~/vagrant-local ; vagrant up )'
alias vhalt='( cd ~/vagrant-local ; vagrant halt )'
alias vstatus='( cd ~/vagrant-local ; vagrant status )'
# Enhanced WHOIS lookups
alias whois="whois -h whois.internic.net"
alias rmdir="rm -rf"

# git commands
alias gs="git status"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%n' --abbrev-commit | cat"

# Show month's calendar with today highlighted
alias cal="cal | grep -E --color '\b`date +%e`\b|$'"

# count lines of code in folder and subdirectories
alias countcode="find . -name '*.php' -o -name '*.js' -o -name '*.css' -o -name '*.html' -o -name '*.js' -not -path "./node_modules" | xargs wc -l"


# todo.txt commands

#PATH=$PATH:"/usr/local/Cellar/todo-txt/2.10/bin"

export TODOTXT_DEFAULT_ACTION=ls
export TODOTXT_AUTO_ARCHIVE=0
export TODOTXT_DATE_ON_ADD=0
#source /usr/local/Cellar/todo-txt/2.10/etc/bash_completion.d/todo_completion complete -F _todo t
alias t='/usr/local/Cellar/todo-txt/2.10/bin/todo.sh -taf -d $HOME/Dropbox/todo/todo.cfg'
alias tdate='t view date'
alias tpri='t ls \('
alias treport='t birdseye'
alias txp='t xp -o 7'
alias today='t ls due:$(date "+%Y-%m-%d")'
alias tomorrow='t ls due:$(date -j -v+1d +"%Y"-"%m"-"%d")'
alias yesterday='t ls due:$(date -j -v-1d +"%Y"-"%m"-"%d")'
alias tupcoming='t view date'
alias tproj='t listproj'
alias tviewproj='t view project'
alias tcon='t listcon'
alias tedit='edit $HOME/Dropbox/todo/todo.txt'
alias teditdone='edit $HOME/Dropbox/todo/done.txt'
alias tcommands='ls $HOME/.todo.actions.d'


mitcolor='\033[1;33m'
NC='\033[0m' # No Color

#alias hello="cal ; today ; echo '' ; cat $HOME/Dropbox/todo/mit.txt"
alias hello="cal ; today "
alias calm="open http://www.calm.com"
alias goodnight="echo 'Look at todo.txt and create your notecard for tomorrow. Then forget about work for the rest of the day.'"

# Write my MIT (Most Important Task) to mit.txt in Dropbox/todo
mit () { echo -e "${mitcolor}$@\nIf I do this, and only this, today will be a good day.${NC}" > $HOME/Dropbox/todo/mit.txt; } 


# Execute hello command whenever terminal is opened
# Might need to remove it if it interferes with stuff
hello

zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }


#   cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
    cdf () {
        currFolderPath=$( /usr/bin/osascript <<EOT
            tell application "Finder"
                try
            set currFolder to (folder of the front window as alias)
                on error
            set currFolder to (path to desktop folder as alias)
                end try
                POSIX path of currFolder
            end tell
EOT
        )
        echo "cd to \"$currFolderPath\""
        cd "$currFolderPath"
    }

# Shell prompt based on the Solarized Dark theme.
# Screenshot: http://i.imgur.com/EkEtphC.png
# Heavily inspired by @necolas’s prompt: https://github.com/necolas/dotfiles
# iTerm → Profiles → Text → use 13pt Monaco with 1.1 vertical spacing.

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color';
fi;

prompt_git() {
	local s='';
	local branchName='';

	# Check if the current directory is in a Git repository.
	if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null;

			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				s+='+';
			fi;

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				s+='!';
			fi;

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+='?';
			fi;

			# Check for stashed files.
			if $(git rev-parse --verify refs/stash &>/dev/null); then
				s+='$';
			fi;

		fi;

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo '(unknown)')";

		[ -n "${s}" ] && s=" [${s}]";

		echo -e "${1}${branchName}${blue}${s}";
	else
		return;
	fi;
}

if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	# Solarized colors, taken from http://git.io/solarized-colors.
	black=$(tput setaf 0);
	blue=$(tput setaf 33);
	cyan=$(tput setaf 37);
	green=$(tput setaf 64);
	orange=$(tput setaf 166);
	purple=$(tput setaf 125);
	red=$(tput setaf 124);
	violet=$(tput setaf 61);
	white=$(tput setaf 15);
	yellow=$(tput setaf 136);
else
	bold='';
	reset="\e[0m";
	black="\e[1;30m";
	blue="\e[1;34m";
	cyan="\e[1;36m";
	green="\e[1;32m";
	orange="\e[1;33m";
	purple="\e[1;35m";
	red="\e[1;31m";
	violet="\e[1;35m";
	white="\e[1;37m";
	yellow="\e[1;33m";
fi;

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="${red}";
else
	userStyle="${orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${bold}${red}";
else
	hostStyle="${yellow}";
fi;

# Set the terminal title to the current working directory.
PS1="\[\033]0;\w\007\]";
PS1+="\[${bold}\]\n"; # newline
PS1+="\[${userStyle}\]\u"; # username
PS1+="\[${white}\] at ";
PS1+="\[${hostStyle}\]\h"; # host
PS1+="\[${white}\] in ";
PS1+="\[${green}\]\w"; # working directory
PS1+="\$(prompt_git \"${white} on ${violet}\")"; # Git repository details
PS1+="\n";
PS1+="\[${white}\]\$ \[${reset}\]"; # `$` (and reset color)
export PS1;

PS2="\[${yellow}\]→ \[${reset}\]";
export PS2;
