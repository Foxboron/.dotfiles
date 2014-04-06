# Modified verion of this file:
# https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
# 


dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files=`ls -A ~/.dotfiles`    # list of files/folders to symlink in homedir

IgnoredFiles

containsElement () {
	  local e
	  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
	  return 1
      }

echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

##TODO: Make it skip dir's on the dots and make a ignore list

for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/.dotfiles_old
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
