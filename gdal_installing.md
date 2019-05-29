```
sudo add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable
sudo apt update
sudo apt upgrade
sudo apt install gdal-bin libgdal-dev

pip install --global-option=build_ext --global-option="-I/usr/include/gdal" GDAL==`gdal-config --version`

```
