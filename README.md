dotfiles
========

my dotfiles.

## Usage

###Vim

####Build Vim

Clone Vim

```
mkdir -p ~/git
git clone git@github.com:b4winckler/vim.git ~/git/vim
```

[Build Vim](http://vim.wikia.com/wiki/Building_Vim) with Python and Ruby enabled:

```
cd ~/git/vim
./configure \
    --enable-gui=gnome3 \
    --enable-multibyte \
    --enable-pythoninterp \
    --enable-rubyinterp \
    --with-ruby-command=/usr/bin/ruby \
    --with-features=huge
```

####Set up Vim

Clone this repository and symlink dotfiles

```
cd ~
git clone git@github.com:daeyun/dotfiles.git
ln -nsf ~/dotfiles/.vim* .
```

Set up Vundle

```
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
```

Set up [YouCompleteMe](https://github.com/Valloric/YouCompleteMe):

```
apt-get install cmake
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
```
