#!/bin/bash
# ********************************* By hatshex *******************************
# Recibe $1 origin repo, $2 username, $3 remote repo, $4 shortcut remote repo
# Pre-requisitos, el archivo debe tener permisos de ejecución, en caso de que no: sudo chmod +x configurescript.sh
# Ejemplos de ejecución: 
# ./configurescript.sh intro-to-data-science hatshex ITAM-DS introDS hatshex@gmail.com
# ./configurescript.sh programming-for-ds hatshex ITAM-DS pfds hatshex@gmail.com
# ********************************* By hatshex *******************************

git config --global user.name $2
git config --global user.email $5
git config --global color.ui "auto"
git config --global core.editor "emacs"
git init
git clone https://github.com/$2/$1.git
cd  $1
git pull origin master
git remote add $4 https://github.com/$3/$1.git
git pull $4 master
git push origin master
