# Modified verion of this file:
# https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
# 

root_dir=~

dir=$root_dir/.dotfiles                    # dotfiles directory
olddir=$root_dir/.dotfiles_old             # old dotfiles backup directory


echo -n "Creating $olddir for backup of any existing dotfiles in $root_dir ..."
mkdir -p $olddir
echo "done"

echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"
echo ""

# Sometimes we just want the bare bones
# Expand to more options later on
case "$1" in
    bare) 
        files=`find . -type f \( -wholename "./vimrc" -or -wholename "./zshrc" -prune \)` ;;
    *) 
        files=`find . -type f -not \( -wholename "*./.git*" -or -wholename "./init.sh" -or -wholename "./README.md" -prune \)` ;;
esac




# Dir or files you don't want dotted
no_dot=("./util" "./bin")


function elementExists() {
    elements=${1}
    element=${2}
    for i in ${elements[@]} ; do
        if [ $i == $element ] ; then
            echo "Yes"
        fi
    done
}


echo "Moving any existing dotfiles from $root_dir to $olddir"

for file in $files; do
    rel_path=`dirname $file`
    file_name=`basename $file`
    in_array=`elementExists $no_dot $rel_path`
    
    echo "Creating symlink to $file_name in home directory."

    # File is in root, and we dot it.  
    if [ $rel_path == "." ]; then
        new_home_dir=$root_dir/$rel_path

        mv $root_dir/.$file_name $root_dir/.dotfiles_old 2>/dev/null
        ln -s `pwd`/$file_name $new_home_dir/.$file_name
        echo ""
    
    # File or dir is not suppose to be dotted
    elif [[ $in_array ]]; then
        new_home_dir=$root_dir/$rel_path
        mkdir -p $new_home_dir

        mv $new_home_dir/$file_name $root_dir/.dotfiles_old/$dotted_dir 2>/dev/null

        ln -s `pwd`/$file $new_home_dir/$file_name
    
    # Found a dir which is suppose to be dotted
    else
        dotted_dir=`sed s:\./\:\./\.: <<< "$rel_path"`
        new_home_dir=$root_dir/$dotted_dir

        mkdir -p $new_home_dir

        mv $new_home_dir/$file_name $root_dir/.dotfiles_old/$dotted_dir 2>/dev/null

        ln -s `pwd`/$file $new_home_dir/$file_name
    fi

done

install_zsh () {
    # Test to see if zshell is installed. If it is:
    if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
        # Clone my oh-my-zsh repository from GitHub only if it isn't already present
        if [[ ! -d $root_dir/oh-my-zsh/ ]]; then
            cd $root_dir
            git clone http://github.com/robbyrussell/oh-my-zsh.git
        fi
        # Set the default shell to zsh if it isn't currently set to zsh
        if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
            chsh -s $(which zsh)
        fi
}
install_zsh
