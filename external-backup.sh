syncMethod='rsync -av'
syncWithSymlinks='rsync -av --copy-links'
externalHDD='/Volumes/ExternMac/_consolidated/'

if [ ! -d "${externalHDD}" ]; then
	echo "The directory ${externalHDD} does not exist. Either plug in your external HDD or correct the directory for externalHDD within ~/dotfiles/external-backup.sh"
	exit
fi

# Ensure all destinations(the second argument) end with a trailing slash. Otherwise the folders being backed up will be made subdirectories of the destination.
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

if [ ! -d "${externalHDD}Code" ]; then
	# Ensure the Code directory exists before backing up subdirectories to it.
	mkdir "${externalHDD}Code"
fi
${syncMethod} ~/Code/snippets/ ${externalHDD}Code/snippets/

if [ ! -d "${externalHDD}Code/projects" ]; then
	# Ensure the Code/projects directory exists before backing up subdirectories to it.
	mkdir "${externalHDD}Code/projects"
fi
${syncWithSymlinks} ~/dotfiles/projects/ ${externalHDD}Code/projects/
