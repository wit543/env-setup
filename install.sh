  
#!/usr/bin/env bash

# Exit on error
set -e

# Exit on error in any of pipe commands
set -o pipefail


if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else 
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

#INSTALL PACKAGE
echo "Install Pacakge"
if [[ $OS == *'Ubuntu'* ]]; then    
    # sudo apt update
    PKM="sudo apt install -y"
elif [[ $OS == *'Linux'* ]]; then    
    sudo pacman -Syu --noconfirm
    PKM="sudo pacman -Sy --noconfirm"
    echo $PKM
fi 

for i in `cat package.txt | tr ',' '\n'`; do $PKM $i ; done 

echo "Installing zsh ..."

gitClone() {
    echo $1 $2
    if [ ! -d "$2" ]; then
        git clone --depth=1 $1 $2
    fi
}

if [ ! -d "`echo ~`/.oh-my-zsh" ]; then
    echo "Installing zsh ..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    chsh -s /bin/zsh
fi

gitClone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions 
gitClone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo "Installing PowerLevel10K"
gitClone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

echo "Installing fzf"
gitClone https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

echo "Installing Tmux"
gitClone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#INSTALL Anaconda
echo "Installing Ananconda"
if [ ! -d "~/anaconda3" ]; then
    wget https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh -O Anaconda.sh
    sh Anaconda.sh -b
    rm Anaconda.sh
    export PATH="~/anaconda3/bin:$PATH"
    conda config --set auto_activate_base false
fi

#Link config
echo "Symlink"
ln -sf `pwd`/config/.zshrc ~
ln -sf `pwd`/config/.p10k.zsh ~
ln -sf `pwd`/config/.tmux.conf ~
ln -sf `pwd`/config/.tmux.conf.local ~
mkdir -p ~/.config/nvim/
ln -sf `pwd`/config/init.vim ~/.config/nvim/
ln -sf `pwd`/config/.vimrc ~
ln -sf `pwd`/config/.gvimrc ~
ln -sf `pwd`/config/.vim.function ~
mkdir -p ~/.vim/colors
ln -sf `pwd`/config/colors/gruvbox.vim ~/.vim/colors


# Config VIM
vim +PlugInstall +qall



zsh
