syncMethod='rsync -av'
externalHDD='/Volumes/ExternMac/_consolidated/'

if [ ! -d "${externalHDD}" ]; then
	echo "The directory ${externalHDD} does not exist. Either plug in your external HDD or correct the directory for externalHDD within ~/dotfiles/external-backup.sh"
	exit
fi

${syncMethod} ~/Files/ ${externalHDD}Files/
${syncMethod} ~/Resources/ ${externalHDD}Resources/
${syncMethod} ~/dotfiles/ ${externalHDD}dotfiles/
${syncMethod} ~/.ssh/ ${externalHDD}.ssh/
${syncMethod} ~/Dropbox/todo/ ${externalHDD}todo/

if [ ! -d "${externalHDD}sublime-text/Packages/TodoTxt/" ]; then
	# Ensure nested directories exist for Sublime Text
	mkdir "${externalHDD}sublime-text/"
	mkdir "${externalHDD}sublime-text/Packages"
fi
${syncMethod} ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/TodoTxt/ ${externalHDD}sublime-text/Packages/TodoTxt/
${syncMethod} ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/ ${externalHDD}sublime-text/User/;