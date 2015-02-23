SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

set -o xtrace

ln -nsf $DIR/.vim* ~/
ln -nsf $DIR/.vimrc ~/.nvimrc
ln -nsf $DIR/.vim ~/.nvim

ln -nsf $DIR/.screenrc ~/
ln -nsf $DIR/.Xdefaults ~/
ln -nsf $DIR/.gitconfig ~/
ln -nsf $DIR/.i3 ~/
