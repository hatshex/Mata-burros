## Agregamos el repositorio de GNU/Emacs 
sudo apt-add-repository ppa:ubuntu-elisp/ppa && \
    apt-get -qq update && \
    apt-get -y install emacs-snapshot
    
## Usamos como emacs la versión snapshot 
sudo update-alternatives --set emacs /usr/bin/emacs-snapshot

sudo echo "es_MX.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen es_MX.utf8 \
    && /usr/sbin/update-locale LANG=es_MX.UTF-8
