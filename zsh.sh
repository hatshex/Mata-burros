
sudo apt-get install -y zsh

## Forzamos que el shell del usuario sea zsh
sudo chsh -s /bin/zsh hatshex

## Instalamos Oh-my-ZSH
sudop git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
