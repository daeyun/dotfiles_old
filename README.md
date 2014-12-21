dotfiles
========

my dotfiles.

## Usage

### Vim

#### Dependencies

##### clang-format

Download from [http://llvm.org/releases/download.html](http://llvm.org/releases/download.html)

```
wget http://llvm.org/releases/3.5.0/clang+llvm-3.5.0-macosx-apple-darwin.tar.xz
tar -xJf clang+llvm-3.5.0-macosx-apple-darwin.tar.xz
mkdir -p ~/usr/bin/ && cp clang+llvm-3.5.0-macosx-apple-darwin/bin/clang-format "$_"
```

Add `~/usr/bin` to PATH

MacVim reads the PATH variable in `~/.zprofile` instead of `~/.zshrc`


```
echo 'export PATH=$HOME/usr/bin:$PATH' >> ~/.zprofile
```


#### Build Vim

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
    --enable-luainterp \
    --with-features=huge
```

#### Set up Vim

Clone this repository and symlink dotfiles

```
cd ~
git clone git@github.com:daeyun/dotfiles.git
ln -nsf ~/dotfiles/.vim* .
echo 'alias vimm="vim -u ~/.vimrc.min"' >> ~/.zshrc
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
